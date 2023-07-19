package net.infobank.moyamo.jobs.statistics;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.enumeration.OsType;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.models.Statistics;
import net.infobank.moyamo.models.StatisticsDaily;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.repository.StatisticsRepository;
import net.infobank.moyamo.repository.statistics.*;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Tuple;
import java.math.BigInteger;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@AllArgsConstructor
@Configuration
public class StatisticsJobs {

    private static final ZoneId ASIA_SEOUL_ZONEID = ZoneId.of("Asia/Seoul");

    private final UserLoginHistoryAnalyzeRepository userLoginHistoryAnalyzeRepository;
    private final UserAnalyzeRepository userAnalyzeRepository;
    private final PostingAnalyzeRepository postingAnalyzeRepository;
    private final CommentAnalyzeRepository commentAnalyzeRepository;
    private final ScrapPostingAnalyzeRepository scrapPostingAnalyzeRepository;
    private final LikePostingAnalyzeRepository likePostingAnalyzeRepository;
    private final SharePostingAnalyzeRepository sharePostingAnalyzeRepository;
    private final StatisticsRepository statisticsRepository;
    private final UserLeaveHistoryAnalyzeRepository userLeaveHistoryAnalyzeRepository;
    public class StatisticsJob {

        public StatisticsJob() {
            this.lastWorkingDate = getLocalDate().minusDays(30);
        }

        public StatisticsJob(ZonedDateTime lastWorkingDate) {
            this.lastWorkingDate = lastWorkingDate;
        }

        private ZonedDateTime lastWorkingDate;

        @SuppressWarnings("unused")
        private void initLastId(StatisticsDaily statisticsDaily) {
            if(statisticsDaily.getLastPostingId() == null) statisticsDaily.setLastPostingId(0L);
            if(statisticsDaily.getLastCommentId() == null) statisticsDaily.setLastCommentId(0L);
            if(statisticsDaily.getLastLikeId() == null) statisticsDaily.setLastLikeId(0L);
            if(statisticsDaily.getLastScrapId() == null) statisticsDaily.setLastScrapId(0L);
            if(statisticsDaily.getLastShareId() == null) statisticsDaily.setLastShareId(0L);
            if(statisticsDaily.getLastUserId() == null) statisticsDaily.setLastUserId(0L);
        }

