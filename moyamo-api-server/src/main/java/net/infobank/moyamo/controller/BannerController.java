package net.infobank.moyamo.controller;

import lombok.AllArgsConstructor;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.BannerDto;
import net.infobank.moyamo.enumeration.BannerStatus;
import net.infobank.moyamo.form.CreateBannerVo;
import net.infobank.moyamo.service.BannerService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@AllArgsConstructor
@RestController
@RequestMapping("/v2/banners")
public class BannerController {

    private final BannerService bannerService;

    @RequestMapping("/create")
    public BannerDto create(@Valid CreateBannerVo vo) throws IOException, InterruptedException {
        return bannerService.createBanner(vo);
    }

    @RequestMapping("")
    public CommonResponse<List<BannerDto>> doFindList() {
        return new CommonResponse<>(CommonResponseCode.SUCCESS, bannerService.findList(0, 10, Optional.of(BannerStatus.open))) ;
    }



}
