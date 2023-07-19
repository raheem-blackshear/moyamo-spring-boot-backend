package net.infobank.moyamo.jobs.statistics;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.domain.Event;
import net.infobank.moyamo.domain.EventAction;
import net.infobank.moyamo.domain.EventType;
import net.infobank.moyamo.domain.badge.Badges;
import net.infobank.moyamo.domain.badge.TopUsers;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.interfaces.EventServerInterface;
import net.infobank.moyamo.models.*;
import net.infobank.moyamo.models.board.BoardDiscriminatorValues;
import net.infobank.moyamo.models.board.Question;
import net.infobank.moyamo.repository.*;
import net.infobank.moyamo.repository.statistics.*;
import net.infobank.moyamo.service.BadgeService;
import net.infobank.moyamo.service.RankingService;
import net.infobank.moyamo.util.HashtagUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import javax.persistence.Tuple;
import java.math.BigInteger;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@SuppressWarnings("unused")
@Slf4j
@AllArgsConstructor
@Configuration
public class RankingJobs {

    private static final ZoneId ASIA_SEOUL_ZONEID = ZoneId.of("Asia/Seoul");

    private final UserAnalyzeRepository userAnalyzeRepository;
    private final StatisticsRepository statisticsRepository;
    private final PostingRepository postingRepository;
    private final CommentRepositoryCustom commentRepositoryCustom;
    private final CommentAnalyzeRepositoryCustom commentAnalyzeRepositoryCustom;
    private final LikePostingAnalyzeRepositoryCustom likePostingAnalyzeRepositoryCustom;
    private final QuestionRepositoryCustom questionRepositoryCustom;
    private final CommentRepository commentRepository;
    private final AdoptCommentAnalyzeRepositoryCustom adoptCommentAnalyzeRepositoryCustom;
    private final PostingRankingRepository postingRankingRepository;
    private final UserRankingRepository userRankingRepository;
    private final KeywordRankingRepository keywordRankingRepository;
    private final UserRepository userRepository;
    private final TagRepository tagRepository;
    private final RankingLogRepository rankingLogRepository;
    private final RankingService rankingService;
    private final EventServerInterface eventServerInterface;
    private final RabbitTemplate rabbitTemplate;
    private final BadgeService badgeService;
    private final PostingAnalyzeRepository postingAnalyzeRepository;

    private ZonedDateTime min(ZonedDateTime from) {
        return from.withZoneSameInstant(ASIA_SEOUL_ZONEID).withHour(0).withMinute(0).withSecond(0).withNano(0);
    }

    private static final int MAX_RANKING = 100;

    //제외할 사용자ID
    private static final Set<Long> IGNORE_USER_IDS = new HashSet<>(Collections.singletonList(901747L));


    /**
     * 랭킹통계 업데이트
     */
    @Bean
    @ConditionalOnProperty(value = "moyamo.jobs.ranking.enable", matchIfMissing = true, havingValue = "true")
    public RankingJob rankingUpdateScheduledJob() {

        Page<User> page = userAnalyzeRepository.findAll(PageRequest.of(0, 1));
        if(!page.getContent().isEmpty()) {
            ZonedDateTime firstWorkingDate = min(page.getContent().get(0).getCreatedAt().withZoneSameInstant(ASIA_SEOUL_ZONEID));
            Statistics statisticsDaily = statisticsRepository.findLastOnce(firstWorkingDate);
            if(statisticsDaily != null) {
                firstWorkingDate = statisticsDaily.getDt();
            }

            ZonedDateTime startDate = ZonedDateTime.of(LocalDate.of(2020, 9, 14), LocalTime.MIN, ASIA_SEOUL_ZONEID);
            if(firstWorkingDate.isBefore(startDate)) {
                return new RankingJob(startDate);
            } else {
                return new RankingJob(firstWorkingDate.minusDays(1));
            }
        } else {
            return new RankingJob();
        }

    }

    public class RankingJob {

        public RankingJob() {
            this.lastWorkingDate = getLocalDate().minusDays(30);
        }

        public RankingJob(ZonedDateTime lastWorkingDate) {
            this.lastWorkingDate = lastWorkingDate;
        }

        private ZonedDateTime lastWorkingDate;

        void initLastId(StatisticsDaily statisticsDaily) {
            if(statisticsDaily.getLastPostingId() == null) statisticsDaily.setLastPostingId(0L);
            if(statisticsDaily.getLastCommentId() == null) statisticsDaily.setLastCommentId(0L);
            if(statisticsDaily.getLastLikeId() == null) statisticsDaily.setLastLikeId(0L);
            if(statisticsDaily.getLastScrapId() == null) statisticsDaily.setLastScrapId(0L);
            if(statisticsDaily.getLastShareId() == null) statisticsDaily.setLastShareId(0L);
            if(statisticsDaily.getLastUserId() == null) statisticsDaily.setLastUserId(0L);
        }

