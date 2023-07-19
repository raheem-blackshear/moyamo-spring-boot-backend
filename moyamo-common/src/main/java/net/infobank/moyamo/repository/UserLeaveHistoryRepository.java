package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.UserLeaveHistory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserLeaveHistoryRepository extends JpaRepository<UserLeaveHistory, Long> {

}
