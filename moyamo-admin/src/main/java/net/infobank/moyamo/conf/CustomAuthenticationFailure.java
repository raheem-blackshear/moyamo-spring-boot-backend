package net.infobank.moyamo.conf;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CustomAuthenticationFailure implements AuthenticationFailureHandler {

	private static final Logger logger = LoggerFactory.getLogger(CustomAuthenticationFailure.class);
	private static final String EVENT_FLAG = "error_flag";
	private static final String PROVIDER_ID = "providerId";

	/**
	 * 로그인 실패시
	 */
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		logger.info("AuthenticationFailure Login Failure - START");

		String[] usernames = request.getParameterMap().get("username");

		if(usernames == null) {
			request.setAttribute(EVENT_FLAG, "4");
			request.getRequestDispatcher("/login").forward(request, response);
		}

		String providerId = (usernames != null && usernames.length > 0) ? usernames[0] : "";

		logger.info("login ID : {}", providerId);
		logger.info("로그인 익셉션 : {}", exception.getMessage());

		//계정이 없을 경우
		if(exception.getMessage() == null) {
			request.setAttribute(PROVIDER_ID, providerId);
			request.setAttribute(EVENT_FLAG, "1");
		} else if("Bad credentials".equals(exception.getMessage())) {
			//비밀번호 틀렸을 경우
			request.setAttribute(PROVIDER_ID, providerId);
			request.setAttribute(EVENT_FLAG, "2");
		} else if ("[not_found_moyamo_user] ".equals(exception.getMessage())) {
			request.setAttribute(PROVIDER_ID, providerId);
			request.setAttribute(EVENT_FLAG, "3");
		}

		request.getRequestDispatcher("/login").forward(request, response);
		logger.info("AuthenticationFailure Login Failure - END");
	}
}

