package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.ShareDto;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.service.ShareService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/v2/shares")
public class ShareController {

    private final ShareService shareService;

    @JsonView(Views.PostingLikeOnlyJsonView.class)
    @GetMapping(path = "/{uuid}")
    public CommonResponse<ShareDto> findShare(@PathVariable UUID uuid) {
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), shareService.findShare(uuid));
    }

}
