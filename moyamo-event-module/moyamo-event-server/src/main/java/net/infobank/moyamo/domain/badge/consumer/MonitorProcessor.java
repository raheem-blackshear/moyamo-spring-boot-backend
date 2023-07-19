package net.infobank.moyamo.domain.badge.consumer;

import net.infobank.moyamo.domain.badge.BoardUserActivity;
import net.infobank.moyamo.domain.badge.NewBadge;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.Printed;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import java.util.function.Consumer;

@Component
public class MonitorProcessor {

    @Bean
    public Consumer<KStream<Long, BoardUserActivity>> userActivityMonitor() {
        return events -> events.print(Printed.<Long, BoardUserActivity>toSysOut().withLabel("MONOTOR"));
    }

    @Bean
    public Consumer<KStream<Long, NewBadge>> newBadgeMonitor() {
        return stream ->
                stream.filter((key, value) -> !value.getBadges().isEmpty()).print(Printed.<Long, NewBadge>toSysOut().withLabel("NEW-BADGE"));
    }


}
