package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.api.service.HomeService;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.BannerDto;
import net.infobank.moyamo.dto.GoodsDto;
import net.infobank.moyamo.dto.HomeTotalDto;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.Ranking;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.service.PostingService;
import net.infobank.moyamo.service.RankingService;
import net.infobank.moyamo.util.RequestParamValidator;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cloud.client.circuitbreaker.CircuitBreaker;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Collections;
import java.util.List;

@SuppressWarnings("java:S4684")
@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/v2/home")
public class HomeController {

    private static final List<PostingDto> emptyPostingList = Collections.emptyList();
    private static final List<GoodsDto> emptyGoodsList = Collections.emptyList();
    private static final List<BannerDto> emptyBannerList = Collections.emptyList();

    private final PostingService postingService;
    private final HomeService homeService;
    private final RankingService rankingService;

    @Qualifier("homeCircuitBreaker")
    private final CircuitBreaker cb;

    @JsonView(Views.BaseView.class)
    @GetMapping(path = "")
    public CommonResponse<List<PostingDto>> doSearchHome(@ApiIgnore User currentUser, @RequestParam(value = "postingType", defaultValue = "question") PostingType postingType, @RequestParam(required = false) String q, @RequestParam(defaultValue = "0") int offset, @RequestParam(required = false, defaultValue = "5") int count, @RequestParam(defaultValue = "id") String orderBy, @RequestParam(required = false, defaultValue = "") String sortBy) {
        try {
            RequestParamValidator.validateOrderBy(orderBy);
        } catch (IllegalArgumentException e) {
            return new CommonResponse<>(CommonResponseCode.FAIL.getResultCode(), Collections.emptyList(), e.getMessage());
        }

        return cb.run(() -> {
            if(postingType.equals(PostingType.photo)){
                List<PostingDto> postingDtoList = rankingService.findPostingRanking(ZonedDateTime.now().withZoneSameInstant(ZoneId.of("Asia/Seoul")), Ranking.RankingType.best_photo);
                return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), postingDtoList);
            }

            List<PostingDto> postingDtoList = postingService.findTimeline(currentUser, postingType.getClazz(), null, null, count);
            return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), postingDtoList);
        }, throwable -> {
            log.error("PostingController.search", throwable);
            return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), Collections.emptyList(), throwable.getMessage());
        });
    }

    @JsonView(Views.BaseView.class)
    @GetMapping(path = "/all")
    public CommonResponse<HomeTotalDto> doSearchHomeAll(@ApiIgnore User currentUser) {
        return cb.run(() -> {
            HomeTotalDto homeTotalDto = homeService.findAll(currentUser);
            return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), homeTotalDto);
        }, throwable -> {
            log.error("HomeController.doSearchHomeAll", throwable);
            return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), new HomeTotalDto(emptyPostingList, emptyPostingList, emptyPostingList, emptyPostingList, emptyPostingList, emptyPostingList, emptyPostingList, emptyGoodsList, emptyBannerList, emptyPostingList), throwable.getMessage());
        });
    }

    /**
     * HOME CRUD 확인
     * */
    @PostMapping("/createhome")
    public void createHome(@RequestParam("genre") String genre){
        homeService.createHomeGenre(genre);
    }

    @PutMapping("/updatehomeorder")
    public void updateHomeOrder(@RequestParam("genres") List<String> genres){
        homeService.updateHomeOrder(genres);
    }

    @JsonView(Views.BaseView.class)
    @GetMapping(path = "/order")
    public CommonResponse<List<String>> doFindOrderChange() {
        return cb.run(() -> new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), homeService.getHomeOrder())
            , throwable -> {
            log.error("HomeController.doFindOrder", throwable);
            return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), Collections.emptyList(), throwable.getMessage());
        });
    }
}
