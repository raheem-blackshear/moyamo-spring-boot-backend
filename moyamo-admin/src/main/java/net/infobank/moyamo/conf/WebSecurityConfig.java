package net.infobank.moyamo.conf;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.enumeration.UserRole;
import net.infobank.moyamo.repository.UserRepository;
import net.infobank.moyamo.service.CustomOAuth2UserService;
import net.infobank.moyamo.util.AuthUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.security.oauth2.client.OAuth2ClientProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.env.Environment;
import org.springframework.http.RequestEntity;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.oauth2.client.CommonOAuth2Provider;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.bcrypt.MoyamoPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.endpoint.DefaultAuthorizationCodeTokenResponseClient;
import org.springframework.security.oauth2.client.endpoint.OAuth2AccessTokenResponseClient;
import org.springframework.security.oauth2.client.endpoint.OAuth2AuthorizationCodeGrantRequest;
import org.springframework.security.oauth2.client.endpoint.OAuth2AuthorizationCodeGrantRequestEntityConverter;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@AllArgsConstructor
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	private static final String FACEBOOK = "facebook";

	private final UserDetailsService userDetailsService;
	private final UserRepository userRepository;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;


	private final Environment environment;

	private final AuthUtils authUtils;


	/**
	 * actuator 접근 IP 목록
	 * @return String
	 */
	private String getAllowIpExps() {

		String strAllowIps = environment.getProperty("spring.actuator.allowIps");

		List<String> allowIpExps = new ArrayList<>();
		// 기본 IP 목록
		allowIpExps.add("127.0.0.1");
		allowIpExps.add("0:0:0:0:0:0:0:1");

		if(StringUtils.isNotBlank(strAllowIps)) {
			String[] envAllowIpExps = strAllowIps.split(",");
			for (String ipExps : envAllowIpExps) {
				String envIp = ipExps.trim();
				if (envIp.isEmpty())
					continue;

				allowIpExps.add(envIp);
			}
		}

		StringBuilder builder = new StringBuilder();

		String sep = "";
		for (String ipExps : allowIpExps) {

			builder.append(sep);

			builder.append("hasIpAddress('");
			builder.append(ipExps);
			builder.append("')");

			sep = " or ";
		}

		return builder.toString();
	}



	@Bean
	public PasswordEncoder passwordEncoder() {
		return new MoyamoPasswordEncoder(bCryptPasswordEncoder);
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception{

		String attribute = getAllowIpExps();

		http
		.csrf().disable()
		.authorizeRequests()
			// 해당 url을 허용한다.
			.antMatchers("/actuator").access(attribute)
			.antMatchers("/actuator/**").access(attribute)
			.antMatchers("/static/**","/loginError","/login").permitAll()

			//개발용 !!
			// .antMatchers("/**").permitAll()
			//.antMatchers("/static/**","/loginError","/login","/rest/**")
			.antMatchers("/admin/**").hasAnyAuthority(UserRole.ADMIN.name(),  UserRole.EXPERT.name(), UserRole.USER.name())
			.antMatchers("/rest/**").hasAnyAuthority(UserRole.ADMIN.name(),  UserRole.EXPERT.name(), UserRole.USER.name())
			//.antMatchers("/expert/**").hasAnyAuthority(UserRole.ADMIN.name(), UserRole.EXPERT.name())
			.anyRequest().authenticated()
			.and()
				.formLogin()
				.successHandler(new CustomAuthenticationSuccess(authUtils)) // 로그인 성공 핸들러
				.failureHandler(new CustomAuthenticationFailure()) // 로그인 실패 핸들러
            .and()
            .oauth2Login()
            .tokenEndpoint()
            .accessTokenResponseClient(accessTokenResponseClient())
            .and()
            .userInfoEndpoint().userService(new CustomOAuth2UserService(userRepository))  // 네이버 USER INFO의 응답을 처리하기 위한 설정
        .and()
			.successHandler(new CustomAuthenticationSuccess(authUtils)) // 로그인 성공 핸들러
			.failureHandler(new CustomAuthenticationFailure()) // 로그인 실패 핸들러
        .and()
            .exceptionHandling()
            .authenticationEntryPoint(new LoginUrlAuthenticationEntryPoint("/login"))

		;
	}

	@Bean
	public OAuth2AccessTokenResponseClient<OAuth2AuthorizationCodeGrantRequest> accessTokenResponseClient() {
		DefaultAuthorizationCodeTokenResponseClient accessTokenResponseClient = new DefaultAuthorizationCodeTokenResponseClient();
		accessTokenResponseClient.setRequestEntityConverter(new CustomRequestEntityConverter());
		return accessTokenResponseClient;
	}

	public static class CustomRequestEntityConverter
			implements Converter<OAuth2AuthorizationCodeGrantRequest, RequestEntity<?>> {

		private final OAuth2AuthorizationCodeGrantRequestEntityConverter defaultConverter;

		public CustomRequestEntityConverter() {
			defaultConverter = new OAuth2AuthorizationCodeGrantRequestEntityConverter();
		}

		@Override
		public RequestEntity<?> convert(@NonNull OAuth2AuthorizationCodeGrantRequest req) {
			RequestEntity<?> entity = defaultConverter.convert(req);
			MultiValueMap<String, String> params = (MultiValueMap<String, String>) entity.getBody();
			if(params == null)
				params = new LinkedMultiValueMap<>();

			String url = params.getFirst("redirect_uri");
			if (url != null && url.contains(FACEBOOK)) {
				url = url.replace("http", "https");
			}
			params.set("redirect_uri", url);
			if(log.isDebugEnabled()) {
				log.debug("Callback Request Parameters: {}", params.toSingleValueMap());
			}
			return new RequestEntity<>(params, entity.getHeaders(), entity.getMethod(), entity.getUrl());
		}
	}

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
	}

    @Bean
    public ClientRegistrationRepository clientRegistrationRepository(
            OAuth2ClientProperties oAuth2ClientProperties,
            @Value("${custom.oauth2.kakao.client-id}") String kakaoClientId,
            @Value("${custom.oauth2.kakao.client-secret}") String kakaoClientSecret,
            @Value("${custom.oauth2.naver.client-id}") String naverClientId,
            @Value("${custom.oauth2.naver.client-secret}") String naverClientSecret) {
        List<ClientRegistration> registrations = oAuth2ClientProperties
                .getRegistration().keySet().stream()
                .map(client -> getRegistration(oAuth2ClientProperties, client))
                .filter(Objects::nonNull)
                .collect(Collectors.toList());

        registrations.add(CustomOAuth2Provider.KAKAO.getBuilder("kakao")
                    .clientId(kakaoClientId)
                    .clientSecret(kakaoClientSecret)
                    .jwkSetUri("temp")
                    .build());

        registrations.add(CustomOAuth2Provider.NAVER.getBuilder("naver")
                .clientId(naverClientId)
                .clientSecret(naverClientSecret)
                .jwkSetUri("temp")
                .build());
        return new InMemoryClientRegistrationRepository(registrations);
    }

    private ClientRegistration getRegistration(OAuth2ClientProperties clientProperties, String client) {
        if("google".equals(client)) {
            OAuth2ClientProperties.Registration registration = clientProperties.getRegistration().get("google");
            return CommonOAuth2Provider.GOOGLE.getBuilder(client)
                    .clientId(registration.getClientId())
                    .clientSecret(registration.getClientSecret())
                    .scope("email", "profile")
                    .build();
        }

        if(FACEBOOK.equals(client)) {
            OAuth2ClientProperties.Registration registration = clientProperties.getRegistration().get(FACEBOOK);
            return CommonOAuth2Provider.FACEBOOK.getBuilder(client)
                    .clientId(registration.getClientId())
                    .clientSecret(registration.getClientSecret())
                    .userInfoUri("https://graph.facebook.com/me?fields=id,name,email,link")
                    .scope("email")
                    .build();
        }
        return null;
    }

}
