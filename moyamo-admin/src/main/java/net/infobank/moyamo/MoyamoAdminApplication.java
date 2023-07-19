package net.infobank.moyamo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableFeignClients(basePackages = "net.infobank.moyamo")
@EnableScheduling
@SpringBootApplication
public class MoyamoAdminApplication {
	public static void main(String[] args) {
		SpringApplication.run(MoyamoAdminApplication.class, args);
	}
}
