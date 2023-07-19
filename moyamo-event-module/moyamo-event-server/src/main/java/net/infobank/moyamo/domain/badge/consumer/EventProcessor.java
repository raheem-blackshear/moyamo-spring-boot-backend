package net.infobank.moyamo.domain.badge.consumer;

import net.infobank.moyamo.domain.Event;
import net.infobank.moyamo.domain.PostingType;
import net.infobank.moyamo.domain.badge.partitioner.EventPartitioner;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KeyValue;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.Predicate;
import org.apache.kafka.streams.kstream.Repartitioned;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Flux;

import java.util.function.BiPredicate;
import java.util.function.Function;

@Component
public class EventProcessor {

    private static final EventPartitioner eventPartitioner = new EventPartitioner();

    private static final BiPredicate<Event, PostingType> fn = (event, postingType) -> event != null && event.getPostingType() != null && event.getPostingType().equals(postingType);
    private static final Predicate<Long, Event> isQuestion = (k, v) -> fn.test(v, PostingType.question);
    private static final Predicate<Long, Event> isClinic =  (k, v) ->  fn.test(v, PostingType.clinic);
    private static final Predicate<Long, Event> isBoast =  (k, v) ->  fn.test(v, PostingType.boast);
    private static final Predicate<Long, Event> isFree =  (k, v) -> fn.test(v, PostingType.free);
    private static final Predicate<Long, Event> isMagazine =  (k, v) -> fn.test(v, PostingType.magazine);

    /**
     * 모야모 이벤트를 각각의 게시글 branch 로 전달
     * @return KStream<Long, Event>[]
     */
    @SuppressWarnings("unchecked")
    @Bean
    public Function<KStream<String, Event>, KStream<Long, Event>[]> eventWorker() {
        return events -> (
                events.map((key, value) -> KeyValue.pair(value.getOwner(), value))
                .repartition(Repartitioned.streamPartitioner(eventPartitioner)
                        .withKeySerde(Serdes.Long())
                        .withValueSerde(net.infobank.moyamo.domain.badge.serialization.Serdes.EventSerde()))
                .branch(isQuestion, isClinic, isBoast, isFree, isMagazine)
        );
    }

    /**
     * rabbitmq 메시지를 kafka 에 전달하도록 설정
     * @return event
     */
    @Bean
    public Function<Flux<Event>, Flux<Event>> rabbit2Kafka() {
        return flux -> flux;
    }
}
