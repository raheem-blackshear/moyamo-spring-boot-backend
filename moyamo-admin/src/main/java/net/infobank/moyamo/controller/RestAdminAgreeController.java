package net.infobank.moyamo.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.repository.AdminProviderHistoryRepository;
import net.infobank.moyamo.repository.UserRepository;
import net.infobank.moyamo.service.*;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 포스팅 관련 rest api
 *
 * @author jspark
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/rest/agree")
public class RestAdminAgreeController {

	final AuthUtils authUtils;

	final UserService userService;

	final AdminUserService adminUserService;

	final NoticeService noticeService;

	final AdminNotificationService adminNotificationService;

	final AdminProviderHistoryRepository adminProviderHistoryRepository;

	final UserRepository userRepository;

	final ImageUploadService imageUploadService;

}
