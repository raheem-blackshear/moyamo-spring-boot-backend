package net.infobank.moyamo.repository.statistics;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.User;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.Tuple;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Slf4j
@Repository
public class UserAnalyzeRepositoryCustom {

    private final EntityManager em;

    public UserAnalyzeRepositoryCustom(EntityManager em) {
        this.em = em;
    }

    public List<Tuple> findUserIdWithCommentCountList(Optional<Long> optionalStartId, Optional<Long> optionalEndId, int limit) {

        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Tuple> query = cb.createTupleQuery();

        List<Predicate> predicates = new ArrayList<>();
        Root<User> root = query.from(User.class);

        query.multiselect(root.get("id"), root.get("activity").get("commentCount"));
        optionalStartId.ifPresent(startId ->
            predicates.add(cb.ge(root.get("id"), startId)));

        optionalEndId.ifPresent(endId ->
            predicates.add(cb.lt(root.get("id"), endId)));

        query.where(predicates.toArray(new Predicate[]{}));
        return em.createQuery(query).setMaxResults(limit).getResultList();
    }
}
