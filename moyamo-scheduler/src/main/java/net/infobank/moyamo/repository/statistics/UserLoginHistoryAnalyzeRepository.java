package net.infobank.moyamo.repository.statistics;

import net.infobank.moyamo.models.UserLoginHistory;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.persistence.Tuple;
import java.time.ZonedDateTime;
import java.util.List;

public interface UserLoginHistoryAnalyzeRepository extends IAnalyzeRepository<UserLoginHistory> {

    /**
     *
     * @param sinceId 보다 큰 것 조회
     * @param from gte
     * @param to lt
     * @return Tuple<{role], {count}>
     */
    @Query(nativeQuery = true, value="select u.role, count(distinct a.user_id) from user_login_history a inner join user u on a.user_id = u.id where a.id >= :sinceId and a.created_at >= :from and a.created_at < :to " +
            "group by u.role")
    List<Tuple> loginRoleGroup(long sinceId, ZonedDateTime from, ZonedDateTime to);

    /**
     *
     * @param sinceId 보다 큰 것 조회
     * @param from gte
     * @param to lt
     * @return Tuple<{expertgroup], {count}>
     */
    @Query(nativeQuery = true, value="select eg.expert_group, count(distinct a.user_id) from user_login_history a inner join user u on a.user_id = u.id inner join user_expert_group eg on u.id = eg.user_id where a.id >= :sinceId and a.created_at >= :from and a.created_at < :to " +
            "group by eg.expert_group")
    List<Tuple> loginExpertGroup(long sinceId, ZonedDateTime from, ZonedDateTime to);


    /**
     *
     * @param sinceId 보다 큰 것 조회
     * @param from gte
     * @param to lt
     * @return
     */
    @Query("select count(distinct h.userId) as cnt, max(h.id) as max, min(h.id) as min from UserLoginHistory h where h.id >= :sinceId and h.createdAt >= :from and h.createdAt < :to")
    Tuple count(@Param("sinceId") long sinceId, @Param("from") ZonedDateTime from, @Param("to") ZonedDateTime to);


}
