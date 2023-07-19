package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.AdminUserListResultDto;
import net.infobank.moyamo.dto.EmailVerifyInfoDto;
import net.infobank.moyamo.dto.PhoneVerifyInfoDto;
import net.infobank.moyamo.enumeration.ExpertGroup;
import net.infobank.moyamo.enumeration.UserRole;
import net.infobank.moyamo.enumeration.UserStatus;
import net.infobank.moyamo.exception.MoyamoGlobalException;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.models.UserExpertGroup;
import net.infobank.moyamo.repository.UserRepository;
import net.infobank.moyamo.service.AdminUserService;
import net.infobank.moyamo.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.search.FullTextSession;
import org.hibernate.search.jpa.FullTextEntityManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 포스팅 관련 rest api
 * @author jspark
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/rest/user")
public class RestAdminUserController {

	private final EntityManager em;
	private final UserRepository userRepository;
	private final UserService userService;
	private final AdminUserService adminUserService;

	// USER 리스트 조회
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/getList")
    public ResponseEntity<AdminUserListResultDto> getList(@RequestParam("userRole") UserRole userRole , @RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {
        return new ResponseEntity<>(adminUserService.search(start, length, draw, userRole, query), HttpStatus.OK);
    }

	// USER 리스트 조회
	@RequestMapping("/modifyUser")
	public ResponseEntity<Map<String, Object>> modifyUser(@RequestParam("userRole") UserRole userRole ,@RequestParam("userId") Long userId, @RequestParam("expertGroup") String[] expertGroup)  {
		Map<String, Object> map = new HashMap<>();

    	User user = adminUserService.findById(userId).orElseThrow(() -> new MoyamoGlobalException(MoyamoGlobalException.Messages.NOT_FOUND_ENTITY + userId));
    	adminUserService.removeUserExpertGroup(user.getId());
    	List<UserExpertGroup> newGroup = new ArrayList<>();

    	for (String group : expertGroup) {
    		ExpertGroup newgr = ExpertGroup.valueOf(group);
    		UserExpertGroup ueg = new UserExpertGroup();
    		ueg.setExpertGroup(newgr);
    		newGroup.add(ueg);
    	}
    	if (!user.getRole().equals(userRole)) {
    		log.info("권한 변경 : {}, {}->{}", user.getNickname(), user.getRole().name(), userRole);
    		user.setRole(userRole);
    	}
    	user.setExpertGroup(newGroup);
    	adminUserService.save(user);
    	map.put("data", "");
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

	// USER 리스트 조회
	@RequestMapping("/modifyUserStatus")
	public ResponseEntity<Map<String, Object>> modifyUserStatus(@RequestParam("userRole") UserRole userRole ,@RequestParam("userId") Long userId, @RequestParam("userStatus") String userStatus) {
		Map<String, Object> map = new HashMap<>();


		User user = adminUserService.findById(userId).orElseThrow(() -> new MoyamoGlobalException(MoyamoGlobalException.Messages.NOT_FOUND_ENTITY + userId));
		user.setStatus(UserStatus.valueOf(userStatus));

		adminUserService.save(user);
		map.put("data", "");
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

	//
	@RequestMapping("/resetPassword")
	public ResponseEntity<Map<String, Object>> modifyUser(@RequestParam("userId") Long userId, @RequestParam("resetPassword") String resetPassword) {
		Map<String, Object> map = new HashMap<>();
		map.put("data", adminUserService.resetPassword(userId, resetPassword));
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

	//
	@RequestMapping("/memo")
	public ResponseEntity<Map<String, Object>> modifyMemo(@RequestParam("userId") Long userId, @RequestParam("memo") String memo) {
		Map<String, Object> map = new HashMap<>();
		map.put("data", adminUserService.updateMemo(userId, memo));
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

	@RequestMapping("/phoneVerifyInfo/{userId}")
	public ResponseEntity<PhoneVerifyInfoDto> findPhoneVerifyInfo(@PathVariable("userId") Long userId) {

		return userService.findPhoneVerifyInfo(userId).map(result ->
				new ResponseEntity<>(result, HttpStatus.OK)
		).orElse(new ResponseEntity<>(new PhoneVerifyInfoDto(), HttpStatus.NOT_FOUND));
	}

	@RequestMapping("/emailVerifyInfo/{userId}")
	public ResponseEntity<EmailVerifyInfoDto> findEmailVerifyInfo(@PathVariable("userId") Long userId) {
		return userService.findEmailVerifyInfo(userId).map(result ->
				new ResponseEntity<>(result, HttpStatus.OK)
		).orElse(new ResponseEntity<>(new EmailVerifyInfoDto(), HttpStatus.NOT_FOUND));
	}

	@RequestMapping("/modifyPhotoEnable")
	public ResponseEntity<Map<String, Object>> modifyPhotoEnable(@RequestParam("userId") Long userId, @RequestParam("photoEnable") boolean photoEnable) {
		Map<String, Object> map = new HashMap<>();
		map.put("data", adminUserService.updatePhotoEnable(userId, photoEnable));
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

	@Transactional
	@PostMapping("/indexing")
	public CommonResponse<Boolean> indexing(@RequestParam(name = "ids") String ids) {
		log.info("indexing : {}", ids);
		List<User> users = userRepository.findAllById(Arrays.stream(StringUtils.split(ids, ",")).map(Long::valueOf).collect(Collectors.toList()));
		FullTextEntityManager fullTextEntityManager =
				org.hibernate.search.jpa.Search.getFullTextEntityManager(em);
		FullTextSession session = fullTextEntityManager.unwrap(FullTextSession.class);

		for(User user : users) {
			session.index(user);
		}
		session.flushToIndexes();
		session.clear();

		return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), true);
	}

}