        @Data
        @AllArgsConstructor
        @NoArgsConstructor
        private class KeywordRawData {

            private String keyword;
            private Long id;

            @Override
            public boolean equals(Object o) {
                if (this == o) return true;
                if (!(o instanceof KeywordRawData)) return false;
                KeywordRawData that = (KeywordRawData) o;
                return keyword.equals(that.keyword) && id.equals(that.id);
            }

            @Override
            public int hashCode() {
                return Objects.hash(keyword, id);
            }
        }

        @Data
        @NoArgsConstructor
        private class CommentRawData {

            private Long postingId;
            private Long id;

            public CommentRawData(Long postingId, Long id) {
                this.postingId = postingId;
                this.id = id;
            }

            @Override
            public boolean equals(Object o) {
                if (this == o) return true;
                if (!(o instanceof CommentRawData)) return false;
                CommentRawData that = (CommentRawData) o;
                return Objects.equals(postingId, that.postingId) && Objects.equals(id, that.id);
            }

            @Override
            public int hashCode() {
                return Objects.hash(postingId, id);
            }
        }

        @Data
        @NoArgsConstructor
        private class UserCommentRawData {

            private Long postingId;
            private Long userId;

            public UserCommentRawData(Long postingId, Long userId) {
                this.postingId = postingId;
                this.userId = userId;
            }

            @Override
            public boolean equals(Object o) {
                if (this == o) return true;
                if (!(o instanceof UserCommentRawData)) return false;
                UserCommentRawData that = (UserCommentRawData) o;
                return Objects.equals(postingId, that.postingId) && Objects.equals(userId, that.userId);
            }

            @Override
            public int hashCode() {
                return Objects.hash(postingId, userId);
            }
        }

        /**
         * 인기질문
         * - 답변의 해시태그 기반으로 식물이름 랭킹
         */
        private void doWorkQuestionTagRaking(ZonedDateTime dt, ZonedDateTime from, ZonedDateTime to) {

            log.info("최근 게시물 태그 랭킹");

            Map<String, Long> grouping = new HashMap<>();
            keywordGrouping(grouping, from ,to);

            //갯수 정렬로 출력
            List<Map.Entry<String, Long>> entryList = grouping.entrySet().stream().sorted((o1, o2) -> o2.getValue().compareTo(o1.getValue())).collect(Collectors.toList());

            List<net.infobank.moyamo.models.KeywordRanking> oldestRankings = keywordRankingRepository.findAllByRankingTypeAndDate(Ranking.RankingType.best_keyword, dt);
            keywordRankingRepository.deleteAll(oldestRankings);

            List<net.infobank.moyamo.models.KeywordRanking> newestRankings  = entryList.stream().map(ranking ->
                net.infobank.moyamo.models.KeywordRanking.builder()
                        .keyword(ranking.getKey()).rankingType(Ranking.RankingType.best_keyword)
                        .date(dt).score(ranking.getValue()).build()
            ).limit(MAX_RANKING).collect(Collectors.toList());

            keywordRankingRepository.saveAll(newestRankings);
        }

        private void keywordGrouping(Map<String, Long> grouping, ZonedDateTime from , ZonedDateTime to) {
            int offset = 0;
            int count = 1000;

            List<Statistics> statisticsList = statisticsRepository.findByRange(from, to);
            List<Comment> commentList = commentAnalyzeRepositoryCustom.findListByRange(offset, count, from, to, statisticsList);
            List<KeywordRawData> rawDataList = new ArrayList<>();
            while(!commentList.isEmpty()) {
                rawDataList.addAll(commentList.stream()
                        .flatMap(comment -> HashtagUtils.extract(comment.getText()).stream().filter(StringUtils::isNotBlank).map(keyword -> new KeywordRawData(keyword, comment.getPosting().getId()))).collect(Collectors.toList()));

                if(commentList.size() == count) {
                    offset += count;
                    commentList = commentAnalyzeRepositoryCustom.findListByRange(offset, count, from, to, statisticsList);
                } else {
                    break;
                }
            }

            grouping.putAll(rawDataList.stream()
                    .distinct()
                    .map(KeywordRawData::getKeyword)
                    .collect(Collectors.groupingBy(o -> o, Collectors.counting())));
        }

        private void commentGrouping(Map<Long, Long> grouping, ZonedDateTime from, ZonedDateTime to) {
            grouping(grouping, from, to, param -> {
                List<Statistics> statisticsList = statisticsRepository.findByRange(from, to);
                return commentAnalyzeRepositoryCustom.findListByRange(param.getOffset(), param.getCount(), param.getFrom(), param.getTo(), statisticsList);
            }, comment -> comment.getPosting().getId());
        }

        private void likePostingGrouping(Map<Long, Long> grouping, ZonedDateTime from, ZonedDateTime to) {
            grouping(grouping, from, to, param -> {
                List<Statistics> statisticsList = statisticsRepository.findByRange(from, to);
                return likePostingAnalyzeRepositoryCustom.findListByRange(param.getOffset(), param.getCount(), param.getFrom(), param.getTo(), statisticsList);
            }, likePosting -> {
                if(isNotExistPosting(likePosting)) return 0L;
                return likePosting.getRelation().getPosting().getId();
            });
        }

