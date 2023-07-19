package net.infobank.moyamo.repository.statistics;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.data.repository.query.Param;

import javax.persistence.Tuple;
import java.time.ZonedDateTime;

@SuppressWarnings("unused")
@NoRepositoryBean
public interface IAnalyzeRepository<T> extends JpaRepository<T, Long> {

    @Query("select nullif(max(id), 0) from #{#entityName} a where a.id >= :sinceId and a.createdAt <= :date and a.createdAt is not null")
    Long findLastIdByDate(@Param("sinceId") long sinceId, @Param("date") ZonedDateTime date);

    /**
     *
     * @param sinceId 보다 큰 것 조회
     * @param from gte
     * @param to lt
     * @return Tuple[Long, Long, Long]
     */
    @Query("select count(id) as cnt, max(id) as max, min(id) as min from #{#entityName} a where a.id >= :sinceId and a.createdAt >= :from and a.createdAt < :to")
    Tuple count(@Param("sinceId") long sinceId, @Param("from") ZonedDateTime from, @Param("to") ZonedDateTime to);


}