        @SuppressWarnings("java:S3776")
        private void doWork(ZonedDateTime date, Statistics current, Statistics before) {

            log.debug("통계 분석 시작 : {}", date);

            Long startPostingId  = (before != null && before.getLastPostingId() != null) ? before.getLastPostingId() : -1L;
            if(current != null && current.getFirstPostingId() != null && startPostingId < current.getLastPostingId()) {
                startPostingId = current.getFirstPostingId();
            }

            Long startCommentId = (before != null && before.getLastCommentId() != null) ? before.getLastCommentId() : -1L;
            if(current != null && current.getFirstCommentId() != null && startCommentId < current.getFirstCommentId()) {
                startCommentId = current.getFirstCommentId();
            }

            Long startUserId = (before != null && before.getLastUserId() != null) ? before.getLastUserId(): -1L;
            if(current != null && current.getFirstUserId() != null && startUserId < current.getFirstUserId()) {
                startUserId = current.getFirstUserId();
            }

            Long startShareId = (before != null && before.getLastShareId() != null) ? before.getLastShareId() : -1L;
            if(current != null && current.getFirstShareId() != null && startShareId < current.getFirstShareId()) {
                startShareId = current.getFirstShareId();
            }

            Long startLikeId = (before != null &&  before.getLastLikeId() != null) ? before.getLastLikeId() : -1L;
            if(current != null && current.getFirstLikeId() != null && startLikeId < current.getFirstLikeId()) {
                startLikeId = current.getFirstLikeId();
            }

            Long startScrapId = (before != null &&  before.getLastScrapId() != null) ? before.getLastScrapId() : -1L;
            if(current != null && current.getFirstScrapId() != null && startScrapId < current.getFirstScrapId()) {
                startScrapId = current.getFirstScrapId();
            }

            Long startLeaveId = (before != null &&  before.getLastLeaveId() != null) ? before.getLastLeaveId() : -1L;
            if(current != null && current.getFirstLeaveId() != null && startLeaveId < current.getFirstLeaveId()) {
                startLeaveId = current.getFirstLeaveId();
            }

            Long startLoginHistoryId = (before != null &&  before.getLastLoginHistoryId() != null) ? before.getLastLoginHistoryId() : -1L;
            if(current != null && current.getFirstLoginHistoryId() != null && startLoginHistoryId < current.getFirstLoginHistoryId()) {
                startLoginHistoryId = current.getFirstLoginHistoryId();
            }

            //range 조회는 timezone 안먹는듯.
            ZonedDateTime from = min(date);
            ZonedDateTime to = from.plusDays(1L);
            log.info("statistics working date : {}, from : {}, to : {}", date, from, to);
            Statistics today = (current != null) ? current : new Statistics(date);

            /*
             * 사용자 통계
             */
            Tuple userAnalyzeResult = userAnalyzeRepository.count(startUserId, from, to);
            Long userMaxId = userAnalyzeResult.get(1 , Long.class);

            today.setFirstUserId(startUserId);
            if(userMaxId != null) {
                today.setLastUserId(userMaxId);
            }  else {
                today.setLastUserId(startUserId);
            }

            Long userMinId = userAnalyzeResult.get(2 , Long.class);
            if(0 >= today.getFirstUserId()) {
                today.setFirstUserId(startUserId);
            }


            if(userMinId != null && today.getFirstUserId() < userMinId) {
                today.setFirstUserId(userMinId);
            }


            List<Tuple> userGroupByOsTypeList = userAnalyzeRepository.groupByOsType(startUserId, from, to);
            today.setAndroidJoinCount(0);
            today.setIosJoinCount(0);
            today.setEtcJoinCount(0);
            for(Tuple t : userGroupByOsTypeList) {
//                String strDate = (String)t.get(0);
                String strOsType = (String)t.get(1);
                int count = ((BigInteger)t.get(2)).intValue();

                if(OsType.android.name().equals(strOsType)) {
                    today.setAndroidJoinCount(count);
                } else if(OsType.ios.name().equals(strOsType)) {
                    today.setIosJoinCount(count);
                } else {
                    today.setEtcJoinCount(count);
                }
            }

            List<Tuple> userGroupByProviderList = userAnalyzeRepository.groupByProvider(startUserId, from, to);

            today.setCumAndroidJoinCount(((before != null && before.getCumAndroidJoinCount() != null) ? before.getCumAndroidJoinCount() : 0) + (today.getAndroidJoinCount()));
            today.setCumIosJoinCount(((before != null && before.getCumIosJoinCount() != null) ? before.getCumIosJoinCount() : 0) + (today.getIosJoinCount()));
            today.setCumEtcJoinCount(((before != null && before.getCumEtcJoinCount() != null) ? before.getCumEtcJoinCount() : 0) + (today.getEtcJoinCount()));

            for(Tuple t : userGroupByProviderList) {
//                String strDate = (String)t.get(0);
                String provider = (String)t.get(1);
                int count = ((BigInteger)t.get(2)).intValue();

                if("kakao".equals(provider)) {
                    today.setKakaoJoinCount(count);
                } else if("naver".equals(provider)) {
                    today.setNaverJoinCount(count);
                } else if("email".equals(provider)) {
                    today.setEmailJoinCount(count);
                } else if("facebook".equals(provider)) {
                    today.setFacebookJoinCount(count);
                } else if("apple".equals(provider)) {
                    today.setAppleJoinCount(count);
                } else if("phone".equals(provider)) {
                    today.setPhoneJoinCount(count);
                }
            }

            today.setCumKakaoJoinCount(((before != null && before.getCumKakaoJoinCount() != null) ? before.getCumKakaoJoinCount() : 0) + (today.getKakaoJoinCount()));
            today.setCumNaverJoinCount(((before != null && before.getCumNaverJoinCount() != null) ? before.getCumNaverJoinCount() : 0) + (today.getNaverJoinCount()));
            today.setCumEmailJoinCount(((before != null && before.getCumEmailJoinCount() != null) ? before.getCumEmailJoinCount() : 0) + (today.getEmailJoinCount()));
            today.setCumFacebookJoinCount(((before != null && before.getCumFacebookJoinCount() != null) ? before.getCumFacebookJoinCount() : 0) + (today.getFacebookJoinCount()));
            today.setCumAppleJoinCount(((before != null && before.getCumAppleJoinCount() != null) ? before.getCumAppleJoinCount() : 0) + (today.getAppleJoinCount()));
            today.setCumPhoneJoinCount(((before != null && before.getCumPhoneJoinCount() != null) ? before.getCumPhoneJoinCount() : 0) + (today.getPhoneJoinCount()));

            Tuple leaveCountResult = userLeaveHistoryAnalyzeRepository.count(startLeaveId, from, to);
            today.setLeaveCount(leaveCountResult.get(0 , Long.class).intValue());
            Long leaveMaxId = leaveCountResult.get(1 , Long.class);

            Long leaveMinId = leaveCountResult.get(2 , Long.class);
            if(userMaxId != null) {
                today.setLastLeaveId(leaveMaxId);
            }  else {
                today.setLastLeaveId(startLeaveId);
            }

            if(today.getFirstLeaveId() == null || 0 >= today.getFirstLeaveId()) {
                today.setFirstLeaveId(startLeaveId);
            }

            if(leaveMinId != null && today.getFirstLeaveId() < leaveMinId) {
                today.setFirstLeaveId(leaveMinId);
            }

            /*
             * 사용자 통계 End
             */

            /*
             * 게시글 통계
             */

            Tuple postingAnalyzeResult = postingAnalyzeRepository.count(startPostingId, from, to);
            Long postingMaxId = postingAnalyzeResult.get(1 , Long.class);
            today.setFirstPostingId(startPostingId);
            if(postingMaxId != null) {
                today.setLastPostingId(postingMaxId);
            }  else {
                today.setLastPostingId(startPostingId);
                postingMaxId = startPostingId;
            }

            Long postingMinId = postingAnalyzeResult.get(2 , Long.class);
            if(today.getFirstPostingId() == null || 0 >= today.getFirstPostingId() ) {
                today.setFirstPostingId(postingMinId);
            }

            if(postingMinId != null && today.getFirstPostingId() < postingMinId) {
                today.setFirstPostingId(postingMinId);
            }

            Map<String, Long> postingGroup = postingAnalyzeRepository
                    .postingTypeGroup(startPostingId, from, to)
                    .stream().collect(Collectors.toMap(o -> o.get(0, String.class), o -> o.get(1, BigInteger.class).longValue()));

            if(log.isDebugEnabled())
                log.debug("postingGroup : {}", postingGroup);

            today.setQuestionCount(postingGroup.getOrDefault(PostingType.question.getDiscriminatorValue(), 0L).intValue());
            today.setBoastCount(postingGroup.getOrDefault(PostingType.boast.getDiscriminatorValue(), 0L).intValue());
            today.setGuidebookCount(postingGroup.getOrDefault(PostingType.guidebook.getDiscriminatorValue(), 0L).intValue());
            today.setClinicCount(postingGroup.getOrDefault(PostingType.clinic.getDiscriminatorValue(), 0L).intValue());
            today.setFreeCount(postingGroup.getOrDefault(PostingType.free.getDiscriminatorValue(), 0L).intValue());
            today.setMagazineCount(postingGroup.getOrDefault(PostingType.magazine.getDiscriminatorValue(), 0L).intValue());

            /*
             * 게시글 통계 End
             */


            /*
             * 답변 통계
             */

            Tuple commentAnalyzeResult = commentAnalyzeRepository.count(startCommentId, from, to);
            int commentCount = commentAnalyzeResult.get(0 , Long.class).intValue();
            Long commentMaxId = commentAnalyzeResult.get(1 , Long.class);
            today.setCommentsCount(commentCount);
            if(commentMaxId != null) {
                today.setLastCommentId(commentMaxId);
            }  else {
                today.setLastCommentId(startCommentId);
            }

            Long commentMinId = commentAnalyzeResult.get(2 , Long.class);
            if(today.getFirstCommentId() == null || 0 >= today.getFirstCommentId()) {
                today.setFirstCommentId(startCommentId);
            }

            if(commentMinId != null && today.getFirstCommentId() < commentMinId) {
                today.setFirstCommentId(commentMinId);
            }

            //질문의 답변 지연시간 통계
            Tuple lateCommentsResult = commentAnalyzeRepository.lateComments(startPostingId, postingMaxId, from, to);

            //첫 답변 10분 이상
            Integer late10 = ((BigInteger)lateCommentsResult.get(0)).intValue();

            //첫 답변 30분 이상
            Integer late30 = ((BigInteger)lateCommentsResult.get(1)).intValue();
            today.setLateReplyCount10(late10);
            today.setLateReplyCount30(late30);

            /*
             * 답변 통계 End
             */

            today.setFirstScrapId(startScrapId);
            Tuple scrapAnalyzeResult = scrapPostingAnalyzeRepository.count(startScrapId, from, to);
            int scrapCount = scrapAnalyzeResult.get(0 , Long.class).intValue();
            Long scrapMaxId = scrapAnalyzeResult.get(1 , Long.class);
            today.setScrapCount(scrapCount);
            if(scrapMaxId != null) {
                today.setLastScrapId(scrapMaxId);
            }  else {
                today.setLastScrapId(startScrapId);
            }

            Long scrapMinId = scrapAnalyzeResult.get(2 , Long.class);
            if(today.getFirstScrapId() == null || 0 >= today.getFirstScrapId()) {
                today.setFirstScrapId(startScrapId);
            }

            if(scrapMinId != null && today.getFirstScrapId() < scrapMinId) {
                today.setFirstScrapId(scrapMinId);
            }
            /*
             * 스크랩 통계 End
             */


            /*
             * 공유 통계
             */
            today.setFirstShareId(startShareId);
            Tuple shareAnalyzeResult = sharePostingAnalyzeRepository.count(startShareId, from, to);
            int shareCount = shareAnalyzeResult.get(0 , Long.class).intValue();
            Long shareMaxId = shareAnalyzeResult.get(1 , Long.class);
            today.setShareCount(shareCount);
            if(shareMaxId != null) {
                today.setLastShareId(shareMaxId);
            }  else {
                today.setLastShareId(startShareId);
            }

            Long shareMinId = shareAnalyzeResult.get(2 , Long.class);
            if(today.getFirstShareId() == null || 0 >= today.getFirstShareId()) {
                today.setFirstShareId(startShareId);
            }

            if(shareMinId != null && today.getFirstShareId() < shareMinId) {
                today.setFirstShareId(shareMinId);
            }
            /*
             * 공유 통계 End
             */

            /*
             * 좋아요 통계
             */
            today.setFirstLikeId(startLikeId);
            Tuple likeAnalyzeResult = likePostingAnalyzeRepository.count(startLikeId, from, to);
            int likeCount = likeAnalyzeResult.get(0 , Long.class).intValue();
            Long likeMaxId = likeAnalyzeResult.get(1 , Long.class);
            today.setLikePostingCount(likeCount);
            if(likeMaxId != null) {
                today.setLastLikeId(likeMaxId);
            }  else {
                today.setLastLikeId(startLikeId);
            }

            Long likeMinId = likeAnalyzeResult.get(2 , Long.class);
            if(today.getFirstLikeId() == null || 0 >= today.getFirstLikeId()) {
                today.setFirstLikeId(startLikeId);
            }

            if(likeMinId != null && today.getFirstLikeId() < likeMinId) {
                today.setFirstLikeId(likeMinId);
            }

            /*
             * 좋아요 통계 End
             */


            /*
             * 로그인 통계
             */
            today.setFirstLoginHistoryId(startLoginHistoryId);
            Tuple loginHistoryAnalyzeResult = userLoginHistoryAnalyzeRepository.count(startLoginHistoryId, from, to);
            int loginHistoryCount = loginHistoryAnalyzeResult.get(0 , Long.class).intValue();
            Long loginHistoryMaxId = loginHistoryAnalyzeResult.get(1 , Long.class);
            today.setLoginCount(loginHistoryCount);
            if(loginHistoryMaxId != null) {
                today.setLastLoginHistoryId(loginHistoryMaxId);
            }  else {
                today.setLastLoginHistoryId(startLoginHistoryId);
            }

            Long loginHistoryMinId = loginHistoryAnalyzeResult.get(2 , Long.class);
            if(today.getFirstLoginHistoryId() == null || 0 >= today.getFirstLoginHistoryId()) {
                today.setFirstLoginHistoryId(startLoginHistoryId);
            }

            if(loginHistoryMinId != null && today.getFirstLoginHistoryId() < loginHistoryMinId) {
                today.setFirstLoginHistoryId(loginHistoryMinId);
            }

            /*
             * 로그인 통계 End
             */

            //이전 데이터 마지막 업데이트
            if(current == null && before != null) {
                before.setLastPostingId((before.getFirstPostingId() < startPostingId) ? startPostingId - 1L : startPostingId);
                before.setLastUserId((before.getFirstUserId() < startUserId) ? startUserId - 1L : startUserId);
                before.setLastCommentId((before.getFirstCommentId() < startCommentId) ? startCommentId - 1L: startCommentId);
                before.setLastLeaveId((before.getFirstLeaveId() < startLeaveId) ? startLeaveId -1L : startLeaveId);
                before.setLastLikeId((before.getFirstLikeId() < startLikeId) ? startLikeId - 1L : startLikeId);
                before.setLastScrapId((before.getFirstScrapId() < startScrapId) ? startScrapId - 1L : startScrapId);
                before.setLastShareId((before.getFirstShareId() < startShareId) ? startShareId - 1L : startShareId);
                before.setLastLoginHistoryId((before.getFirstLoginHistoryId() < startLoginHistoryId) ? startLoginHistoryId - 1L : startLoginHistoryId);
            }

            statisticsRepository.save(today);
            updateLastWorkingDate(date);
            log.info("통계 분석 종료 : {} / {}", date, today);
        }

