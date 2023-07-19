package net.infobank.moyamo.repository.statistics;

import net.infobank.moyamo.models.AdoptComment;
import net.infobank.moyamo.models.Statistics;
import net.infobank.moyamo.repository.StatisticsRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;
import java.util.Optional;


@Repository
public class AdoptCommentAnalyzeRepositoryCustom extends AbstractActivityRepositoryCustom<AdoptComment> {

    public AdoptCommentAnalyzeRepositoryCustom(EntityManager em, StatisticsRepository statisticsRepository) {
        super(em, statisticsRepository);
    }

    @Override
    Optional<Long> getStartId(List<Statistics> statisticsList) {
        return Optional.empty();
    }

    @Override
    Optional<Long> getEndId(List<Statistics> statisticsList) {
        return Optional.empty();
    }

}
