package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.Posting;
import net.infobank.moyamo.models.PostingRanking;
import net.infobank.moyamo.models.Ranking;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

public interface PostingRankingRepository extends JpaRepository<PostingRanking, Long> {

    List<PostingRanking> findAllByRankingTypeAndDate(Ranking.RankingType rankingType, ZonedDateTime date);

    List<PostingRanking> findAllByRankingTypeAndDate(Ranking.RankingType rankingType, ZonedDateTime date, Pageable pageable);

    @Query("select pr from PostingRanking pr where pr.posting=:posting")
    List<PostingRanking> findPostingRankingByPosting(@Param("posting")Posting posting);
}
