package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.Gamble;
import net.infobank.moyamo.models.GambleVersion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

public interface GambleVersionRepository extends JpaRepository<GambleVersion, Long> {


    @Query("select gv from GambleVersion gv where gv.gamble = :gamble")
    List<GambleVersion> findByGamble(@Param("gamble") Gamble gamble);

    @Query("select gv from GambleVersion gv where gv.gamble = :gamble and gv.date = :date")
    Optional<GambleVersion> findByGamble(@Param("gamble") Gamble gamble, @Param("date") ZonedDateTime date);

    @Query("select gv from GambleVersion gv where gv.gamble = :gamble and gv.version = :version")
    Optional<GambleVersion> findByGamble(@Param("gamble") Gamble gamble, @Param("version") int version);
}