        @SuppressWarnings("unused")
        private void likeUserGrouping(Map<Long, Long> grouping, ZonedDateTime from, ZonedDateTime to) {
            grouping(grouping, from, to, param -> {
                List<Statistics> statisticsList = statisticsRepository.findByRange(from, to);
                return likePostingAnalyzeRepositoryCustom.findListByRange(param.getOffset(), param.getCount(), param.getFrom(), param.getTo(), statisticsList);
            }, likePosting -> {
                if(isNotExistUser(likePosting)) return 0L;
                return likePosting.getRelation().getUser().getId();
            });
        }

        @Data
        @NoArgsConstructor
        @AllArgsConstructor
        private class PostingRanking implements Comparable<PostingRanking>{

            private Long id;
            private long score;

            @Override
            public int compareTo(PostingRanking o) {
                int compare = NumberUtils.compare(this.score, o.score);
                return (compare != 0) ? compare : NumberUtils.compare(this.id, o.id);
            }

            @Override
            public String toString() {
                return "PostingRanking{" +
                        "posting=" + this.id +
                        ", score=" + score +
                        '}';
            }
        }

        @Data
        @NoArgsConstructor
        @AllArgsConstructor
        private class UserRanking implements Comparable<UserRanking>{

            private long userId;

            private long score;

            @Override
            public int compareTo(UserRanking o) {
                int compare = NumberUtils.compare(this.score, o.score);
                return (compare != 0) ? compare : NumberUtils.compare(this.userId, o.userId);
            }

            @Override
            public String toString() {
                return "UserRanking{" +
                        "user=" + userId +
                        ", score=" + score +
                        '}';
            }
        }

        @SuppressWarnings("SameParameterValue")
        private void likeGrouping(PostingType postingType, Map<Long, Long> grouping, ZonedDateTime from, ZonedDateTime to, Function<LikePosting, Long> classifier) {
            int offset = 0;
            int count = 1000;

            List<Statistics> statisticsList = statisticsRepository.findByRange(from, to);
            List<LikePosting> likePostingList = likePostingAnalyzeRepositoryCustom.findListByRange(postingType, offset, count, from, to, statisticsList);
            while(!likePostingList.isEmpty()) {
                Map<Long, Long> list = likePostingList.stream().collect(Collectors.groupingBy(classifier, Collectors.counting()));
                aggregate(grouping, list);

                if(likePostingList.size() == count) {
                    offset += count;
                    likePostingList = likePostingAnalyzeRepositoryCustom.findListByRange(postingType, offset, count, from, to, statisticsList);
                } else {
                    break;
                }
            }
        }

        private void aggregate(Map<Long, Long> store, Map<Long, Long> grouping) {
            for(Map.Entry<Long, Long> entry : grouping.entrySet()) {
                store.compute(entry.getKey(), (k, v) -> {
                    if(v == null) {
                        return entry.getValue();
                    } else {
                        return entry.getValue() + v;
                    }
                });
            }
        }

        private boolean isNotExistUser(LikePosting likePosting) {
            return likePosting.getRelation().getPosting() == null || likePosting.getRelation().getPosting().getOwner() == null;
        }

        private boolean isNotExistPosting(LikePosting likePosting) {
            return likePosting.getRelation().getPosting() == null;
        }


        private void likePhotoUserGrouping(Map<Long, Long> grouping, ZonedDateTime from, ZonedDateTime to) {
            likeGrouping(PostingType.photo, grouping, from, to, likePosting -> {
                //게시글 삭제나 사용자 탈퇴의 경우
                if(isNotExistPosting(likePosting)) return 0L;
                return likePosting.getRelation().getPosting().getOwner().getId();
            });
        }

        private void likePhotoGrouping(Map<Long, Long> grouping, ZonedDateTime from, ZonedDateTime to) {
            likeGrouping(PostingType.photo, grouping, from, to, likePosting -> {

                //게시글 삭제나 사용자 탈퇴의 경우
                if(isNotExistPosting(likePosting)) return 0L;
                return likePosting.getRelation().getPosting().getId();
            });
        }

        @SuppressWarnings("SameParameterValue")
        private void firstCommentGrouping(Class<? extends Posting> clazz, Map<Long, Long> firstCommentUserIds, ZonedDateTime from, ZonedDateTime to) {

            int offset = 0;
            int count = 1000;

            List<Posting> postingList = commentAnalyzeRepositoryCustom.findPostingListByCommentRange(clazz, offset, count, from, to);
            while(!postingList.isEmpty()) {
                List<Tuple> list = commentRepository.findFirstHashtags(postingList.stream().map(Posting::getId).distinct().collect(Collectors.toList()));
                //첫댓글 작성자 (사용자ID -> 첫댓글 갯수)
                Map<Long, Long> grouping = list.stream().map(tuple -> ((BigInteger)tuple.get(4)).longValue()).collect(Collectors.groupingBy(id -> id, Collectors.counting()));

                aggregate(firstCommentUserIds, grouping);
                if(postingList.size() == count) {
                    offset += count;
                    postingList = commentAnalyzeRepositoryCustom.findPostingListByCommentRange(clazz, offset, count, from, to);
                } else {
                    break;
                }
            }
        }

