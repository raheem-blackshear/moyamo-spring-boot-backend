package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.Resource;
import net.infobank.moyamo.models.Share;
import net.infobank.moyamo.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;
import java.util.UUID;

public interface ShareRepository extends JpaRepository<Share, Long> {

    @Query("select s from Share s where s.resource = :resource and s.owner = :owner")
    Share findByResourceAndUser(@Param("resource") Resource resource, @Param("owner") User owner);

    @Query("select s from Share s where s.uuid = :uuid")
    Optional<Share> findByUUID(@Param("uuid") UUID uuid);
}
