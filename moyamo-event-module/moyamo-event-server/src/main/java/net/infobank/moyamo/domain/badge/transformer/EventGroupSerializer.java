package net.infobank.moyamo.domain.badge.transformer;

import com.fasterxml.jackson.databind.ObjectMapper;
import net.infobank.moyamo.domain.EventGroup;
import org.apache.kafka.common.serialization.Serializer;

public class EventGroupSerializer implements Serializer<EventGroup> {

    private static final ObjectMapper mapper = new ObjectMapper();

    @Override
    public byte[] serialize(String topic, EventGroup data) {
        byte[] retVal = null;
        try {
            retVal = mapper.writeValueAsString(data).getBytes();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return retVal;
    }
}
