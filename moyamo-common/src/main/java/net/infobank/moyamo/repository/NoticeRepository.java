package net.infobank.moyamo.repository;

import java.time.ZonedDateTime;
import java.util.List;

import net.infobank.moyamo.enumeration.NoticeType;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import net.infobank.moyamo.enumeration.NoticeStatus;
import net.infobank.moyamo.models.Notice;

public interface NoticeRepository extends JpaRepository<Notice, Long> {

    @Query(value = "select n from Notice n where n.start <= :currentDate and :currentDate <= n.end and n.status = :status and n.type = :type")
    List<Notice> findListByCurrentDate(@Param("currentDate") ZonedDateTime currentDate, @Param("status") NoticeStatus status, @Param("type") NoticeType type);

    @Query(value = "select n from Notice n where n.status = :status and n.type = :type")
    List<Notice> findList(@Param("status") NoticeStatus status, @Param("type") NoticeType type);

    @Query(value = "select n from Notice n where n.type = :type")
    List<Notice> findList(@Param("type") NoticeType type, Pageable pageable);

    @Query(value = "select count(n) from Notice n where n.type = :type")
    Long count(@Param("type") NoticeType type);
}
