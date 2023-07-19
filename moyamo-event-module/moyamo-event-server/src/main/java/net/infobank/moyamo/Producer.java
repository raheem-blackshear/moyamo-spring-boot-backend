package net.infobank.moyamo;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.domain.Event;
import net.infobank.moyamo.domain.EventAction;
import net.infobank.moyamo.domain.EventType;
import net.infobank.moyamo.domain.PostingType;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.serialization.StringSerializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.DefaultKafkaProducerFactory;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Component;

import java.util.*;

@Slf4j
@Component
public class Producer {

    @Value("${producer.enable:true}")
    private boolean enable;

    private static boolean state = true;

    private static final List<String> messages = Arrays.asList(
            "감사합니다.",
            "^^",
            "좋아요",
            "오예",
            "호호호"
    );

    //@PostConstruct
    public void run() {
        log.info("Producer");
        log.info("Producer state : {}", enable);
        if(!enable) {
            log.info("Producer disabled");
            return;
        }

        Thread thread = new Thread() {
            @Override
            public void run() {


                Map<String, Object> props = new HashMap<>();
                props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
                props.put(ProducerConfig.RETRIES_CONFIG, 0);
                props.put(ProducerConfig.BATCH_SIZE_CONFIG, 16384);
                props.put(ProducerConfig.LINGER_MS_CONFIG, 1);
                props.put(ProducerConfig.BUFFER_MEMORY_CONFIG, 33554432);
                props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
                props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, "net.infobank.moyamo.domain.badge.transformer.EventSerializer");

                DefaultKafkaProducerFactory<String, Event> pf = new DefaultKafkaProducerFactory<>(props);
                KafkaTemplate<String, Event> template = new KafkaTemplate<>(pf, true);
                template.setDefaultTopic("moyamo-event-1");


                final Random random = new Random(System.currentTimeMillis());
                while (state) {

                    final Event event = Event.builder().owner(1L)
                            .type(EventType.COMMENT).postingType(PostingType.question)
                            .action(EventAction.CREATE).content(messages.get(random.nextInt(messages.size()))).build();

                    log.info("send : {}", event);
                    template.sendDefault("uk", event);
                    try {
                        Thread.sleep(1000L);
                    } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                        e.printStackTrace();
                    }
                }


                super.run();
            }
        };

        thread.start();
    }
}
