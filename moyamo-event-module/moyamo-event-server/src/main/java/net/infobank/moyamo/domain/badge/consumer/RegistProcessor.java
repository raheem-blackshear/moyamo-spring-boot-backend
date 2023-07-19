package net.infobank.moyamo.domain.badge.consumer;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.domain.badge.BoardUserActivity;
import net.infobank.moyamo.domain.badge.NewBadge;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.common.utils.Bytes;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.KTable;
import org.apache.kafka.streams.kstream.Materialized;
import org.apache.kafka.streams.state.KeyValueStore;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import java.util.function.BiFunction;

import static net.infobank.moyamo.domain.Stores.*;

@Slf4j
@Component
public class RegistProcessor {


    @Bean
    public BiFunction<KStream<Long, NewBadge>, KTable<Long, BoardUserActivity>, KStream<Long, BoardUserActivity>> questionRegister() {
        return (stream, table) -> (
                stream.groupByKey().aggregate(BoardUserActivity::new, (key, value, aggregate) -> {
                    aggregate.setOwner(key);
                    aggregate.add(value.getEvent());
                    if(log.isDebugEnabled())
                        log.debug("questionRegister {} : {}, {}", key, value, aggregate);
                    return aggregate;
                }, Materialized.<Long, BoardUserActivity, KeyValueStore<Bytes, byte[]>>as(USER_QUESTION_STORE)
                        .withKeySerde(Serdes.Long())
                        .withValueSerde(net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                        .toStream()
        );
    }

    @Bean
    public BiFunction<KStream<Long, NewBadge>, KTable<Long, BoardUserActivity>, KStream<Long, BoardUserActivity>> clinicRegister() {
        return (stream, table) -> (
                stream.groupByKey().aggregate(BoardUserActivity::new, (key, value, aggregate) -> {
                    aggregate.setOwner(key);
                    aggregate.add(value.getEvent());
                    if(log.isDebugEnabled())
                        log.debug("clinicRegister {} : {}, {}", key, value, aggregate);
                    return aggregate;
                }, Materialized.<Long, BoardUserActivity, KeyValueStore<Bytes, byte[]>>as(USER_CLINIC_STORE)
                        .withKeySerde(Serdes.Long())
                        .withValueSerde(net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                        .toStream()
        );
    }

    @Bean
    public BiFunction<KStream<Long, NewBadge>, KTable<Long, BoardUserActivity>, KStream<Long, BoardUserActivity>> freeRegister() {
        return (stream, table) -> (
                stream.groupByKey().aggregate(BoardUserActivity::new, (key, value, aggregate) -> {
                    aggregate.setOwner(key);
                    aggregate.add(value.getEvent());
                    if(log.isDebugEnabled())
                        log.debug("freeRegister {} : {}, {}", key, value, aggregate);
                    return aggregate;
                }, Materialized.<Long, BoardUserActivity, KeyValueStore<Bytes, byte[]>>as(USER_FREE_STORE)
                        .withKeySerde(Serdes.Long())
                        .withValueSerde(net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                        .toStream()
        );
    }

    @Bean
    public BiFunction<KStream<Long, NewBadge>, KTable<Long, BoardUserActivity>, KStream<Long, BoardUserActivity>> boastRegister() {
        return (stream, table) -> (
                stream.groupByKey().aggregate(BoardUserActivity::new, (key, value, aggregate) -> {
                    aggregate.setOwner(key);
                    aggregate.add(value.getEvent());
                    if(log.isDebugEnabled())
                        log.debug("boastRegister {} : {}, {}", key, value, aggregate);
                    return aggregate;
                }, Materialized.<Long, BoardUserActivity, KeyValueStore<Bytes, byte[]>>as(USER_BOAST_STORE)
                        .withKeySerde(Serdes.Long())
                        .withValueSerde(net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                        .toStream()
        );
    }

    @Bean
    public BiFunction<KStream<Long, NewBadge>, KTable<Long, BoardUserActivity>, KStream<Long, BoardUserActivity>> magazineRegister() {
        return (stream, table) -> (
                stream.groupByKey().aggregate(BoardUserActivity::new, (key, value, aggregate) -> {
                    aggregate.setOwner(key);
                    aggregate.add(value.getEvent());
                    if(log.isDebugEnabled())
                     log.debug("magazineRegister {} : {}, {}", key, value, aggregate);
                    return aggregate;
                }, Materialized.<Long, BoardUserActivity, KeyValueStore<Bytes, byte[]>>as(USER_MAGAZINE_STORE)
                        .withKeySerde(Serdes.Long())
                        .withValueSerde(net.infobank.moyamo.domain.badge.serialization.Serdes.BoardUserActivitySerde()))
                        .toStream()
        );
    }

}
