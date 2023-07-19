package net.infobank.moyamo.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Aspect
@Component
public class AdminRestAspect {
	private static final Logger logger = LoggerFactory.getLogger(AdminRestAspect.class);


	@Pointcut("execution(* *..RestAdmin*Controller.*(..))")
	public void restApiControllerAdvice() {
		//
	}

	@SuppressWarnings("unchecked")
	@Around(value = "restApiControllerAdvice() && args(..)")
	public Object restApiControllerAdviceAround(ProceedingJoinPoint pjp) throws Throwable {
		String className = pjp.getTarget().getClass().getName();
		String methodName = pjp.getSignature().getName();
		String taskName = className + "." + methodName;
		logger.info("restApiControllerAdvice() Execution START {}",  taskName);
		Object response = pjp.proceed();
		if(response instanceof Map) {
			ResponseEntity<Map<String, Object>> responseEntity = (ResponseEntity<Map<String, Object>>) response;
			Map<String, Object> map = responseEntity.getBody();
			HttpHeaders headers = new HttpHeaders();
			String dataType = null;
			int resultCode = 1001;

			if(map != null && map.get("data") != null && map.get("data") != "null" && map.get("data") != "") {
				dataType = (map.get("data") instanceof List) ? "list" : "object";
				resultCode = 1000;
			}

			if(map == null) {
				map = new HashMap<>();
			}

			map.put("dataType", dataType);
			map.put("resultCode", resultCode);
			logger.info("[restApiControllerAdvice() Execution END]");
			return new ResponseEntity<>(map, headers, HttpStatus.OK);
		} else {
			return response;
		}
	}
}
