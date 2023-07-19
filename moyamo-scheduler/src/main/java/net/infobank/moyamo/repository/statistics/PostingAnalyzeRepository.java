package net.infobank.moyamo.repository.statistics;

import net.infobank.moyamo.models.Posting;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.persistence.Tuple;
import java.time.ZonedDateTime;
import java.util.Collection;
import java.util.List;

public interface PostingAnalyzeRepository extends IAnalyzeRepository<Posting> {


    /**
     *
     * @param startId 보다 큰 것 조회
     * @param from gte
     * @param to lt
     * @return Tuple [type, count]
     */
    @Query(nativeQuery = true, value="select p.dtype, count(p.id) from posting p  where p.id >= :startId and p.created_at >= :from and p.created_at < :to " +
            "group by p.dtype")
    List<Tuple> postingTypeGroup(@Param("startId")long startId, @Param("from") ZonedDateTime from, @Param("to")ZonedDateTime to);



    @Query(nativeQuery = true, value="select p.id, p.owner_id, p.dtype,  p.read_count from posting p where p.id in (:ids) and dtype in (:dtypes)and p.created_at between :from and :to and is_delete = false")
    List<Tuple> findAllByIdAndDTypeInAndDateRangeNative(@Param("ids") Collection<Long> ids, @Param("dtypes") Collection<String> dtypes, @Param("from") ZonedDateTime from, @Param("to") ZonedDateTime to);

}