        @Getter
        @AllArgsConstructor
        class Param {
            private final int offset;
            private final int count;
            private final ZonedDateTime from;
            private final ZonedDateTime to;
        }

        private <T> void grouping(Map<Long, Long> store, ZonedDateTime from, ZonedDateTime to, Function<Param, List<T>> fn, Function<T, Long> classfier) {
            int offset = 0;
            int count = 1000;

            List<T> list = fn.apply(new Param(offset, count, from, to));
            while(!list.isEmpty()) {
                for(Map.Entry<Long, Long> entry : list.stream().collect(Collectors.groupingBy(classfier, Collectors.counting())).entrySet()) {
                    store.compute(entry.getKey(), (k , v) -> {
                        if(v == null) {
                            return entry.getValue();
                        } else {
                            return entry.getValue() + v;
                        }
                    });
                }

                if(list.size() == count) {
                    offset += count;
                    list = fn.apply(new Param(offset, count, from, to));
                } else {
                    break;
                }
            }
        }


        /**
         * 채택된 답변 grouping 결과
         * @param adoptedUserIds 결과
         * @param from 시작날짜
         * @param to 종료날짜
         */
        private void adoptedCommentGrouping(Map<Long, Long> adoptedUserIds, ZonedDateTime from, ZonedDateTime to) {
            grouping(adoptedUserIds, from, to, param -> {
                List<Statistics> statisticsList = statisticsRepository.findByRange(from, to);
                return adoptCommentAnalyzeRepositoryCustom.findListByRange(param.getOffset(), param.getCount(), param.getFrom(), param.getTo(), statisticsList);
            }, adoptComment -> adoptComment.getTarget().getComment().getOwner().getId());
        }

        /**
         * 게시글 작성자가 대댓글을 달았을 경우 댓글의 작성자 그룹핑
         * @param replyUserIds 결과
         * @param from 시작날짜
         * @param to 종료날짜
         */
        private void replyGrouping(Map<Long, Long> replyUserIds, ZonedDateTime from, ZonedDateTime to) {

            int offset = 0;
            int count = 1000;

            List<Comment> replyList = commentAnalyzeRepositoryCustom.findReplyListByPostingWriterAndCommentRange(offset, count, from, to);
            List<UserCommentRawData> rawDataList = new ArrayList<>();
            while(!replyList.isEmpty()) {
                rawDataList.addAll(replyList.stream().map(reply -> new UserCommentRawData(reply.getPosting().getId(), reply.getParent().getOwner().getId())).collect(Collectors.toList()));
                offset += count;
                replyList = commentAnalyzeRepositoryCustom.findReplyListByPostingWriterAndCommentRange(offset, count, from, to);
            }

            Map<Long, Long> grouping = rawDataList.stream().distinct().collect(Collectors.groupingBy(UserCommentRawData::getUserId, Collectors.counting()));
            aggregate(replyUserIds, grouping);

        }

        @SuppressWarnings("SameParameterValue")
        private void send(String exchange, String routingKey, Event event) {
            rabbitTemplate.convertAndSend(exchange, routingKey, event);
        }

        private void doRequestRankingEvent(final List<net.infobank.moyamo.models.UserRanking> rankings, final PostingType postingType) {
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization(){
                @Override
                public void afterCommit() {
                    //상위 10명만
                    log.info("commit!!");
                    rankings.stream().sorted(Comparator.comparing(net.infobank.moyamo.models.UserRanking::getScore).reversed()).limit(10).forEach(ranking -> {
                        Event event = Event.builder()
                                .action(EventAction.CREATE).owner(ranking.getUser().getId())
                                .postingType(net.infobank.moyamo.domain.PostingType.valueOf(postingType.name()))
                                .type(EventType.RANKING)
                                .build();
                        send("event", "#", event);
                    });
                }});
        }

