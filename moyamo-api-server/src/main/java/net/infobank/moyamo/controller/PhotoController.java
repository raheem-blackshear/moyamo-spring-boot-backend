package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.dto.UserDto;
import net.infobank.moyamo.exception.MoyamoGlobalException;
import net.infobank.moyamo.form.CreatePhotoVo;
import net.infobank.moyamo.form.CreateReportVo;
import net.infobank.moyamo.form.UpdatePhotoVo;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.Ranking;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.service.PhotoRecentWriterService;
import net.infobank.moyamo.service.PostingService;
import net.infobank.moyamo.service.RankingService;
import net.infobank.moyamo.service.UserService;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cloud.client.circuitbreaker.CircuitBreaker;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import javax.validation.Valid;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Collections;
import java.util.List;

@SuppressWarnings("java:S4684")
@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/v2/photos")
public class PhotoController {

    private final PostingService postingService;
    private final UserService userService;
    private final RankingService rankingService;
    @Qualifier("postingCircuitBreaker")
    private final CircuitBreaker cb;
    private final PhotoRecentWriterService photoRecentWriterService;

    /**
     * 포토
     * */
    @JsonView(Views.PostingActivityDetailJsonView.class)
    @GetMapping(path = "/{id}")
    public CommonResponse<PostingDto> doReadPosting(@PathVariable Long id, @ApiIgnore User currentUser) {
        return cb.run(() -> postingService.doReadPosting(id, currentUser), throwable -> {
            log.error("readPosting", throwable);
            return new CommonResponse<>(CommonResponseCode.FAIL.getResultCode(), null, "잠시 후 다시 접속해주세요.");
        });
    }

    @JsonView(Views.BaseView.class)
    @PostMapping(path = "")
    public CommonResponse<List<PostingDto>> doCreatePhotoPosting(@Valid CreatePhotoVo createPhotoVo, @ApiIgnore User currentUser) {
        List<PostingDto> postingDtos = postingService.createPhotoPosting(createPhotoVo, currentUser, true);
        userService.userIndexing(currentUser.getId());
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), postingDtos, "");
    }

    @JsonView(Views.BaseView.class)
    @PutMapping( path = "/{id}")
    public CommonResponse<PostingDto> doUpdatePhotoPosting(@PathVariable("id") Long id, @Valid UpdatePhotoVo updatePhotoVo, @ApiIgnore User currentUser) {
        PostingDto postingDto = postingService.updatePhotoPosting(id, updatePhotoVo, currentUser);
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), postingDto, "");
    }

    @JsonView(Views.BaseView.class)
    @PutMapping( path = "/move")
    public CommonResponse<Boolean> doMovePhotoPosting(@RequestParam(value = "id", required = false) List<Long> ids, @RequestParam("beforeAlbumName") String beforeAlbumName, @RequestParam("afterAlbumName") String afterAlbumName, @ApiIgnore User currentUser, @RequestParam(value = "all", required = false, defaultValue = "false") Boolean all) {
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), postingService.movePhotoPosting(ids, beforeAlbumName, afterAlbumName, currentUser, all), "");
    }


    @JsonView(Views.BaseView.class)
    @PutMapping(path = "/delete")
    public CommonResponse<List<PostingDto>> doRemovePhotoPosting(@RequestParam(value = "id", required = false) List<Long> ids, @ApiIgnore User currentUser, @RequestParam(required = false, defaultValue = "전체") String albumName, @RequestParam(value = "all", required = false, defaultValue = "false") Boolean all) {
        return cb.run(() -> {
            try {
                List<PostingDto> postingDtoList = postingService.deletePhotoPosting(ids, currentUser, albumName, all);
                userService.userIndexing(currentUser.getId());
                return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), postingDtoList, albumName);
            } catch (MoyamoGlobalException e) {
                return new CommonResponse<>(CommonResponseCode.FAIL.getResultCode(), null, e.getMessage());
            }
        }, throwable -> {
            log.error("doRemovePhoto", throwable);
            return new CommonResponse<>(CommonResponseCode.FAIL.getResultCode(), null, throwable.getMessage());
        });
    }

    /**
     * 포토 복사
     * */
    @PutMapping("/copy")
    public CommonResponse<Boolean> doCopyPhotoPosting(@RequestParam(value = "id", required = false) List<Long> ids, @RequestParam("afterAlbumNames") List<String> afterAlbumNames, @ApiIgnore User currentUser, @RequestParam(value = "all", required = false, defaultValue = "false") Boolean all,  @RequestParam(value = "currentAlbumName", required = false) String currentAlbumName) {
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), postingService.copyPhotoPosting(ids, afterAlbumNames, currentUser, all , currentAlbumName), "");
    }

    /**
     * 신고하기
     * */
    @PostMapping(path = "/{id}/report")
    public CommonResponse<Boolean> doCreateReport(@ApiIgnore User currentUser, @PathVariable Long id, @Valid CreateReportVo vo) {
        return cb.run(() -> postingService.doReportPosting(id, currentUser,vo), throwable -> {
            log.error("doCreateReport", throwable);
            return new CommonResponse<>(CommonResponseCode.FAIL.getResultCode(), null, throwable.getMessage());
        });
    }

    @JsonView(Views.BaseView.class)
    @PostMapping(path = "/{id}/like")
    public CommonResponse<Boolean> doCreateLike(@PathVariable Long id, @ApiIgnore User currentUser) {
        return cb.run(() -> {
            CommonResponse<Boolean> likeCommonResponse = postingService.doLikePosting(id, currentUser);
            postingService.findPosting(id).ifPresent(postingDto -> {
                userService.userIndexing(postingDto.getOwner().getId());
                postingService.indexing(Collections.singletonList(id), null);
            });
            return likeCommonResponse;
        }, throwable -> {
            log.error("doCreateLike", throwable);
            return new CommonResponse<>(CommonResponseCode.FAIL.getResultCode(), null, throwable.getMessage());
        });
    }

    @JsonView(Views.BaseView.class)
    @DeleteMapping(path = "/{id}/like")
    public CommonResponse<Boolean> doRemoveLike(@PathVariable Long id, @ApiIgnore User currentUser) {
        return cb.run(() -> {
            CommonResponse<Boolean> unLikeCommonResponse = postingService.doUnLikePosting(id, currentUser);
            postingService.findPosting(id).ifPresent(postingDto -> {
                userService.userIndexing(postingDto.getOwner().getId());
                postingService.indexing(Collections.singletonList(id), null);
            });
            return unLikeCommonResponse;
        }, throwable -> {
            log.error("doRemoveLike", throwable);
            return new CommonResponse<>(CommonResponseCode.FAIL.getResultCode(), null, throwable.getMessage());
        });
    }

    /**
     * 인기작가
     * */
    @SuppressWarnings("unused")
    @GetMapping("/popularWriters")
    public CommonResponse<List<UserDto>> popularWriter(@ApiIgnore User currentUser){
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), rankingService.findUserRanking(ZonedDateTime.now().withZoneSameInstant(ZoneId.of("Asia/Seoul")), Ranking.RankingType.best_user_by_photo));
    }
}
