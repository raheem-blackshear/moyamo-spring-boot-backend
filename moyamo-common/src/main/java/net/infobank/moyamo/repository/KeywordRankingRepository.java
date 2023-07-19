package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.KeywordRanking;
import net.infobank.moyamo.models.Ranking;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.ZonedDateTime;
import java.util.List;

public interface KeywordRankingRepository extends JpaRepository<KeywordRanking, Long> {

    List<KeywordRanking> findAllByRankingTypeAndDate(Ranking.RankingType rankingType, ZonedDateTime date);
}
