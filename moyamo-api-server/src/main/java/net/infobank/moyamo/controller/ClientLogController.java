package net.infobank.moyamo.controller;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.PostingDto;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequestMapping("/v2/logs")
@RestController
public class ClientLogController {
    @PostMapping(path = "")
    public CommonResponse<List<PostingDto>> doLogging(@RequestBody String body) {
        if(body != null && !body.isEmpty()) {
            log.info(body.replaceAll("(\r\n|\r|\n|\n\r)", ""));
        }
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), null);
    }
}
