package net.infobank.moyamo.domain.badge.consumer;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.domain.Event;
import net.infobank.moyamo.domain.badge.*;
import net.infobank.moyamo.domain.badge.issuer.*;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KeyValue;
import org.apache.kafka.streams.kstream.Joined;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.KTable;
import org.apache.kafka.streams.kstream.ValueJoiner;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.function.BiFunction;
import java.util.function.Function;
import java.util.stream.Collectors;

@Slf4j
@Component
public class BoardProcessor {


    @Bean
    public Function<KStream<Long, Event>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, UserBadges>, KStream<Long, NewBadge>>>> questionBadgeWorker() {
        Issuer issuer = new QuestionBadgeIssuer();
        return events-> (
                stores -> (
                    badgeStore -> events
                        .leftJoin(badgeStore, (value1, value2) -> {
                            if(value2 != null && !value2.getBadges().isEmpty())
                                value1.setBadges(value2.getBadges());
                            return value1;
                        })
                        .leftJoin(stores, (event, activity) -> {
                            if(activity == null) {
                                activity = new BoardUserActivity();
                            }
                            activity.add(event);
                            return new NewBadge(event.getOwner(), event, issuer.find(activity, event.getBadges()).stream().map(Badge::getKey).collect(Collectors.toSet()));
                        })
                )
            );

    }

    @Bean
    public Function<KStream<Long, Event>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, UserBadges>, KStream<Long, NewBadge>>>>  clinicBadgeWorker() {
        ClinicBadgeIssuer issuer = new ClinicBadgeIssuer();
        return events-> (
            stores -> (
                badgeStore -> events
                        .leftJoin(badgeStore, (value1, value2) -> {
                            if(value2 != null && !value2.getBadges().isEmpty())
                                value1.setBadges(value2.getBadges());
                            return value1;
                        })
                        .leftJoin(stores, (event, activity) -> {
                            if(activity == null) {
                                activity = new BoardUserActivity();
                            }
                            activity.add(event);
                            return new NewBadge(event.getOwner(), event, issuer.find(activity, event.getBadges()).stream().map(Badge::getKey).collect(Collectors.toSet()));
                        })
            )
        );
    }

    private static final Set<String> EMPTY_BADGES = Collections.unmodifiableSet(new HashSet<>());
    @Bean
    public Function<KStream<Long, Event>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, UserBadges>, KStream<Long, NewBadge>>>> boastBadgeWorker() {
        return events-> (
                stores -> (
                        badgeStore -> events
                                .leftJoin(badgeStore, (value1, value2) -> {
                                    if(value2 != null && !value2.getBadges().isEmpty())
                                        value1.setBadges(value2.getBadges());
                                    return value1;
                                })
                                .leftJoin(stores, (event, activity) -> {
                                    if(activity == null) {
                                        activity = new BoardUserActivity();
                                    }
                                    activity.add(event);
                                    return new NewBadge(event.getOwner(), event, EMPTY_BADGES);
                                })
                )
        );
    }

    @Bean
    public Function<KStream<Long, Event>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, UserBadges>, KStream<Long, NewBadge>>>> freeBadgeWorker() {
        return events-> (
                stores -> (
                    badgeStore -> events
                        .leftJoin(badgeStore, (value1, value2) -> {
                            if(value2 != null && !value2.getBadges().isEmpty())
                                value1.setBadges(value2.getBadges());
                            return value1;
                        })
                        .leftJoin(stores, (event, activity) -> {
                            if(activity == null) {
                                activity = new BoardUserActivity();
                            }
                            activity.add(event);
                            return new NewBadge(event.getOwner(), event, EMPTY_BADGES);
                        })
                )
        );
    }

    @Bean
    public Function<KStream<Long, Event>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, UserBadges>, KStream<Long, NewBadge>>>> magazineBadgeWorker() {

        Issuer issuer = new MagazineBadgeIssuer();
        return events-> (
            stores -> (
                badgeStore -> events
                    .leftJoin(badgeStore, (value1, value2) -> {
                        if(value2 != null && !value2.getBadges().isEmpty())
                            value1.setBadges(value2.getBadges());
                        return value1;
                    })
                    .leftJoin(stores, (event, activity) -> {
                        if(activity == null) {
                            activity = new BoardUserActivity();
                        }
                        activity.add(event);
                        return new NewBadge(event.getOwner(), event,  issuer.find(activity, event.getBadges()).stream().map(Badge::getKey).collect(Collectors.toSet()));
                    })
            )
        );
    }

    @SuppressWarnings("java:S4276")
    private static final Function<Integer, Integer> numFn = num -> (num == null) ? 0 : num;

