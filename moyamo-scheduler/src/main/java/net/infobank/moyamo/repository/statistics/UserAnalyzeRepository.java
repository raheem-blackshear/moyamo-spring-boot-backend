package net.infobank.moyamo.repository.statistics;

import net.infobank.moyamo.models.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.persistence.Tuple;
import java.time.ZonedDateTime;
import java.util.List;

public interface UserAnalyzeRepository extends IAnalyzeRepository<User> {

    /**
     * Tuple [date:String[yyyy-MM-dd], osType:String, count:BigDecimal]
     * @param startId
     * @param from
     * @param to
     * @return
     */
    @Query(nativeQuery = true, value = "select date_format(date_add(u.created_at, interval 9 hour), \"%Y-%m-%d\") dt, ifnull(os_type, 'unknown') , count(*) cnt from user u left join user_push_token t on u.id = t.user_id where u.id >= :startId and u.created_at >= :from and u.created_at < :to group by dt, os_type")
    List<Tuple> groupByOsType(@Param("startId") long startId, @Param("from") ZonedDateTime from, @Param("to") ZonedDateTime to);

    /**
     * Tuple [date:String[yyyy-MM-dd], provider:String, count:BigDecimal]
     * @param startId
     * @param from
     * @param to
     * @return
     */
    @Query(nativeQuery = true, value = "select date_format(date_add(u.created_at, interval 9 hour), \"%Y-%m-%d\") dt, provider , count(*) cnt from user u left join user_push_token t on u.id = t.user_id where u.id >= :startId and u.created_at >= :from and u.created_at < :to group by dt, provider")
    List<Tuple> groupByProvider(@Param("startId") long startId, @Param("from") ZonedDateTime from, @Param("to") ZonedDateTime to);

    /**
     *
     * @param startId
     * @param from
     * @param to
     * @return
     */
    @Query(nativeQuery = true, value = "SELECT date_format(date_add(created_at, interval 9 hour), \"%Y-%m-%d\") dt, count(distinct user_id) cnt FROM user_modify_email_history where id >= :startId and created_at >= :from and created_at < :to and auth_status = 1 group by dt")
    Tuple modifyEmailAccounts(@Param("startId") long startId, @Param("from") ZonedDateTime from, @Param("to") ZonedDateTime to);

    /**
     *
     * @param startId
     * @param from
     * @param to
     * @return
     */
    @Query(nativeQuery = true, value = "SELECT date_format(date_add(created_at, interval 9 hour), \"%Y-%m-%d\") dt, ifnull(provider, 'unknown') provider, count(*) cnt FROM user_modify_provider_history where id >= :startId and created_at >= :from and created_at < :to group by dt, provider")
    Tuple modifyProviderAccounts(@Param("startId") long startId, @Param("from") ZonedDateTime from, @Param("to") ZonedDateTime to);


    @Query(nativeQuery = true, value = "SELECT date_format(date_add(created_at, interval 9 hour), \"%Y-%m-%d\") dt, count(*) cnt FROM user where id >= :startId and created_at >= :from and created_at < :to and status = 2 group by dt")
    Tuple leaveAccounts(@Param("startId") long startId, @Param("from") ZonedDateTime from, @Param("to") ZonedDateTime to);


}
