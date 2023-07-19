package net.infobank.moyamo.repository.statistics;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.IActivity;
import net.infobank.moyamo.models.Statistics;
import net.infobank.moyamo.repository.StatisticsRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.lang.reflect.ParameterizedType;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Getter(AccessLevel.PACKAGE)
@Slf4j
@Repository
public abstract class AbstractActivityRepositoryCustom<T extends IActivity>  {

    private final EntityManager em;
    private final StatisticsRepository statisticsRepository;

    AbstractActivityRepositoryCustom(EntityManager em, StatisticsRepository statisticsRepository) {
        this.em = em;
        this.statisticsRepository = statisticsRepository;
    }

    abstract Optional<Long> getStartId(List<Statistics> statisticsList);
    abstract Optional<Long> getEndId(List<Statistics> statisticsList);

    @SuppressWarnings("unchecked")
    public List<T> findListByRange(int offset, int count, ZonedDateTime from, ZonedDateTime to, List<Statistics> statisticsList) {

        Class<T> clazz = (Class<T>)
                ((ParameterizedType)getClass()
                        .getGenericSuperclass())
                        .getActualTypeArguments()[0];

        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<T> query = cb.createQuery(clazz);

        List<Predicate> predicates = new ArrayList<>();
        Root<T> root = query.from(clazz);
        getStartId(statisticsList).ifPresent(startId -> predicates.add(cb.ge(root.get("id"), startId)));

        getEndId(statisticsList).ifPresent(endId -> predicates.add(cb.le(root.get("id"), endId)));

        predicates.add(cb.greaterThanOrEqualTo(root.get("createdAt"), from));
        predicates.add(cb.lessThanOrEqualTo(root.get("createdAt"), to));
        query.where(predicates.toArray(new Predicate[]{}));
        return em.createQuery(query).setFirstResult(offset).setMaxResults(count).getResultList();
    }

}
