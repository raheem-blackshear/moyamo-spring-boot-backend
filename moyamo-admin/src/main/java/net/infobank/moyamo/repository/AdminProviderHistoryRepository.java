package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.UserModifyProviderHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AdminProviderHistoryRepository extends JpaRepository<UserModifyProviderHistory, Long> {
	@Query(nativeQuery = true, value = "SELECT * FROM user WHERE user_modify_provider_history_id IN (SELECT id FROM user_modify_provider_history WHERE provider_id = :providerId)")
	public List<UserModifyProviderHistory> getList(@Param(value = "providerId") String providerId);
}
