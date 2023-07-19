package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.NotificationAdmin;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AdminNotificationRepository extends JpaRepository<NotificationAdmin, Long> {
	//@Query(nativeQuery = true, value = "SELECT * FROM notification_adminjoin posting on   WHERE reserved_time <= NOW() AND send_time IS NULL")
	@Query(value = "select na from NotificationAdmin na join na.posting p where p.isDelete = false and na.sendTime is null and na.reservedTime <= now() ")
	public List<NotificationAdmin> findByReservedTimeInQuery(Pageable pageable);

	@Query(value = "select na from NotificationAdmin na join na.posting p where p.isDelete = false")
	public List<NotificationAdmin> findList(Pageable pageable);

	@Query(value = "select count(na) from NotificationAdmin na join na.posting p where p.isDelete = false")
	public Long findListCount();

}
