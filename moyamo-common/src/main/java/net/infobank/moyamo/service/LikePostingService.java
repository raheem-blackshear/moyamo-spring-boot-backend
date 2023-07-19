package net.infobank.moyamo.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.exception.MoyamoGlobalException;
import net.infobank.moyamo.models.LikePosting;
import net.infobank.moyamo.models.Posting;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.models.UserPostingRelation;
import net.infobank.moyamo.repository.LikePostingRepository;
import net.infobank.moyamo.repository.PostingRepository;
import net.infobank.moyamo.repository.UserRepository;
import net.infobank.moyamo.service.elasticsearch.CacheValues;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Caching;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static net.infobank.moyamo.util.ValidateNotPhotoUtils.validateNotPhoto;

/**
 * 주의)
 * 게시글 좋아요시에 상세 조회에서만 업데이트
 * 리스트 조회는 캐시 시간동안 업데이트 확인불가
 *
 */
@Slf4j
@Service
@AllArgsConstructor
public class LikePostingService {

    private final PostingRepository postingRepository;
    private final LikePostingRepository likePostingRepository;
    private final NotificationService notificationService;
    private final UserRepository userRepository;

    @Transactional(isolation = Isolation.SERIALIZABLE)
    @Caching(evict = {
            @CacheEvict(value = CacheValues.POSTINGS, key = "#id")
    })
    public PostingDto addLike(long id, User user) {
        Posting posting = postingRepository.findLockOnly(id).orElseThrow(() -> new MoyamoGlobalException("not found Entity"));
        PostingService.validateAccessPosting(posting, user);

        UserPostingRelation pk = new UserPostingRelation(user, posting);

        //optional 로 처리시 query 가 2 번 나감 (select 할 때, .get() 할 때)
        LikePosting userLike = likePostingRepository.findByIdEquals(pk);
        if (userLike == null) {
            userLike = likePostingRepository.save(new LikePosting(pk, posting.getPostingType()));
            postingRepository.updateLikeCount(id, 1);
            postingRepository.updateReadCount(id, 1);
            if(!posting.getOwner().equals(user))
                notificationService.afterNewLike(userLike, posting.getOwner());

            if(posting.getPostingType() == PostingType.photo){
                userRepository.updateIncrementPhotoLikeCount(posting.getOwner().getId());
            }
        }

        return PostingDto.of(posting);
    }

    @Caching(evict = {
            @CacheEvict(value = CacheValues.POSTINGS, key = "#id")
    })
    @SuppressWarnings({"unused", "UnusedReturnValue"})
    @Transactional(isolation = Isolation.SERIALIZABLE)
    public PostingDto removeLike(long id, User user) {
        Posting posting = postingRepository.findLockOnly(id).orElseThrow(() -> new MoyamoGlobalException("not found Entity"));
        PostingService.validateAccessPosting(posting, user);

        UserPostingRelation pk = new UserPostingRelation(user, posting);

        //optional 로 처리시 query 가 2 번 나감 (select 할 때, .get() 할 때)
        LikePosting userLike = likePostingRepository.findByIdEquals(pk);
        if (userLike != null) {
            likePostingRepository.delete(userLike);
            postingRepository.updateLikeCount(id, -1);

            if(posting.getPostingType() == PostingType.photo){
                userRepository.updateDecrementPhotoLikeCount(posting.getOwner().getId());
            }
        }
        return PostingDto.of(posting);
    }

    public boolean isLikePost(long id, User user) {
        UserPostingRelation pk = new UserPostingRelation(user, postingRepository.getOne(id));
        LikePosting userLike = likePostingRepository.findByIdEquals(pk);
        return userLike != null;
    }

    public Map<Long, Boolean> findListByUser(List<Long> ids, User owner) {
        if (ids == null || ids.isEmpty()) {
            return Collections.emptyMap();
        }

        return Collections.unmodifiableMap(likePostingRepository.findLikes(ids, owner.getId()).stream()
                .collect(Collectors.toMap(tuple -> ((Long) tuple.get("id")), tuple -> true)));

    }

}

