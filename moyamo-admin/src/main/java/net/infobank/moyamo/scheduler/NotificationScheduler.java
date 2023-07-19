package net.infobank.moyamo.scheduler;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.enumeration.EventType;
import net.infobank.moyamo.enumeration.ExpertGroup;
import net.infobank.moyamo.enumeration.OsType;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.models.NotificationAdmin;
import net.infobank.moyamo.models.Posting;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.repository.AdminNotificationRepository;
import net.infobank.moyamo.service.AdminNotificationService;
import net.infobank.moyamo.service.AdminPostingService;
import net.infobank.moyamo.service.NotificationService;
import net.infobank.moyamo.service.PostingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;

@Slf4j
@Service
public class NotificationScheduler {


	@Autowired
	NotificationService notificationService;

	@Autowired
	AdminNotificationService adminNotificationService;

	@Autowired
	AdminNotificationRepository adminNotificationRepository;

	@Autowired
	AdminPostingService adminPostingService;

	@Autowired
	PostingService postingService;

	@Bean
	@ConditionalOnProperty(value = "moyamo.jobs.notification.enable", matchIfMissing = true, havingValue = "true")
	public NotificationJob notificationScheduledJob() {
		return new NotificationJob();
	}

	private class NotificationJob {

		@Transactional
		@Scheduled(cron="*/10 * * * * *")
		public void scheduler() {
			log.info("Notification Scheduled(cron=10 * * * * *)");
			List<NotificationAdmin> notificationList = adminNotificationService.findByReservedTime();

			List<User> recipientWithMentionUsers;
			for(NotificationAdmin notification : notificationList) {

				Posting posting = notification.getPosting();

				//최신글로 컨텐츠 복사 + 임시 게시글을 공개한다.
				if((posting.getPostingType().equals(PostingType.magazine_wait) || posting.getPostingType().equals(PostingType.television_wait)) && posting.getPostingType().getTargetPostingType() != null) {
					Posting newPosting = adminPostingService.copyOrigin(posting.getId());
					if(newPosting != null) {
						postingService.forceDeletePosting(posting.getId(), posting.getOwner());
						postingService.updatePostingType(Collections.singletonList(newPosting.getId()), posting.getPostingType().getTargetPostingType());
						notification.setPosting(newPosting);

						adminNotificationRepository.save(notification);
					}
				}

				if(OsType.none.equals( notification.getOsType())) {
					continue;
				}

				EventType eventType;
				if(notification.getTargetGroup().equals(ExpertGroup.ALL)) {
					recipientWithMentionUsers = Collections.emptyList();
					eventType = EventType.ADMIN_CUSTOM_ALL;
				} else {
					recipientWithMentionUsers = adminNotificationService.selectRecipientUsers(notification);
					eventType = EventType.ADMIN_CUSTOM_EXPERT;
				}
				notificationService.afterNewAdminCustom(notification, recipientWithMentionUsers, eventType);
			}
		}
	}
}
