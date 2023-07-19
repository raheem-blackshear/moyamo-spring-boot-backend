package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.NotificationDto;
import net.infobank.moyamo.dto.UserSettingDto;
import net.infobank.moyamo.form.UserPushTokenVo;
import net.infobank.moyamo.form.UserSettingVo;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.service.NotificationService;
import net.infobank.moyamo.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.util.List;

@SuppressWarnings("java:S4684")
@Api(tags = {"4. 푸시토큰 관리"})
@RestController
@AllArgsConstructor
@RequestMapping("/v2/notifications")
public class NotificationController {

    private final NotificationService notificationService;
    private final UserService userService;

    @ApiIgnore
    @JsonView(Views.BaseView.class)
    @GetMapping(path = "")
    public CommonResponse<List<NotificationDto>> findList(@ApiIgnore User currentUser, @RequestParam(required = false) Long sinceId, @RequestParam(required = false) Long maxId, @RequestParam(required = false, defaultValue = "10") int count) {
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), notificationService.list(currentUser, sinceId, maxId, count));
    }

    @ApiIgnore
    @PostMapping(path = "/markRead")
    public CommonResponse<Boolean> doMarkAllRead(@ApiIgnore User currentUser) {
        notificationService.markAllRead(currentUser);
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), true);
    }

    @ApiIgnore
    @PostMapping(path = "/{id}/markRead")
    public CommonResponse<Boolean> doMarkRead(@ApiIgnore User currentUser, @PathVariable long id) {
        notificationService.markRead(currentUser, id);
        return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), true);
    }

    /**
     * 사용자 디바이스 PUSH 토큰 추가
     */
    @ApiOperation(value="사용자 디바이스 PUSH 토큰 추가")
    @PostMapping("/token")
    public ResponseEntity<CommonResponse<Object>> createUserPushToken(@ApiIgnore User user, @RequestBody UserPushTokenVo userPushTokenDto) {

        // 추가된 사용자 PUSH TOKEN
        // 현재는 해당값 전달X
        userService.createUserPushToken(user, userPushTokenDto.getToken(), userPushTokenDto.getDeviceId(), userPushTokenDto.getOsType());
        return ResponseEntity.ok(new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), null, "사용자 디바이스 PUSH 토큰 등록 성공"));
    }

    /**
     * 사용자 디바이스 PUSH 토큰 삭제
     */
    @ApiOperation(value="사용자 디바이스 PUSH 토큰 삭제")
    @DeleteMapping("/token")
    public ResponseEntity<CommonResponse<Object>> deleteUserPushToken(@ApiIgnore User user, @RequestParam("device_id") String deviceId) {
        // 삭제 결과
        userService.deleteUserPushToken(user, deviceId);
        return ResponseEntity.ok(new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), null, "사용자 디바이스 PUSH 토큰 삭제 성공"));
    }

    /**
     * 사용자 알림 설정
     */
    @ApiOperation(value="사용자 알림 조회")
    @GetMapping("/setting")
    public ResponseEntity<CommonResponse<UserSettingDto>> doFindSetting(@ApiIgnore User user) {
        return ResponseEntity.ok(new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), UserSettingDto.of(user.getUserSetting()), "조회 성공"));
    }

    /**
     * 사용자 알림 설정
     */
    @ApiOperation(value="사용자 알림 설정")
    @PostMapping("/setting")
    public ResponseEntity<CommonResponse<UserSettingDto>> doUpdateSetting(@ApiIgnore User user, @RequestBody UserSettingVo vo) {
        return ResponseEntity.ok(new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), userService.updateSetting(user, vo), "설정 성공"));
    }

}
