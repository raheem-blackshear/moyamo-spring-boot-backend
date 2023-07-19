package net.infobank.moyamo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.infobank.moyamo.models.UserModifyTokenHistory;

public interface UserModifyTokenHistoryRepository extends JpaRepository<UserModifyTokenHistory, Long> {

}
