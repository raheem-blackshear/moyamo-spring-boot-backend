package net.infobank.moyamo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.infobank.moyamo.models.UserLoginHistory;

public interface UserLoginHistoryRepository extends JpaRepository<UserLoginHistory, Long> {

}