        //한국 시간 기준 (주의) 날짜가 넘어가는 시점에 이전 날짜의 통계를 돌리기 위해 데이트 주기가 30분이 안돼야합니다.
        private ZonedDateTime getLocalDate() {
            return ZonedDateTime.now().minusMinutes(30).withZoneSameInstant(ASIA_SEOUL_ZONEID).withHour(0).withMinute(0).withSecond(0).withNano(0);
        }


        //한국 시간 기준
        private ZonedDateTime getWorkingDate() {
            ZonedDateTime localDate = getLocalDate();
            log.info("{} .isBefore({})", lastWorkingDate, localDate);
            if(lastWorkingDate.isBefore(localDate)) {
                return lastWorkingDate.plusDays(1);
            } else {
                return localDate;
            }
        }

        private void updateLastWorkingDate(ZonedDateTime date) {
            this.lastWorkingDate = date;
        }


        @Transactional
        @Scheduled(cron="${moyamo.jobs.statistics.cron:0 */30 * * * *}")
        public void worker() {
            log.debug("StatisticsJob");

            //한국 시간 기준
            ZonedDateTime localDate = getWorkingDate();

            //equal 조회는 ZonedId 에 따라 계산돼 조회함 DB(2020-01-01 15:00:00 UTC) == localDate(2020-01-02 00:00:00 Asia/Seoul)
            Statistics statisticsDaily = statisticsRepository.findByDate(localDate);

            log.debug("통계 업데이트 조회({}) : {}", localDate, statisticsDaily);
            if(statisticsDaily == null) {

                //localDate 이전 날짜 중 가장 최신 row 를 가져온다.
                Statistics beforeStatisticsDaily = statisticsRepository.findByDate(localDate.minusDays(1));

                log.debug("이전 통계날짜 조회 : {}", beforeStatisticsDaily);

                ZonedDateTime workingDate = localDate;
                //마지막 통계가 있을 경우 +1D 의 통계분석을 시도함, 없을 경우 한 달 전 통계 분석부터 시작
                doWork(workingDate, null, beforeStatisticsDaily);
            } else {

                Statistics beforeStatisticsDaily = statisticsRepository.findByDate(localDate.minusDays(1));
                doWork(localDate, statisticsDaily, beforeStatisticsDaily);
            }

        }
    }

