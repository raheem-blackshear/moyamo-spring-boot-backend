package net.infobank.moyamo.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.repository.UserRepository;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

@Slf4j
@AllArgsConstructor
@Component
public class UserDetailsServiceImpl implements UserDetailsService {

    private final UserRepository userRepository;

    @Override
    @Transactional(readOnly=true)
	public UserDetails loadUserByUsername(final String providerId) throws UsernameNotFoundException {

		String provider = "phone";
    	if(providerId.contains("@")) {
    		provider = "email";
		}

    	User loginUser = userRepository.findByProviderIdAndProvider(providerId, provider).orElseThrow(() -> new UsernameNotFoundException("providerId " + providerId + " not found"));

    	String roleName = loginUser.getRole().name();
    	log.info("providerId : {}, Role : {}", providerId, roleName);

        Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
        //유저의 EMAIL로 권한을 Auth 객체에 설정
        grantedAuthorities.add(new SimpleGrantedAuthority(roleName));

		loginUser.getExpertGroup().forEach(userExpertGroup -> grantedAuthorities.add(new SimpleGrantedAuthority(userExpertGroup.getExpertGroup().name())));

        String password = (("phone".equalsIgnoreCase(provider)) ? loginUser.getSecurity().getSalt() + "[DELIMITER]" : "") + loginUser.getSecurity().getPassword();
        return new org.springframework.security.core.userdetails.User(providerId, password, grantedAuthorities);
    }


}