        /**
         *
         * @param rankings 게시글랭킹 목록
         * @param postingType 게시글 타입
         */
        private void doRequestRankingEventByPosting(final List<net.infobank.moyamo.models.PostingRanking> rankings, PostingType postingType) {
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization(){
              @Override
              public void afterCommit(){
                  //상위 10명만
                  log.info("commit!!");
                  rankings.forEach(ranking -> {
                      Event event = Event.builder()
                              .action(EventAction.CREATE).owner(ranking.getPosting().getOwner().getId())
                              .postingType(net.infobank.moyamo.domain.PostingType.valueOf(postingType.name()))
                              .type(EventType.RANKING)
                              .build();
                      send("event", "#",event);
                  });
              }});
        }


        /**
         * 주간 우수회원 (질문, 식물클리닉)
         */
        private void doWorkWeeklyQuestionUserRanking(ZonedDateTime dt, ZonedDateTime from, ZonedDateTime to) {

            log.info("이름이뭐야? 주간 사용자 랭킹");
            Map<Long, Long> firstCommentUserIds = new HashMap<>();
            firstCommentGrouping(Question.class, firstCommentUserIds, from, to);

            //감사인사 받은 댓글 (사용자ID -> 감사인사 갯수)
            Map<Long, Long> replyUserIds = new HashMap<>();
            replyGrouping(replyUserIds, from, to);

            log.info("첫 댓글 사용자 점수 : {}", firstCommentUserIds);
            log.info("질문자의 감사인사(대댓글) 점수 : {}", replyUserIds);

            Set<Long> uniqueIds = new HashSet<>(firstCommentUserIds.keySet());
            uniqueIds.addAll(new HashSet<>(replyUserIds.keySet()));

            List<UserRanking> rankings = new ArrayList<>();
            for(Long userId : uniqueIds) {

                //첫댓글 가중치
                long score1 = firstCommentUserIds.getOrDefault(userId, 0L);

                //대댓글 가중치
                long score2 = replyUserIds.getOrDefault(userId, 0L);

                rankings.add(new UserRanking(userId, score1 + score2));
            }

            rankings.sort(Comparator.reverseOrder());

            List<net.infobank.moyamo.models.UserRanking> oldestRankings = userRankingRepository.findAllByRankingTypeAndDate(Ranking.RankingType.best_user_by_question, dt);
            userRankingRepository.deleteAll(oldestRankings);

            Map<Long, User> userMap = userRepository.findAllById(uniqueIds).stream().collect(Collectors.toMap(User::getId, user -> user));

            List<net.infobank.moyamo.models.UserRanking> newestRankings  = rankings.stream().filter(ranking -> userMap.containsKey(ranking.getUserId())).map(ranking -> {
                User user = userMap.get(ranking.getUserId());
                return net.infobank.moyamo.models.UserRanking.builder()
                        .user(user).rankingType(Ranking.RankingType.best_user_by_question)
                        .date(dt).score(ranking.getScore()).build();
            }).limit(MAX_RANKING).collect(Collectors.toList());

            newestRankings = userRankingRepository.saveAll(newestRankings);
            doRequestRankingEvent(newestRankings, PostingType.question);

            log.info("주간 우수 회원 (이름이 모야) 랭킹");
        }

        /**
         * 주간 인기포토 작가 랭킹
         */
        private void doWorkWeeklyPhotoUserRanking(ZonedDateTime dt, ZonedDateTime from, ZonedDateTime to) {

            log.info("기간내 포토 사용자 랭킹 ({} ~ {})", from, to);
            Map<Long, Long> photoUserIds = new HashMap<>();
            likePhotoUserGrouping(photoUserIds, from, to);

            List<UserRanking> rankings = new ArrayList<>();
            for(Map.Entry<Long, Long> entry : photoUserIds.entrySet()) {
                Long userId = entry.getKey();
                Long likeCount = entry.getValue();
                rankings.add(new UserRanking(userId, likeCount));
            }

            rankings.sort(Comparator.reverseOrder());
            afterPopularPhotoUser(dt, rankings);

            log.info("기간내 포토 사용자 랭킹 ({} ~ {}) 완료", from, to);
            //TODO 뱃지 발행은 없음?
        }

        /**
         * 주간 인기포토 랭킹
         */
        private void doWorkWeeklyPhotoRanking(ZonedDateTime dt, ZonedDateTime from, ZonedDateTime to) {

            log.info("기간내 포토 랭킹 ({} ~ {})", from, to);

            Map<Long, Long> photoIds = new HashMap<>();
            likePhotoGrouping(photoIds, from, to);

            List<PostingRanking> rankings = new ArrayList<>();
            for(Map.Entry<Long, Long> entry : photoIds.entrySet()) {
                Long postingId = entry.getKey();

                if(postingId == null || postingId.equals(0L)) continue;

                Long likeCount = entry.getValue();
                rankings.add(new PostingRanking(postingId, likeCount));
            }

            rankings.sort(Comparator.reverseOrder());
            afterPopularPhoto(dt, rankings);
            //TODO 뱃지 발행은 없음?
            log.info("기간내 포토 랭킹 완료 ({} ~ {})", from, to);
        }


        @SuppressWarnings("unused")
        private void doWorkRecentTopRanking() {
            Badges.BadgeHeavy badge = new Badges.BadgeHeavy();
            List<TopUsers.UserScore> scores = eventServerInterface.requestGetUserScores();
            long badgeId = Long.parseLong(badge.getKey());
            for(TopUsers.UserScore score : scores) {
                badgeService.addUserBadges(score.getId(), badgeId);
            }
        }


        private void doWorkWeeklyClinicUserRanking(ZonedDateTime dt, ZonedDateTime from, ZonedDateTime to) {
            Map<Long, Long> adoptedUserIds = new HashMap<>();
            adoptedCommentGrouping(adoptedUserIds, from, to);

            log.info("식물클리닉 주간 사용자 랭킹");
            log.info("채택된 댓글 작성자  : {}", adoptedUserIds);

            List<UserRanking> rankings = adoptedUserIds.entrySet().stream().map(entry -> new UserRanking(entry.getKey(), entry.getValue())).sorted(Comparator.reverseOrder()).collect(Collectors.toList());

            List<net.infobank.moyamo.models.UserRanking> oldestRankings = userRankingRepository.findAllByRankingTypeAndDate(Ranking.RankingType.best_user_by_clinic, dt);
            userRankingRepository.deleteAll(oldestRankings);

            Map<Long, User> userMap = userRepository.findAllById(rankings.stream().map(UserRanking::getUserId).collect(Collectors.toList())).stream().collect(Collectors.toMap(User::getId, user -> user));

            List<net.infobank.moyamo.models.UserRanking> newestRankings  = rankings.stream().filter(ranking -> userMap.containsKey(ranking.getUserId())).map(ranking -> {
                User user = userMap.get(ranking.getUserId());
                return net.infobank.moyamo.models.UserRanking.builder()
                        .user(user).rankingType(Ranking.RankingType.best_user_by_clinic)
                        .date(dt).score(ranking.getScore()).build();

            }).limit(MAX_RANKING).collect(Collectors.toList());

            newestRankings = userRankingRepository.saveAll(newestRankings);
            doRequestRankingEvent(newestRankings, PostingType.clinic);

            log.info("주간 우수 회원 (식물클리닉) 랭킹");
        }


        private PostingType dType2PostingType(String dType) {
            switch (dType) {
                case BoardDiscriminatorValues.MAGAZINE :
                    return PostingType.magazine;
                case BoardDiscriminatorValues.MAGAZINE_WAIT:
                    return PostingType.magazine_wait;
                case BoardDiscriminatorValues.CLINIC:
                    return PostingType.clinic;
                case BoardDiscriminatorValues.BOAST:
                    return PostingType.boast;
                case BoardDiscriminatorValues.FREE:
                    return PostingType.free;
                case BoardDiscriminatorValues.GUIDE:
                    return PostingType.guidebook;
                case BoardDiscriminatorValues.PHOTO:
                    return PostingType.photo;
                case BoardDiscriminatorValues.QUESTION:
                default:
                    log.warn("{} is not found dType (기본값으로 처리)", dType);
                    return PostingType.question;

            }
        }

        private void afterRecommentedPosting(ZonedDateTime dt, List<PostingRanking> recommentPostingList) {
            List<net.infobank.moyamo.models.PostingRanking> rankings = postingRankingRepository.findAllByRankingTypeAndDate(Ranking.RankingType.best_posting, dt);
            postingRankingRepository.deleteAll(rankings);

            rankings = recommentPostingList.stream()
                    .limit(MAX_RANKING)
                    .map(ranking ->  net.infobank.moyamo.models.PostingRanking
                            .builder().posting(postingRepository.getOne(ranking.getId())).date(dt).score(ranking.getScore()).rankingType(Ranking.RankingType.best_posting).build())
                    .collect(Collectors.toList());

            postingRankingRepository.saveAll(rankings);

            //TOP10 명에게만 발급
            List<net.infobank.moyamo.models.PostingRanking> top10 = rankings.stream().limit(10).collect(Collectors.toList());
            doRequestRankingEventByPosting(top10.stream().filter(postingRanking -> postingRanking.getPosting().getPostingType().equals(PostingType.free)).collect(Collectors.toList()), PostingType.free);
            doRequestRankingEventByPosting(top10.stream().filter(postingRanking -> postingRanking.getPosting().getPostingType().equals(PostingType.boast)).collect(Collectors.toList()), PostingType.boast);
            if(log.isDebugEnabled())
                log.debug("추천게시물 랭킹 : {}", rankings);
        }

        private void afterPopularPhoto(ZonedDateTime dt, List<PostingRanking> popularPhotoList) {
            Set<Long> uniqueIds = popularPhotoList.stream().map(PostingRanking::getId).collect(Collectors.toSet());
            List<net.infobank.moyamo.models.PostingRanking> oldestRankings = postingRankingRepository.findAllByRankingTypeAndDate(Ranking.RankingType.best_photo, dt);
            postingRankingRepository.deleteAll(oldestRankings);

            Map<Long, Posting> postingMap = postingRepository.findAllById(uniqueIds).stream().collect(Collectors.toMap(Posting::getId, Function.identity()));
            List<net.infobank.moyamo.models.PostingRanking> newestRankings  = popularPhotoList.stream().filter(ranking -> postingMap.containsKey(ranking.getId())).map(ranking -> {
                Posting posting = postingMap.get(ranking.getId());
                return net.infobank.moyamo.models.PostingRanking.builder()
                        .posting(posting).rankingType(Ranking.RankingType.best_photo)
                        .date(dt).score(ranking.getScore()).build();
            }).limit(MAX_RANKING).collect(Collectors.toList());
            postingRankingRepository.saveAll(newestRankings);

            if(log.isDebugEnabled())
                log.debug("인기포토 랭킹 : {}", popularPhotoList);
        }

        private void afterPopularPhotoUser (ZonedDateTime dt, List<UserRanking> userRankingList) {
            Set<Long> uniqueIds = userRankingList.stream().map(UserRanking::getUserId).collect(Collectors.toSet());
            List<net.infobank.moyamo.models.UserRanking> oldestRankings = userRankingRepository.findAllByRankingTypeAndDate(Ranking.RankingType.best_user_by_photo, dt);
            userRankingRepository.deleteAll(oldestRankings);

            Map<Long, User> userMap = userRepository.findAllById(uniqueIds).stream().collect(Collectors.toMap(User::getId, user -> user));
            List<net.infobank.moyamo.models.UserRanking> newestRankings  = userRankingList.stream().filter(ranking -> userMap.containsKey(ranking.getUserId())).map(ranking -> {
                User user = userMap.get(ranking.getUserId());
                return net.infobank.moyamo.models.UserRanking.builder()
                        .user(user).rankingType(Ranking.RankingType.best_user_by_photo)
                        .date(dt).score(ranking.getScore()).build();
            }).limit(MAX_RANKING).collect(Collectors.toList());
            userRankingRepository.saveAll(newestRankings);

            if(log.isDebugEnabled())
                log.debug("인기포토 사용자 랭킹 : {}", userRankingList);

        }



        /**
         * 추천게시물 랭킹
         *
         * 게시글 조회수 + 좋아요수 + 댓글수
         */
        private void doWorkRecommenedPosting(ZonedDateTime dt, ZonedDateTime from, ZonedDateTime to) {
            log.info("추천게시물 랭킹");

            //추천질문의 기간 내 댓글로 가중치를 준다.
            Map<Long, Long> grouping = new HashMap<>();


            commentGrouping(grouping, from, to);

            log.info("추천게시물 랭킹 1");
            Comparator<Map.Entry<Long, Long>> comparator = (o1, o2) -> {
                int compare = o2.getValue().compareTo(o1.getValue());
                return (compare == 0) ? o2.getKey().compareTo(o1.getKey()) : compare;
            };

            List<Map.Entry<Long, Long>> entryList = grouping.entrySet().stream()
            .sorted(comparator).collect(Collectors.toList());
            log.info("추천게시물 랭킹 2");


            Map<Long, Long> likeGrouping = new HashMap<>();
            likePostingGrouping(likeGrouping, from, to);

            log.info("추천게시물 랭킹 3");

            List<Map.Entry<Long, Long>> entryLikeList = likeGrouping.entrySet().stream()
            .sorted(comparator).collect(Collectors.toList());

            log.info("추천게시물 랭킹 4");

            Set<Long> uniqueIds = entryList.stream().map(Map.Entry::getKey).collect(Collectors.toSet());
            uniqueIds.addAll(entryLikeList.stream().map(Map.Entry::getKey).collect(Collectors.toSet()));

            log.info("추천게시물 랭킹 5");
            //기간 내 좋아요, 답글의 게시글 목록조회
            List<Tuple> postingList = postingAnalyzeRepository.findAllByIdAndDTypeInAndDateRangeNative(uniqueIds, Arrays.asList(BoardDiscriminatorValues.FREE, BoardDiscriminatorValues.BOAST), from, to);

            List<PostingRanking> recommentPostingList = new ArrayList<>();
            for(Tuple posting : postingList) {

                BigInteger postingId = posting.get(0, BigInteger.class);

                BigInteger ownerId = posting.get(1, BigInteger.class);

                String dType = posting.get(2, String.class);
                PostingType postingType = dType2PostingType(dType);

                Integer readCount = posting.get(3, Integer.class);


                //사용자 ID 제외
                if(IGNORE_USER_IDS.contains(ownerId.longValue())) {
                    continue;
                }

                //좋아요 점수
                long score1 = likeGrouping.getOrDefault(postingId.longValue(), 0L);

                //댓글 점수
                long score2 = grouping.getOrDefault(postingId.longValue(), 0L);

                // 자랑하기 / 자유게시판만
                if(PostingType.boast.equals(postingType) || PostingType.free.equals(postingType)) {
                    recommentPostingList.add(new PostingRanking(postingId.longValue(), score1 + score2 + readCount));
                }
            }

            log.info("추천게시물 랭킹 6");

            recommentPostingList.sort(Comparator.reverseOrder());

            log.info("추천게시물 랭킹 7");
            afterRecommentedPosting(dt, recommentPostingList);
            log.info("추천게시물 랭킹 8");
        }

        private void doWork(ZonedDateTime date) {

            //하루전
            ZonedDateTime dt = date.withZoneSameInstant(ASIA_SEOUL_ZONEID).withHour(0).withMinute(0).withSecond(0).withNano(0);

            ZonedDateTime to = dt.plusDays(1).minusSeconds(1);
            ZonedDateTime from = to.minusDays(6).withHour(0).withMinute(0).withSecond(0).withNano(0);
            //포토는 3일 기준으로 랭킹
            ZonedDateTime photoFrom = to.minusDays(2).withHour(0).withMinute(0).withSecond(0).withNano(0);
            log.info("랭킹 분석 시작 : {}, 분석날짜 : {} (from: {}, to: {})", date, dt, from, to);

            Optional<RankingLog> optionalRankingLog = rankingLogRepository.findByDate(dt);

            if(optionalRankingLog.isPresent()) {
                RankingLog rankingLog = optionalRankingLog.get();
                Optional<RankingLog> optionalBeforeRankingLog = rankingLogRepository.findBeforeByDate(rankingLog.getDate());
                ZonedDateTime before = optionalBeforeRankingLog.map(RankingLog::getDate).orElse(null);
                ZonedDateTime after = rankingLog.getDate();
                log.info("RankingJob worked date : {} (before : {}, after : {}), rankingLog : {}", dt, before, rankingLog.getDate(), rankingLog);

                rankingService.findRanking(before, after, Ranking.RankingType.best_posting);
                rankingService.findRanking(before, after, Ranking.RankingType.best_user_by_clinic);
                rankingService.findRanking(before, after, Ranking.RankingType.best_user_by_question);
                rankingService.findRanking(before, after, Ranking.RankingType.best_keyword);
            } else {
                doWorkQuestionTagRaking(dt, from, to);
                doWorkRecommenedPosting(dt, from, to);
                doWorkWeeklyQuestionUserRanking(dt, from, to);
                doWorkWeeklyClinicUserRanking(dt, from, to);
                doWorkWeeklyPhotoUserRanking(dt, photoFrom, to);
                doWorkWeeklyPhotoRanking(dt, photoFrom, to);

                Optional<RankingLog> beforeLastLog = rankingLogRepository.findBeforeByDate(dt);
                RankingLog afterLog = rankingLogRepository.save(new RankingLog(dt));
                log.info("before : {}, after : {}", beforeLastLog, afterLog);
            }
        }

        //한국 시간 기준 (주의) 날짜가 넘어가는 시점에 이전 날짜의 통계를 돌리기 위해 데이트 주기가 30분이 안돼야합니다.
        private ZonedDateTime getLocalDate() {
            return ZonedDateTime.now().minusDays(1).minusMinutes(30).withZoneSameInstant(ASIA_SEOUL_ZONEID).withHour(0).withMinute(0).withSecond(0).withNano(0);
        }

        //한국 시간 기준
        @SuppressWarnings("unused")
        private ZonedDateTime getWorkingDate() {
            ZonedDateTime localDate = getLocalDate();
            log.info("{} .isBefore({})", lastWorkingDate, localDate);
            if(lastWorkingDate.isBefore(localDate)) {
                return lastWorkingDate;
            } else {
                return localDate;
            }
        }

        @SuppressWarnings("unused")
        private void updateLastWorkingDate(ZonedDateTime date) {
            this.lastWorkingDate = date;
        }

        @Transactional(rollbackFor = {Throwable.class})
        @Scheduled(cron="${moyamo.jobs.ranking.cron:0 */30 * * * *}")
        public void worker() {
            log.info("RankingJob");

            ZonedDateTime localDate = getLocalDate();

            //equal 조회는 ZonedId 에 따라 계산돼 조회함 DB(2020-01-01 15:00:00 UTC) == localDate(2020-01-02 00:00:00 Asia/Seoul)
            Optional<RankingLog> optionalRankingLog = rankingLogRepository.findByDate(localDate);
            if(optionalRankingLog.isPresent()) {
                log.info("랭킹 업데이트 조회({}) : {}", localDate, optionalRankingLog);
                doWork(localDate);
            } else {
                Optional<RankingLog> beforeRankingLog = rankingLogRepository.findLastByDate(localDate);
                //localDate 이전 날짜 중 가장 최신 row 를 가져온다.

                ZonedDateTime workingDate = beforeRankingLog.map(dt -> dt.getDate().plusDays(1).withZoneSameInstant(ZoneId.of("Asia/Seoul"))).orElse(localDate);
                //마지막 통계가 있을 경우 +1D 의 통계분석을 시도함, 없을 경우 한 달 전 통계 분석부터 시작

                log.info("이전 랭킹 업데이트 날짜 조회({}) : {}", workingDate, beforeRankingLog);
                doWork(workingDate);
            }

            log.info("RankingJob End");
        }
    }

}
