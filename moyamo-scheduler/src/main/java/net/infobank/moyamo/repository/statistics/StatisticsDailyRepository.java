package net.infobank.moyamo.repository.statistics;

import net.infobank.moyamo.models.StatisticsDaily;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;

public interface StatisticsDailyRepository extends JpaRepository<StatisticsDaily, Long> {

    /**
     * lastDate 이전 날짜 통계중 마지막 하나
     * @param last 기준날짜
     * @return StatisticsDaily
     */
    @Query(nativeQuery = true, value = "select * from statistics_daily s where dt > :lastDate order by id desc limit 1")
    public StatisticsDaily findLastOnce(@Param("lastDate") LocalDate lastDate);

    @Query(value="select s from StatisticsDaily s where dt = :date")
    public StatisticsDaily findByDate(@Param("date") LocalDate date);



}
