package net.infobank.moyamo.interfaces;

import net.infobank.moyamo.domain.badge.TopUsers;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@FeignClient(name="EventServer", url = "${event.server.host:localhost:8085}")
public interface EventServerInterface {

    @GetMapping(path = "/top", headers = {
            "Content-Type=application/json"
    })
    List<TopUsers.UserScore> requestGetUserScores();
}
