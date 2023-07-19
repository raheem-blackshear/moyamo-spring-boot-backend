package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.NoticePolicy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface NoticePolicyRepository extends JpaRepository<NoticePolicy, Long> {
	Optional<NoticePolicy> findByIsDelete(Boolean deleted);

	List<NoticePolicy> findAllByIsDelete(Boolean deleted);

	List<NoticePolicy> findAllByIsDeleteOrderByPositionAsc(Boolean deleted);
}
