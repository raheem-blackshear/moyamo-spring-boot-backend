package net.infobank.moyamo.service;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.NotificationAdminDto;
import net.infobank.moyamo.enumeration.ExpertGroup;
import net.infobank.moyamo.enumeration.OsType;
import net.infobank.moyamo.form.admin.RegistNotificationVo;
import net.infobank.moyamo.models.NotificationAdmin;
import net.infobank.moyamo.models.Posting;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.repository.AdminNotificationRepository;
import net.infobank.moyamo.repository.PostingRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


@Slf4j
@Service
public class AdminNotificationService {

	final AdminUserService adminUserService;

	final PostingRepository postingRepository;

	final AdminNotificationRepository adminNotificationRepository;

	final ImageUploadService imageUploadService;

	public AdminNotificationService(AdminUserService adminUserService, PostingRepository postingRepository, AdminNotificationRepository adminNotificationRepository, ImageUploadService imageUploadService) {
		this.adminUserService = adminUserService;
		this.postingRepository = postingRepository;
		this.adminNotificationRepository = adminNotificationRepository;
		this.imageUploadService = imageUploadService;
	}

	public NotificationAdmin findById(long id) {
    	return adminNotificationRepository.findById(id).orElse(null);
    }

    public NotificationAdmin save(NotificationAdmin notification) {
    	return adminNotificationRepository.save(notification);
    }

    public void delete(NotificationAdmin notification) {
    	adminNotificationRepository.delete(notification);
    }

    public Long getReportTotalCount() {
    	return adminNotificationRepository.count();
    }

    @SuppressWarnings("unused")
    public void doRegistNotification() {
		log.debug("doRegistNotification");
    }

    public List<NotificationAdminDto> findAll(Pageable pageable) {
		List<NotificationAdmin> notificationList = adminNotificationRepository.findList(pageable);
		return notificationList.stream().map(NotificationAdminDto::of).collect(Collectors.toList());
	}

    public Long getTagCount() {
    	return adminNotificationRepository.findListCount();
    }

    public NotificationAdmin createNotification(RegistNotificationVo vo, User loginUser) throws InterruptedException, IOException {

		if(log.isDebugEnabled()) {
			log.debug("createNotification RegistNotificationVo : {}", vo.toString());
		}

		OsType deviceGroup = OsType.valueOf(vo.getDeviceGroup().toLowerCase());
		ExpertGroup targetGroup = ExpertGroup.valueOf(vo.getExpertGroup().toUpperCase());

		NotificationAdmin notification;
		if(vo.getLink() != null && !vo.getLink().isEmpty()) {
			notification = NotificationAdmin.builder()
					.text(vo.getText())
					.title(vo.getTitle())
					.link(vo.getLink())
					.isReserved(vo.isReserved())
					.owner(loginUser)
					.deviceGroup(deviceGroup)
					.targetGroup(targetGroup)
					.user(loginUser)
					.reservedTime(vo.getReservedTime())
					.build();
		} else {
			Posting posting =  postingRepository.getOne(vo.getPostingId());
			notification = NotificationAdmin.builder()
					.text(vo.getText())
					.title(vo.getTitle())
					.isReserved(vo.isReserved())
					.owner(loginUser)
					.deviceGroup(deviceGroup)
					.targetGroup(targetGroup)
					.posting(posting)
					.user(posting.getOwner())
					.reservedTime(vo.getReservedTime())
					.build();
		}

		if (vo.getFiles() != null && !vo.getFiles().isEmpty()) {
            ImageUploadService.ImageResourceInfo info = imageUploadService.upload(FolderDatePatterns.NOTIFICATIONS, vo.getFiles());
            notification.setThumbnail(info.getImageResource());
        }

		return notification;
	}

    public NotificationAdmin modifyNotification(NotificationAdmin notification, RegistNotificationVo vo, User loginUser) throws InterruptedException, IOException {

		log.debug("modifyNotification RegistNotificationVo : {}" + vo.toString());

		ExpertGroup targetGroup = ExpertGroup.valueOf(vo.getExpertGroup().toUpperCase());

		notification.setModifiedAt(ZonedDateTime.now());
		notification.setReservedTime(vo.getReservedTime());
		notification.setTitle(vo.getTitle());
		notification.setText(vo.getText());
		notification.setOwner(loginUser);
		notification.setTargetGroup(targetGroup);
		notification.setReserved(vo.isReserved());

		if (vo.getFiles() != null && !vo.getFiles().isEmpty()) {
            ImageUploadService.ImageResourceInfo info = imageUploadService.upload(FolderDatePatterns.NOTIFICATIONS, vo.getFiles());
            notification.setThumbnail(info.getImageResource());
        }

		return notification;
	}

	public List<NotificationAdmin> findByReservedTime() {
		List<NotificationAdmin> notificationList = adminNotificationRepository.findByReservedTimeInQuery(PageRequest.of(0, 10));

		for(NotificationAdmin notification : notificationList) {
			String title = notification.getTitle();
			log.info("title : {}, now : {}", title, ZonedDateTime.now());

			notification.setSendTime(ZonedDateTime.now());
		}

		adminNotificationRepository.saveAll(notificationList);
		return notificationList;
	}

	public List<User> selectRecipientUsers(NotificationAdmin notification) {
		List<User> recipientWithMentionUsers = new ArrayList<>();
		if(!ExpertGroup.ALL.equals(notification.getTargetGroup())) {//발송 목록 생성
			List<User> users = adminUserService.findAllByExpertGroup(notification.getTargetGroup());
			recipientWithMentionUsers.addAll(users);

			if(log.isDebugEnabled()) {
				log.debug("RegistNotification User size : {}", users.size());
			}
		}

		return recipientWithMentionUsers;
	}
}
