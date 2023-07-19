package net.infobank.moyamo.repository;


import net.infobank.moyamo.models.AdminBadge;
import net.infobank.moyamo.models.Banner;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AdminBannerRepository extends JpaRepository<AdminBadge, Long> {
    @Query("select b from Banner b where b.title like concat('%',:query, '%')")
    List<Banner> findBySearch(@Param("query") String query, Pageable pageable);

    @Query("select b from Banner b where b.title like concat('%',:query, '%')")
    List<Banner> findBySearch(@Param("query") String query);

    @Query("select count(b) from Banner b where b.title like concat('%',:query, '%')")
    Integer countBySearch(@Param("query") String query);
}