    @SuppressWarnings("java:S4276")
    private static final BiFunction<BoardUserActivity, BoardUserActivity, BoardUserActivity> sumActivity =  (value1, value2) -> {

        BoardUserActivity activity;

        if(value1 == null && value2 == null) {
            activity  = new BoardUserActivity();
            return activity;
        }

        if(value1 != null && value2 == null)
            return value1;

        if(value1 == null)
            return value2;

        activity = new BoardUserActivity();
        activity.setOwner(value1.getOwner());
        activity.setCommentCount(numFn.apply(value1.getCommentCount() + numFn.apply(value2.getCommentCount())));
        activity.setAdoptedCommentCount(numFn.apply(value1.getAdoptedCommentCount() + numFn.apply(value2.getAdoptedCommentCount())));
        activity.setFirstCommentCount(numFn.apply(value1.getFirstCommentCount() + numFn.apply(value2.getFirstCommentCount())));
        activity.setSmileCommentCount(numFn.apply(value1.getSmileCommentCount() + numFn.apply(value2.getSmileCommentCount())));
        activity.setThanksCommentCount(numFn.apply(value1.getThanksCommentCount() + numFn.apply(value2.getThanksCommentCount())));
        activity.setLikeCount(numFn.apply(value1.getLikeCount() + numFn.apply(value2.getLikeCount())));
        activity.setPostingCount(numFn.apply(value1.getPostingCount() + numFn.apply(value2.getPostingCount())));
        activity.setRankerCount(numFn.apply(value1.getRankerCount() + numFn.apply(value2.getRankerCount())));
        Set<String> keys = new HashSet<>();
        keys.addAll(value2.getCumulativeValues().keySet());
        keys.addAll(value1.getCumulativeValues().keySet());

        Map<String, Integer> map = new HashMap<>();
        keys.forEach(key -> map.put(key,
                value1.getCumulativeValues().getOrDefault(key, 0)
                + value2.getCumulativeValues().getOrDefault(key, 0)
        ));
        activity.setCumulativeValues(map);
        return activity;

    };


    ValueJoiner<BoardUserActivity, BoardUserActivity, BoardUserActivity> valueJoiner = (value1, value2) -> {
        if(log.isDebugEnabled()) {
            log.debug("valueJoiner {}, {}", value1, value2);
        }
        return sumActivity.apply(value1, value2);
    };

    ValueJoiner<BoardUserActivity, UserBadges, BoardUserActivityWithBadges> valueJoiner2 = (value1, value2) -> {
        if(log.isDebugEnabled()) {
            log.debug("valueJoiner2 {}, {}", value1, value2);
        }
        return new BoardUserActivityWithBadges(value2, value1);
    };

    ValueJoiner<NewBadge, BoardUserActivity, BoardUserActivity> valueJoinerRight = (value1, value2) -> {
        if(log.isDebugEnabled()) {
            log.debug("valueJoinerRight {}, {}", value1, value2);
        }
        if(value2 == null)
            return new BoardUserActivity();
        return value2;
    };

    @Bean
    public Function<KStream<Long, NewBadge>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, UserBadges>, KStream<Long, NewBadge>>>>> boastWithFreeStoreJoinWorker() {
        Issuer issuer = new BoastWithFreeIssuer();
        return events -> (
            boastStore -> (
                freeStore -> (
                    badgeStore -> events
                        .leftJoin(boastStore, valueJoinerRight, Joined.with(Serdes.Long(), net.infobank.moyamo.domain.badge.serialization.Serdes.NewBadgeSerde(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                        .leftJoin(freeStore, valueJoiner, Joined.with(Serdes.Long(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                        .leftJoin(badgeStore, valueJoiner2, Joined.with(Serdes.Long(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde(), net.infobank.moyamo.domain.badge.serialization.Serdes.UserBadgesSerde()))
                        .map((key, value) -> {
                            UserBadges userBadges = value.getUserBadges();
                            Set<String> contained = userBadges != null ? userBadges.getBadges() : Collections.emptySet();
                            NewBadge badge = new NewBadge(key, null, issuer.find(value.getActivity(), contained).stream().map(Badge::getKey).collect(Collectors.toSet()));
                            return KeyValue.pair(key, badge);
                        })
                )
            )
        );
    }


    @Bean
    public Function<KStream<Long, NewBadge>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, BoardUserActivity>, Function<KTable<Long, UserBadges>, KStream<Long, NewBadge>>>>>>>> totalStoreJoinWorker() {
        Issuer issuer = new TotalBadgeIssuer();
        return events -> (
            questionStore -> (
                clinicStore -> (
                    boastStore -> (
                        freeStore -> (
                            magazineStore -> (
                                badgeStore ->
                                    //TOP200 랭킹 제거
                                    events
                                            .leftJoin(questionStore, valueJoinerRight, Joined.with(Serdes.Long(), net.infobank.moyamo.domain.badge.serialization.Serdes.NewBadgeSerde(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                                            .leftJoin(clinicStore, valueJoiner, Joined.with(Serdes.Long(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                                            .leftJoin(boastStore, valueJoiner, Joined.with(Serdes.Long(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                                            .leftJoin(freeStore, valueJoiner, Joined.with(Serdes.Long(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                                            .leftJoin(magazineStore, valueJoiner, Joined.with(Serdes.Long(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                                            .leftJoin(badgeStore, valueJoiner2, Joined.with(Serdes.Long(), net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde(), net.infobank.moyamo.domain.badge.serialization.Serdes.UserBadgesSerde()))
                                            .map((key, value) -> {
                                                UserBadges userBadges = value.getUserBadges();
                                                Set<String> contained = userBadges != null ? userBadges.getBadges() : Collections.emptySet();
                                                NewBadge badge = new NewBadge(key, null, issuer.find(value.getActivity(), contained).stream().map(Badge::getKey).collect(Collectors.toSet()));
                                                return KeyValue.pair(key, badge);
                                            })

                            )
                        )
                    )
                )
            )
        );
    }

}
