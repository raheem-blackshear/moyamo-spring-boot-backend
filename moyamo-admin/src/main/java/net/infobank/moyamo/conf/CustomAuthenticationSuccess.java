package net.infobank.moyamo.conf;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.enumeration.UserRole;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Objects;

@Slf4j
@RequiredArgsConstructor
public class CustomAuthenticationSuccess implements AuthenticationSuccessHandler{
  private final RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

  private final AuthUtils authUtils;

  /**
   * 로그인 성공시 Controller 타기전 수행할 redirect URI
   */
  @Override
  public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
      Authentication authentication) throws IOException, ServletException {

	  log.info("AuthenticationSuccess Login Success - START");

	  GrantedAuthority role = authentication.getAuthorities().iterator().next();
	  String loginUser = authentication.getName();

	  log.info("LOGIN USER : {}", loginUser);
	  if (UserRole.ADMIN.name().equals(role.getAuthority())) {
		  redirectStrategy.sendRedirect(request, response, "/admin");
	  } else if (UserRole.EXPERT.name().equals(role.getAuthority())) {
		  redirectStrategy.sendRedirect(request, response, "/admin");
	  } else {

	  	//photoEnable=true인 사용자만 접근가능
		  if(!Objects.isNull(authUtils.getCurrentUser()) && authUtils.getCurrentUser().getUserSetting().getPhotoEnable()) {
			  System.out.println("authUtils.getCurrentUser().getUserSetting().getPhotoEnable() = " + authUtils.getCurrentUser().getUserSetting().getPhotoEnable());
		  	redirectStrategy.sendRedirect(request, response, "/admin");
		  	return;
		  }

		  HttpSession session= request.getSession(false);
		  SecurityContextHolder.clearContext();
		  if(session != null) {
			  session.invalidate();
		  }
		  for(Cookie cookie : request.getCookies()) {
			  cookie.setMaxAge(0);
		  }
		  request.setAttribute("error_flag", "4");
		  request.getRequestDispatcher("/login").forward(request, response);
	  }

	  log.info("AuthenticationSuccess Login User = {}", role.getAuthority());
  }
}

