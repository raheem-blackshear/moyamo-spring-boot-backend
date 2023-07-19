package net.infobank.moyamo.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.configurations.MoyamoPasswordEncoder;
import net.infobank.moyamo.dto.AdminUserListResultDto;
import net.infobank.moyamo.dto.UserDto;
import net.infobank.moyamo.dto.UserWithExpertGroupDto;
import net.infobank.moyamo.enumeration.ExpertGroup;
import net.infobank.moyamo.enumeration.UserRole;
import net.infobank.moyamo.enumeration.UserStatus;
import net.infobank.moyamo.exception.MoyamoGlobalException;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.repository.ReportCommentRepository;
import net.infobank.moyamo.repository.ReportPostingRepository;
import net.infobank.moyamo.repository.UserExpertGroupRepository;
import net.infobank.moyamo.repository.UserRepository;
import org.apache.lucene.search.Sort;
import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.jpa.FullTextQuery;
import org.hibernate.search.query.dsl.BooleanJunction;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.hibernate.search.query.dsl.sort.SortContext;
import org.hibernate.search.query.dsl.sort.SortFieldContext;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.Tuple;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Service
@AllArgsConstructor
public class AdminUserService  {

	private static final String NICKNAME_FIELD = "nickname";
	private static final String PROVIDER_ID_FIELD = "providerId";
	private static final String SEARCH_WILDCARD = "*";

	private final EntityManager em;
	private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final UserExpertGroupRepository userExpertGroupRepository;
    private final ReportPostingRepository reportPostingRepository;
    private final ReportCommentRepository reportCommentRepository;

    @SuppressWarnings("unused")
    // Role별 사용자 조회
	public List<UserWithExpertGroupDto> findAllByRole(Pageable pageable, UserRole userRole) {
		List<User> userList = userRepository.findAllByRole(pageable, userRole);
		return userList.stream().map(UserWithExpertGroupDto::of).collect(Collectors.toList());
	}

	@SuppressWarnings("unused")
	// Role별 사용자수 조회
    public Long countByRole(UserRole userRole) {
    	return userRepository.countByRole(userRole);
    }

    public Optional<User> findById(Long id) {
    	return userRepository.findById(id);

    }
    public User save(User user) {
    	return userRepository.save(user);
    }

    public void removeUserExpertGroup(long userId) {
    	userExpertGroupRepository.deleteAllByUserId(userId);
    }

    // 관리자 타입 별, 사용자 조회
 	public List<User> findAllByExpertGroup(ExpertGroup expertGroup) {
 		return userRepository.findAllByExpertGroupExpertGroupAndStatus(expertGroup, UserStatus.NORMAL);
 	}

