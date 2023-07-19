package net.infobank.moyamo.aspect;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.dto.swagger.response.UserInfoAndUserTokenDto;
import net.infobank.moyamo.models.UserLoginHistory;
import net.infobank.moyamo.repository.UserLoginHistoryRepository;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import java.time.ZonedDateTime;

@Slf4j
@Aspect
@Component
@RequiredArgsConstructor
public class LoginAspect {

    private final UserLoginHistoryRepository userLoginHistoryRepository;

    @SuppressWarnings("unused")
    @Pointcut("execution(* net.infobank.moyamo.controller.AuthorizationController.login*(..) )")
    public void loginAdvice() {
        //
    }

    @AfterReturning(value = "execution(* net.infobank.moyamo.controller.AuthorizationController.login*(..))", returning = "returnValue")
    public void writeSuccessLog(JoinPoint joinPoint, CommonResponse<UserInfoAndUserTokenDto> returnValue) {

        if(log.isDebugEnabled()) {
            log.debug("writeSuccessLog joinPoint : {}", joinPoint);
        }

    	if(returnValue.getResultCode() == 1000) {

    		Long userId = returnValue.getResultMessage().getUserInfo().getId();
    		String accessToken = returnValue.getResultMessage().getUserToken(); //발급 받은 토큰 저장

    		UserLoginHistory userLoginHistory = new UserLoginHistory();
    		userLoginHistory.setUserId(userId);
    		userLoginHistory.setAccessToken(accessToken);
            userLoginHistory.setCreatedAt(ZonedDateTime.now());
    		userLoginHistoryRepository.save(userLoginHistory);
    	}
        //logging
        //returnValue 는 해당 메서드의 리턴객체를 그대로 가져올 수 있다.
    }

}