    private ZonedDateTime min(ZonedDateTime from) {
        return from.withZoneSameInstant(ASIA_SEOUL_ZONEID).withHour(0).withMinute(0).withSecond(0).withNano(0);
    }

    /**
     * 통계 업데이트
     * @return StatisticsJob
     */
    @Bean
    @ConditionalOnProperty(value = "moyamo.jobs.statistics.enable", matchIfMissing = true, havingValue = "true")
    public StatisticsJob statisticsUpdateScheduledJob() {

        Page<User> page = userAnalyzeRepository.findAll(PageRequest.of(0, 1));

        if(!page.getContent().isEmpty()) {
            ZonedDateTime firstWorkingDate = min(page.getContent().get(0).getCreatedAt().withZoneSameInstant(ASIA_SEOUL_ZONEID));
            Statistics statisticsDaily = statisticsRepository.findLastOnce(firstWorkingDate);
            if(statisticsDaily != null) {
                firstWorkingDate = statisticsDaily.getDt();
            }

            ZonedDateTime startDate = ZonedDateTime.of(LocalDate.of(2020, 9, 14), LocalTime.MIN, ASIA_SEOUL_ZONEID);
            if(firstWorkingDate.isBefore(startDate)) {
                return new StatisticsJob(startDate);
            } else {
                return new StatisticsJob(firstWorkingDate.minusDays(1));
            }


        } else {
            return new StatisticsJob();
        }

    }

}
