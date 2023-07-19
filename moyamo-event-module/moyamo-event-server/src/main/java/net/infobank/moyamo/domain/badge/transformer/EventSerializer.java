package net.infobank.moyamo.domain.badge.transformer;

import com.fasterxml.jackson.databind.ObjectMapper;
import net.infobank.moyamo.domain.Event;
import org.apache.kafka.common.serialization.Serializer;

public class EventSerializer implements Serializer<Event> {

    private static final ObjectMapper mapper = new ObjectMapper();

    @Override
    public byte[] serialize(String topic, Event data) {
        byte[] retVal = null;
        try {
            retVal = mapper.writeValueAsString(data).getBytes();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return retVal;
    }
}
