package net.infobank.moyamo.repository.statistics;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.Comment;
import net.infobank.moyamo.models.Posting;
import net.infobank.moyamo.models.Statistics;
import net.infobank.moyamo.repository.StatisticsRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.criteria.*;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@Slf4j
@Repository
public class CommentAnalyzeRepositoryCustom extends AbstractActivityRepositoryCustom<Comment> {

    private static final String OWNER_FIELD = "owner";
    private static final String POSTING_FIELD = "posting";
    private static final String CREATED_AT_FIELD = "createdAt";
    private static final String PARENT_FIELD = "parent";

    public CommentAnalyzeRepositoryCustom(EntityManager em, StatisticsRepository statisticsRepository) {
        super(em, statisticsRepository);
    }

    @Override
    Optional<Long> getStartId(List<Statistics> statisticsList) {
        return statisticsList.stream().map(Statistics::getFirstCommentId).min(Comparator.naturalOrder());
    }

    @Override
    Optional<Long> getEndId(List<Statistics> statisticsList) {
        return statisticsList.stream().map(Statistics::getLastCommentId).max(Long::compareTo);
    }

    /**
     * 댓글 조건 검색 기준으로 게시글 목록 조회
     */
    public List<Posting> findPostingListByCommentRange(Class<? extends Posting> clazz, int offset, int count, ZonedDateTime from, ZonedDateTime to) {

        List<Statistics> statisticsList = getStatisticsRepository().findByRange(from, to);
        CriteriaBuilder cb = getEm().getCriteriaBuilder();
        CriteriaQuery<Posting> query = cb.createQuery(Posting.class);

        List<Predicate> predicates = new ArrayList<>();
        Root<? extends Posting> root = query.from(clazz);
        Root<Comment> comment = query.from(Comment.class);

        query.select(root).distinct(true);
        Predicate predicate = getEm().getCriteriaBuilder().equal(
                root.get("id"), comment.get(POSTING_FIELD).get("id")
        );

        getStartId(statisticsList).ifPresent(startId -> predicates.add(cb.ge(comment.get("id"), startId)));
        getEndId(statisticsList).ifPresent(endId -> predicates.add(cb.le(comment.get("id"), endId)));

        predicates.add(predicate);
        predicates.add(cb.greaterThanOrEqualTo(comment.get(CREATED_AT_FIELD), from));
        predicates.add(cb.lessThanOrEqualTo(comment.get(CREATED_AT_FIELD), to));
        predicates.add(cb.notEqual(comment.get("isDelete"), true));
        predicates.add(cb.isNull(comment.get(PARENT_FIELD)));

        query.where(predicates.toArray(new Predicate[]{}));
        return getEm().createQuery(query).setFirstResult(offset).setMaxResults(count).getResultList();
    }


    /**
     * 대댓글 목록조회, 게시글 작성자와 같고 게시일 조건이 맞는 것
     */
    public List<Comment> findReplyListByPostingWriterAndCommentRange(int offset, int count, ZonedDateTime from, ZonedDateTime to) {

        List<Statistics> statisticsList = getStatisticsRepository().findByRange(from, to);
        //log.info("statisticsList : {}", statisticsList);


        CriteriaBuilder cb = getEm().getCriteriaBuilder();
        CriteriaQuery<Comment> query = cb.createQuery(Comment.class);

        List<Predicate> predicates = new ArrayList<>();
        Root<Comment> comment = query.from(Comment.class);
        Root<Posting> posting = query.from(Posting.class);

        query.select(comment);

        getStartId(statisticsList).ifPresent(startId -> predicates.add(cb.ge(comment.get("id"), startId)));
        getEndId(statisticsList).ifPresent(endId -> predicates.add(cb.le(comment.get("id"), endId)));

        Predicate predicate2 = getEm().getCriteriaBuilder().equal(
            posting.get("id"), comment.get(POSTING_FIELD).get("id")
        );

        //대글작성자 !== 대댓글 작성자
        Predicate predicate3 = getEm().getCriteriaBuilder().notEqual(
            comment.get(OWNER_FIELD).get("id"), comment.get(PARENT_FIELD).get(OWNER_FIELD).get("id")
        );

        predicates.add(cb.equal(comment.get(OWNER_FIELD).get("id"), comment.get(POSTING_FIELD).get(OWNER_FIELD).get("id")));
        predicates.add(predicate2);
        predicates.add(predicate3);
        predicates.add(cb.greaterThanOrEqualTo(comment.get(CREATED_AT_FIELD), from));
        predicates.add(cb.lessThanOrEqualTo(comment.get(CREATED_AT_FIELD), to));
        predicates.add(cb.notEqual(comment.get("isDelete"), true));
        predicates.add(cb.isNotNull(comment.get(PARENT_FIELD)));


        query.where(predicates.toArray(new Predicate[]{}));
        return getEm().createQuery(query).setFirstResult(offset).setMaxResults(count).getResultList();
    }
}
