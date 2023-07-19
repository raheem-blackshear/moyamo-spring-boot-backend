package net.infobank.moyamo.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.service.RedirectLinkService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 공지사항, 이용약관, 개인정보취급방침, 위치정보이용약관 주소 조회
 */

@Slf4j
@RequestMapping("/v2/policies")
@AllArgsConstructor
@RestController
public class PolicyController {

    private final RedirectLinkService policyService;

    @RequestMapping("/page/{name}")
    public CommonResponse<String> doGetPage(@PathVariable("name") String name) {
        return new CommonResponse<>( CommonResponseCode.SUCCESS , policyService.findPageUrl(name));
    }

}
