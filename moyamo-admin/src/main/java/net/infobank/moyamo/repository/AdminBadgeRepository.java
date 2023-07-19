package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.AdminBadge;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AdminBadgeRepository extends JpaRepository<AdminBadge, Long> {
    @Query("select ab from AdminBadge ab where ab.title like concat('%',:query, '%')")
    List<AdminBadge> findBySearch(@Param("query") String query, Pageable pageable);

    @Query("select ab from AdminBadge ab where ab.title like concat('%',:query, '%')")
    List<AdminBadge> findBySearch(@Param("query") String query);
}
