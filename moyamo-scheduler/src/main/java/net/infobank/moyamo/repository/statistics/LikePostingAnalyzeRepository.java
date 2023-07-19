package net.infobank.moyamo.repository.statistics;

import net.infobank.moyamo.models.LikePosting;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.persistence.Tuple;
import java.time.ZonedDateTime;

public interface LikePostingAnalyzeRepository extends JpaRepository<LikePosting, Long> {

    @Query("select max(id) from LikePosting a where a.id >= :sinceId and a.createdAt <= :date and a.createdAt is not null")
    Long findLastIdByDate(@Param("sinceId") long sinceId, @Param("date") ZonedDateTime date);

    /**
     *
     * @param sinceId 보다 큰 것 조회
     * @param from gte
     * @param to lt
     * @return
     */
    @Query("select count(id) as cnt, max(id) as max, min(id) as min from LikePosting a where a.id >= :sinceId and a.createdAt >= :from and a.createdAt < :to")
    Tuple count(@Param("sinceId") long sinceId, @Param("from") ZonedDateTime from, @Param("to") ZonedDateTime to);

}
