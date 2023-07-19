package net.infobank.moyamo.repository.statistics;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.models.LikePosting;
import net.infobank.moyamo.models.Statistics;
import net.infobank.moyamo.repository.StatisticsRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@SuppressWarnings("unused")
@Slf4j
@Repository
public class LikePostingAnalyzeRepositoryCustom extends AbstractActivityRepositoryCustom<LikePosting>  {

    public LikePostingAnalyzeRepositoryCustom(EntityManager em, StatisticsRepository statisticsRepository) {
        super(em, statisticsRepository);
    }

    @Override
    Optional<Long> getStartId(List<Statistics> statisticsList) {
        return statisticsList.stream().map(Statistics::getFirstLikeId).min(Comparator.naturalOrder());
    }

    @Override
    Optional<Long> getEndId(List<Statistics> statisticsList) {
        return statisticsList.stream().map(Statistics::getLastLikeId).max(Long::compareTo);
    }

    Optional<Long> getPostingStartId(List<Statistics> statisticsList) {
        return statisticsList.stream().map(Statistics::getFirstPostingId).min(Comparator.naturalOrder());
    }

    Optional<Long> getPostingEndId(List<Statistics> statisticsList) {
        return statisticsList.stream().map(Statistics::getLastPostingId).max(Long::compareTo);
    }

    public List<LikePosting> findListByRange(PostingType postingType, int offset, int count, ZonedDateTime from, ZonedDateTime to, List<Statistics> statisticsList) {

        CriteriaBuilder cb = getEm().getCriteriaBuilder();
        CriteriaQuery<LikePosting> query = cb.createQuery(LikePosting.class);

        List<Predicate> predicates = new ArrayList<>();
        Root<LikePosting> root = query.from(LikePosting.class);

        //게시글 id range 지정
        getPostingStartId(statisticsList).ifPresent(startId -> predicates.add(cb.ge(root.get("relation").get("posting").get("id"), startId)));
        getPostingEndId(statisticsList).ifPresent(endId -> predicates.add(cb.le(root.get("relation").get("posting").get("id"), endId)));

        //좋아요 id range 지정
        getStartId(statisticsList).ifPresent(startId -> predicates.add(cb.ge(root.get("id"), startId)));
        getEndId(statisticsList).ifPresent(endId -> predicates.add(cb.le(root.get("id"), endId)));


        predicates.add(cb.equal(root.get("postingType"), postingType));
        predicates.add(cb.greaterThanOrEqualTo(root.get("createdAt"), from));
        predicates.add(cb.lessThanOrEqualTo(root.get("createdAt"), to));
        query.where(predicates.toArray(new Predicate[]{}));
        return getEm().createQuery(query).setFirstResult(offset).setMaxResults(count).getResultList();
    }
}
