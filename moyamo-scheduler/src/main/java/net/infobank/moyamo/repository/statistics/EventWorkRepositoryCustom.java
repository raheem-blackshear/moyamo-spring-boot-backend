package net.infobank.moyamo.repository.statistics;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import net.infobank.moyamo.models.Comment;
import net.infobank.moyamo.models.Posting;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.Tuple;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;


@AllArgsConstructor
@Repository
public class EventWorkRepositoryCustom {

    private static final String OWNER_FIELD = "owner";

    private final EntityManager em;

    /**
     *
     * @param clazz
     * @param cursorId
     * @param count
     * @return
     */
    @Transactional(readOnly = true)
    public List<SimplePosting> findPostingList(Class<? extends Posting> clazz, Long cursorId, Long maxId, int count) {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Tuple> query = cb.createTupleQuery();

        List<Predicate> predicates = new ArrayList<>();
        Root<? extends Posting> root = query.from(clazz);
        query.multiselect(root.get("id"), root.get(OWNER_FIELD).get("id"), root.get("createdAt"), root.get("commentCount"));
        if(cursorId != null) {
            predicates.add(cb.gt(root.get("id"), cursorId));
        }

        if(maxId != null) {
            predicates.add(cb.le(root.get("id"), maxId));
        }

        query.where(predicates.toArray(new Predicate[0]));
        return em.createQuery(query).setMaxResults(count).getResultList().stream().map(this::of).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<SimpleCommentGroupOwner> findCommentGroupByOwnerList(Collection<Long> postingIds) {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Tuple> query = cb.createTupleQuery();

        Root<Comment> root = query.from(Comment.class);
        query.multiselect(root.get(OWNER_FIELD).get("id"), cb.countDistinct(root.get("posting").get("id")));
        query.groupBy(root.get(OWNER_FIELD).get("id"));

        query.where(root.get("posting").get("id").in(postingIds), root.get("parent").isNull());
        return em.createQuery(query).getResultList().stream().map(this::ofSimpleCommentGroupOwner).collect(Collectors.toList());
    }

    private SimplePosting of(Tuple tuple) {
        return new SimplePosting(tuple.get(0, Long.class),tuple.get(1, Long.class), tuple.get(2, ZonedDateTime.class),tuple.get(3, Integer.class));
    }

    private SimpleCommentGroupOwner ofSimpleCommentGroupOwner(Tuple tuple) {
        return new SimpleCommentGroupOwner(tuple.get(0, Long.class),tuple.get(1, Long.class));
    }


    @Setter
    @Getter
    @AllArgsConstructor
    public static class SimplePosting {
        private Long id;
        private Long ownerId;
        private ZonedDateTime createdAt;
        private Integer commentCount;
    }

    @Setter
    @Getter
    @AllArgsConstructor
    public static class SimpleCommentGroupOwner {
        private Long ownerId;
        private Long postingCount;
    }

}
