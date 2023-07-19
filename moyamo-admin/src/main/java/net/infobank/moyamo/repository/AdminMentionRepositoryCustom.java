package net.infobank.moyamo.repository;


import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.Comment;
import net.infobank.moyamo.models.User;
import org.hibernate.criterion.Order;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.criteria.*;
import java.util.List;

@Slf4j
@Repository
public class AdminMentionRepositoryCustom {

    private final EntityManager em;

    @SuppressWarnings("unused")
    public AdminMentionRepositoryCustom(EntityManager em) {
        this.em = em;
    }

    @Transactional(readOnly = true)
    public List<Comment> findMentionList(User user, int start, int length) {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Comment> query = cb.createQuery(Comment.class);
        Root<Comment> root = query.from(Comment.class);
        ListJoin<Comment, User> mentions = root.joinList("mentions");
        query.where(cb.and(
            cb.equal(mentions, user)
        ));

        query.orderBy(cb.desc(root.get("id")));
        return em.createQuery(query).setFirstResult(start).setMaxResults(length).getResultList();
    }

    @Transactional(readOnly = true)
    public Long getMentionCount(User user) {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Long> query = cb.createQuery(Long.class);
        Root<Comment> root = query.from(Comment.class);

        ListJoin<Comment, User> mentions = root.joinList("mentions");
        query.select(cb.count(root)).where(cb.and(
                cb.equal(mentions, user)
        ));

        query.orderBy(cb.desc(root.get("id")));
        return em.createQuery(query).getSingleResult();
    }




}
