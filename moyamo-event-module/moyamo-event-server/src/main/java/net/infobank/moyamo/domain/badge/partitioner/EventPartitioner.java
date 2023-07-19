package net.infobank.moyamo.domain.badge.partitioner;

import net.infobank.moyamo.domain.Event;
import org.apache.kafka.streams.processor.StreamPartitioner;


public class EventPartitioner implements StreamPartitioner<Long, Event> {

    @Override
    public Integer partition(String topic, Long key, Event value, int numPartitions) {
        return String.valueOf(value.getOwner()).hashCode() % numPartitions;
    }
}
