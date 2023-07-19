package net.infobank.moyamo.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Slf4j
public class AccessLogger {

    private AccessLogger() throws IllegalAccessException {
        throw new IllegalAccessException("AccessLogger is static");
    }

    private static final ObjectMapper objectWriter = new ObjectMapper().disable(MapperFeature.DEFAULT_VIEW_INCLUSION);

    private static Long getStartTime(HttpServletRequest request) {
        Object obj = request.getAttribute("startTime");
        if (obj != null)
            return (Long) request.getAttribute("startTime");
        else
            return null;
    }

    public static final void log(HttpServletRequest request, HttpServletResponse response) {
        Long startTime = getStartTime(request);
        long executionTime = (startTime != null) ? System.currentTimeMillis() - startTime : 0L;

        String resultMsg = Optional.ofNullable(request.getAttribute("resultMsg")).map(Object::toString).orElse("");
        String resultCode = Optional.ofNullable(request.getAttribute("resultCode")).map(Object::toString).orElse("");

        Map<String, Object> accessLogMap = new HashMap<>();
        Map<String, String> headers = new HashMap<>();

        Enumeration<String> element = request.getHeaderNames();

        while (element.hasMoreElements()) {
            String headerName = element.nextElement();
            String headerValue = request.getHeader(headerName);
            headers.put(headerName, headerValue);
        }

        accessLogMap.put("headers", headers);
        accessLogMap.put("client", request.getServerName());
        accessLogMap.put("method", request.getMethod());
        accessLogMap.put("host", request.getRemoteHost());

        String requestWithQueryString = (request.getQueryString() == null) ? request.getRequestURI() : request.getRequestURI() + "?" + request.getQueryString();
        accessLogMap.put("uri", requestWithQueryString);
        accessLogMap.put("code", response.getStatus());
        accessLogMap.put("time", executionTime);
        accessLogMap.put("resultMsg", resultMsg);
        accessLogMap.put("resultCode", resultCode);

        try {
            log.info(objectWriter.writeValueAsString(accessLogMap));
        } catch (JsonProcessingException ex) {
            log.error("AccessLogger.log", ex);
        }
    }
}
