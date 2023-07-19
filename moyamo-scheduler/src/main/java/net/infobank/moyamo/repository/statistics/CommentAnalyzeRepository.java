package net.infobank.moyamo.repository.statistics;

import net.infobank.moyamo.models.Comment;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.persistence.Tuple;
import java.time.ZonedDateTime;

public interface CommentAnalyzeRepository extends IAnalyzeRepository<Comment> {

    @Query(nativeQuery = true, value="select count(if(diff >= 10, 1, null)) s10, count(if(diff >= 30, 1, null)) s30 from (" +
            " select B.id, TIMESTAMPDIFF(MINUTE, B.created_at, A.created_at) as diff  from (select posting_id, min(created_at) created_at from comment A where A.posting_id >= :startPostingId and  A.posting_id <= :lastPostingId and A.created_at >= :from and A.created_at < :to  group by posting_id) A "+
    " left join posting B on A.posting_id = B.id where B.id >= :startPostingId and B.id <= :lastPostingId and A.created_at >= :from and A.created_at < :to and dtype = 'QU' ) TB")
    Tuple lateComments(@Param("startPostingId")long startPostingId, @Param("lastPostingId")long lastPostingId, @Param("from") ZonedDateTime from, @Param("to")ZonedDateTime to);


}
