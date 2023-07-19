package net.infobank.moyamo.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.exception.MoyamoGlobalException;
import net.infobank.moyamo.models.Posting;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.models.UserPostingRelation;
import net.infobank.moyamo.models.WatchPosting;
import net.infobank.moyamo.repository.PostingRepository;
import net.infobank.moyamo.repository.WatchPostingRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

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
public class WatchPostingService {

    private final PostingRepository postingRepository;
    private final WatchPostingRepository watchPostingRepository;

    private boolean editWatch(long id, User user, boolean enable) { //NOSONAR
        Posting posting = postingRepository.findLockOnly(id).orElseThrow(() -> new MoyamoGlobalException("not found Entity"));
        validateNotPhoto(posting);
        PostingService.validateAccessPosting(posting, user);
        UserPostingRelation pk = new UserPostingRelation(user, posting);

        WatchPosting userWatch = watchPostingRepository.findByIdEquals(pk);
        if (userWatch == null) {

            if(posting.getOwner().equals(user) && enable) {
                //글작성자가 알림받기 설정을 할경우
                return true;
            } else {
                userWatch = new WatchPosting(posting.getPostingType(), pk);
                userWatch.setEnable(enable);
                watchPostingRepository.save(userWatch);
            }
        } else {
            if(posting.getOwner().equals(user) && enable) {
                //글작성자가 알림받기 해제할 경우 삭제
                watchPostingRepository.delete(userWatch);
            } else {
                userWatch.setEnable(enable);
            }
        }
        return true;
    }

    @Transactional(isolation = Isolation.SERIALIZABLE)
    public boolean watch(long id, User user) {
        return editWatch(id, user, true);
    }

    @Transactional(isolation = Isolation.SERIALIZABLE)
    public boolean unwatch(long id, User user) {
        return editWatch(id, user, false);
    }

    public Boolean isWatchPost(long id, User user) {
        UserPostingRelation pk = new UserPostingRelation(user, postingRepository.getOne(id));
        WatchPosting userWatch = watchPostingRepository.findByIdEquals(pk);
        return (userWatch != null) ? userWatch.isEnable() : null;
    }

}

