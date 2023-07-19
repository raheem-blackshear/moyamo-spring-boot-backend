package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.Ranking;
import net.infobank.moyamo.models.UserRanking;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.ZonedDateTime;
import java.util.List;

public interface UserRankingRepository extends JpaRepository<UserRanking, Long> {

    List<UserRanking> findAllByRankingTypeAndDate(Ranking.RankingType rankingType, ZonedDateTime date);

    List<UserRanking> findAllByRankingTypeAndDate(Ranking.RankingType rankingType, ZonedDateTime date, Pageable pageable);
}
