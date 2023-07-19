package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.NotificationAdminDto;
import net.infobank.moyamo.enumeration.EventType;
import net.infobank.moyamo.enumeration.ExpertGroup;
import net.infobank.moyamo.form.admin.RegistNotificationVo;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.NotificationAdmin;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.service.AdminNotificationService;
import net.infobank.moyamo.service.NotificationService;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 포스팅 관련 rest api
 *
 * @author jspark
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/rest/notification")
public class RestAdminNotificationController {

	private final AuthUtils authUtils;
	private final NotificationService notificationService;
	private final AdminNotificationService adminNotificationService;

	// USER 리스트 조회
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/getList")
    public ResponseEntity<Map<String, Object>> getList(@RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {
    	Map<String, Object> map = new HashMap<>();

		List<NotificationAdminDto> notificationList;
		if (query == null || query.length()<=0) {
			notificationList = adminNotificationService.findAll(PageRequest.of(start/length, length, Sort.by(Sort.Direction.DESC, "id")));

		} else {
			notificationList = null;
		}
		Long totalCnt = adminNotificationService.getTagCount();
    	map.put("recordsTotal", totalCnt);
    	map.put("recordsFiltered", totalCnt);
    	log.info("start[{}], length[{}], totalCnt[{}], draw[{}]", start, length, totalCnt, draw);
    	map.put("draw", draw);
    	map.put("data", notificationList);

        return new ResponseEntity<>(map, HttpStatus.OK);
    }

	// 알림 등록
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/regist")
	@Transactional(isolation = Isolation.SERIALIZABLE, rollbackFor = Exception.class)
    public ResponseEntity<Map<String, Object>> registNotification(@ModelAttribute RegistNotificationVo vo) throws IOException, InterruptedException {

		Map<String, Object> map = new HashMap<>();

		User loginUser = authUtils.getCurrentUser();

		NotificationAdmin notification = adminNotificationService.createNotification(vo, loginUser);

		adminNotificationService.save(notification);

		return new ResponseEntity<>(map, HttpStatus.OK);
    }

	// 알림 등록자에게 테스트 발송
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/testSend")
	@Transactional(isolation = Isolation.SERIALIZABLE, rollbackFor = Exception.class)
	public ResponseEntity<Map<String, Object>> testNotification(@ModelAttribute RegistNotificationVo vo) throws IOException, InterruptedException {

		Map<String, Object> map = new HashMap<>();

		User loginUser = authUtils.getCurrentUser();

		NotificationAdmin notification = adminNotificationService.createNotification(vo, loginUser);
		notification.setTargetGroup(ExpertGroup.TEST);

		List<User> recipientWithMentionUsers = new ArrayList<>();
		recipientWithMentionUsers.add(loginUser);

//		발송 요청
		notificationService.afterNewAdminCustom(notification, recipientWithMentionUsers, EventType.ADMIN_CUSTOM_TEST);

		return new ResponseEntity<>(map, HttpStatus.OK);
	}


	// 알림 수정
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/modify/{notificationId}")
	@Transactional(isolation = Isolation.SERIALIZABLE, rollbackFor = Exception.class)
    public ResponseEntity<Map<String, Object>> modifyNotification(@PathVariable(name = "notificationId") Long notificationId, @ModelAttribute RegistNotificationVo vo) throws IOException, InterruptedException {

		Map<String, Object> map = new HashMap<>();

		User loginUser = authUtils.getCurrentUser();

		NotificationAdmin notification = adminNotificationService.findById(notificationId);
		NotificationAdmin modifyNotification = adminNotificationService.modifyNotification(notification, vo, loginUser);

		adminNotificationService.save(modifyNotification);
		return new ResponseEntity<>(map, HttpStatus.OK);
    }

	// 알림 삭제
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/remove/{notificationId}")
	@Transactional(isolation = Isolation.SERIALIZABLE, rollbackFor = Exception.class)
    public ResponseEntity<Map<String, Object>> removeNotification(@PathVariable(name = "notificationId") Long notificationId, @ModelAttribute RegistNotificationVo vo) {
		Map<String, Object> map = new HashMap<>();
		NotificationAdmin notification = adminNotificationService.findById(notificationId);
		adminNotificationService.delete(notification);
		return new ResponseEntity<>(map, HttpStatus.OK);
    }

}
