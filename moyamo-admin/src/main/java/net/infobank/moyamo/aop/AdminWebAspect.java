package net.infobank.moyamo.aop;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.util.AuthUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@AllArgsConstructor
@Aspect
@Component
public class AdminWebAspect {

	private final AuthUtils authUtils;

	@Around("execution(* *..WebAdmin*Controller.*(..))")
	public Object aroundControllerAdvice(ProceedingJoinPoint pjp) throws Throwable {
		String className = pjp.getTarget().getClass().getName();
		String methodName = pjp.getSignature().getName();
		String taskName = className + "." + methodName;

		log.info("WebAdminControllerAdvice() Execution START : {}", taskName);

		User loginUser = authUtils.getCurrentUser();
		String accountRole = SecurityContextHolder.getContext().getAuthentication().getAuthorities().iterator().next().getAuthority();
		log.info("task name : {}, id : {}, role : {}", taskName, authUtils.getCurrentUser().getProvider(), accountRole);

		Object[] object = pjp.getArgs();
		String requestUri = "";
		for(Object obj : object) {
			if(obj instanceof HttpServletRequest) {
				HttpServletRequest request = (HttpServletRequest)obj;
				requestUri = request.getRequestURI();
			} else if(obj instanceof Model) {

				Model model = (Model) obj;
				model.addAttribute("role", accountRole);
				model.addAttribute("nick_name", loginUser.getNickname());
				model.addAttribute("isPhotoEnable", loginUser.getUserSetting().getPhotoEnable());
				log.info("model user : {} setting : {} photoEnable : {}", loginUser, loginUser.getUserSetting(), loginUser.getUserSetting().getPhotoEnable());
			}
		}

		log.info("className : {}, taskName : {}, requestUri : {}", className, taskName, requestUri);
		return pjp.proceed();
	}
}