 	@SuppressWarnings("unchecked")
 	@Transactional(readOnly = true)
 	public AdminUserListResultDto search(int offset, int count, int draw, UserRole userRole, String query) {

		FullTextEntityManager fullTextEntityManager = org.hibernate.search.jpa.Search.getFullTextEntityManager(em);
		QueryBuilder qb = fullTextEntityManager.getSearchFactory()
				.buildQueryBuilder().forEntity(User.class)
				.get();

		BooleanJunction<?> booleanJunction  = qb.bool();
		booleanJunction.must(qb.keyword().onField("role").matching(userRole).createQuery());

		BooleanJunction<?> queryJunction  = qb.bool();
		if(query != null && !query.isEmpty()) {
			BooleanJunction<?> nameQueryJunction  = qb.bool();
			nameQueryJunction.should(qb.keyword().wildcard().onField(NICKNAME_FIELD).matching(SEARCH_WILDCARD + query).createQuery());
			nameQueryJunction.should(qb.keyword().wildcard().onField(NICKNAME_FIELD).matching(SEARCH_WILDCARD + query + SEARCH_WILDCARD).createQuery());
			nameQueryJunction.should(qb.keyword().wildcard().onField(NICKNAME_FIELD).matching(query + SEARCH_WILDCARD).createQuery());
			nameQueryJunction.should(qb.keyword().wildcard().onField(NICKNAME_FIELD).matching(query).createQuery());
			queryJunction.should(nameQueryJunction.createQuery());


			BooleanJunction<?> providerIdQueryJunction  = qb.bool();
			providerIdQueryJunction.should(qb.keyword().wildcard().onField(PROVIDER_ID_FIELD).matching(SEARCH_WILDCARD + query).createQuery());
			providerIdQueryJunction.should(qb.keyword().wildcard().onField(PROVIDER_ID_FIELD).matching(SEARCH_WILDCARD + query + SEARCH_WILDCARD).createQuery());
			providerIdQueryJunction.should(qb.keyword().wildcard().onField(PROVIDER_ID_FIELD).matching(query + SEARCH_WILDCARD).createQuery());
			providerIdQueryJunction.should(qb.keyword().wildcard().onField(PROVIDER_ID_FIELD).matching(query).createQuery());
			queryJunction.should(providerIdQueryJunction.createQuery());

			try {
				Long idQuery = Long.parseLong(query);
				queryJunction.should(qb.keyword().onField("id").matching(idQuery).createQuery());

			} catch (Exception e) {
				//
			}
			booleanJunction.must(queryJunction.createQuery());
		}


		SortContext sortContext = qb.sort();
		SortFieldContext sortFieldContext = sortContext.byField("id").desc();

		Sort sort = sortFieldContext.createSort();
		FullTextQuery fullTextQuery =  fullTextEntityManager.createFullTextQuery(booleanJunction.createQuery(), User.class)
				.setSort(sort);

		int resultSize = fullTextQuery.getResultSize();

		fullTextQuery.setFirstResult(offset);
		fullTextQuery.setMaxResults(count);
		List<UserWithExpertGroupDto> list = ((List<User>)fullTextQuery.getResultList()).stream().map(UserWithExpertGroupDto::of).collect(Collectors.toList());

		List<Long> userIds = list.stream().map(UserDto::getId).collect(Collectors.toList());

		List<Tuple> userReportCommentCounts = reportCommentRepository.countGroupByUsers(userIds);
		Map<Long, Long> userReportCommentCountsMap = userReportCommentCounts.stream().collect(Collectors.toMap(tuple -> (Long)tuple.get(0), tuple -> ((Long)tuple.get(1))));

		List<Tuple> userReportPostingCounts = reportPostingRepository.countGroupByUsers(userIds);
		Map<Long, Long> userReportPostingCountsMap = userReportPostingCounts.stream().collect(Collectors.toMap(tuple -> (Long)tuple.get(0), tuple -> ((Long)tuple.get(1))));

		for(UserWithExpertGroupDto dto : list) {
			dto.setReportCommentCount(userReportCommentCountsMap.getOrDefault(dto.getId(), 0L));
			dto.setReportPostingCount(userReportPostingCountsMap.getOrDefault(dto.getId(), 0L));
		}

		return new AdminUserListResultDto(resultSize, resultSize, draw, list);

	}

	@Transactional
	public boolean resetPassword(long userId, String resetPassword) {
		User user = userRepository.findById(userId).orElseThrow(() -> new MoyamoGlobalException(MoyamoGlobalException.Messages.NOT_FOUND_ENTITY));

		if("phone".equals(user.getProvider())) {
			user.getSecurity().setPassword(MoyamoPasswordEncoder.hashedPassword(resetPassword, user.getSecurity().getSalt()));
		} else {
			user.getSecurity().setPassword(passwordEncoder.encode(resetPassword));
		}

		return true;
	}


	@Transactional
    public boolean updateMemo(Long userId, String memo) {
		User user = userRepository.findById(userId).orElseThrow(() -> new MoyamoGlobalException(MoyamoGlobalException.Messages.NOT_FOUND_ENTITY));

		if(user.getSecurity() != null)
			user.getSecurity().setMemo(memo);

		return true;
    }

	@Transactional
	public boolean updatePhotoEnable(Long userId, boolean photoEnable) {
		User user = userRepository.findById(userId).orElseThrow(() -> new MoyamoGlobalException(MoyamoGlobalException.Messages.NOT_FOUND_ENTITY));

		if(user.getSecurity() != null)
			user.getUserSetting().setPhotoEnable(photoEnable);

		return true;
	}
}
