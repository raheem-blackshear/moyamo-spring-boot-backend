package net.infobank.moyamo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
@EnableFeignClients(basePackages = "net.infobank.moyamo.*")
@ComponentScan(value = "net.infobank.moyamo.*")
public class MoyamoApplication {

    public static void main(String[] args) {
        SpringApplication.run(MoyamoApplication.class, args);
    }

}
