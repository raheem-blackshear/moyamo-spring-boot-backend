package net.infobank.moyamo.repository;


import net.infobank.moyamo.models.Home;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface AdminHomeRepository extends JpaRepository<Home, Long> {
    @Query("select h from Home h where h.genre=:genre")
    Optional<Home> findByGenre(@Param("genre") String genre);

    @Query("select max(h.orderCount) from Home h")
    Optional<Long> findMaxOrderCount();
}
