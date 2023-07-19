package net.infobank.moyamo.configuration;

import net.infobank.moyamo.common.configurations.AccessLoggingInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    final AccessLoggingInterceptor accessLoggingInterceptor;

    public WebMvcConfig(AccessLoggingInterceptor accessLoggingInterceptor) {
        this.accessLoggingInterceptor = accessLoggingInterceptor;
    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**").allowedMethods("GET", "POST", "PATCH", "PUT");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**").addResourceLocations("/static/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(accessLoggingInterceptor).addPathPatterns("/**");
    }

}
