package net.infobank.moyamo.domain.badge.consumer;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.domain.EventType;
import net.infobank.moyamo.domain.badge.NewBadge;
import net.infobank.moyamo.domain.badge.UserBadges;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.common.utils.Bytes;
import org.apache.kafka.streams.KeyValue;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.Materialized;
import org.apache.kafka.streams.state.KeyValueStore;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.function.Function;
import java.util.function.Predicate;

import static net.infobank.moyamo.domain.Stores.USER_BADGE_STORE;

@Slf4j
@Component
public class BadgeProcessor {

    private final RabbitTemplate rabbitTemplate;

    public BadgeProcessor(RabbitTemplate rabbitTemplate) {
        rabbitTemplate.setMessageConverter(new Jackson2JsonMessageConverter());
        this.rabbitTemplate = rabbitTemplate;
    }

    private static final Predicate<NewBadge> fn = value -> !value.getBadges().isEmpty() || (value.getEvent() != null && EventType.INIT.equals(value.getEvent().getType()));

    /**
     * 신규 발급 뱃지를 rabbitMQ 로 전달
     */
    @Bean
    public Function<KStream<Long, NewBadge>, KStream<Long, NewBadge>> badgeToRabbitWorker() {

        return stream ->
            stream.filter((key, value) -> fn.test(value)).map((key, value) -> {
                if(log.isDebugEnabled()) {
                    log.debug("badge2rabbit : {}", value);
                }
                rabbitTemplate.convertAndSend("issue-badge", "", value);
                return KeyValue.pair(key, value);
            }) ;
    }

    /**
     * 신규 발급 뱃지를 개인별 store 에 저장
     * @return UserBadges table stream
     */
    @Bean
    public Function<KStream<Long, NewBadge>, KStream<Long, UserBadges>> userBadgeRegister() {
        return stream ->
            stream.filter((key, value) ->  fn.test(value))
            .groupByKey().aggregate(UserBadges::new, (key, value, aggregate) -> {
                if(value.getEvent() != null && EventType.INIT.equals(value.getEvent().getType())) {
                    //event type 이 init 이면 기존 초기화
                    aggregate.setBadges(Collections.emptySet());
                    log.debug("user badges init : {}", aggregate);
                } else {
                    aggregate.setId(key);
                    aggregate.addBadge(value);
                    log.debug("user badges resist : {}", aggregate);
                }

                return aggregate;
            }, Materialized.<Long, UserBadges, KeyValueStore<Bytes, byte[]>>as(USER_BADGE_STORE)
                .withKeySerde(Serdes.Long())
                .withValueSerde(net.infobank.moyamo.domain.badge.serialization.Serdes.UserBadgesSerde())).toStream();
    }
}
