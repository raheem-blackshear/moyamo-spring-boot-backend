package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.ShareDto;
import net.infobank.moyamo.dto.TagDto;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.service.ShareService;
import net.infobank.moyamo.service.TagService;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

@SuppressWarnings("java:S4684")
@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/v2/dictionaries")
public class DictionaryController {

    private final TagService tagService;
    private final ShareService shareService;

    @JsonView(Views.BaseView.class)
    @GetMapping(path = "/{name}")
    public CommonResponse<String> doFindDictionary(@PathVariable String name) {
        TagDto tagDto = tagService.findTag(name);
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), "http://cms.moyamo.co.kr/plant/" + tagDto.getName());
    }

    @JsonView(Views.BaseView.class)
    @PostMapping(path = "/{name}/share")
    public CommonResponse<ShareDto> doShareDictionary(@PathVariable String name, @ApiIgnore User currentUser) {
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), shareService.doShareDictionary(currentUser, name));
    }

}
