package net.infobank.moyamo.domain.badge.transformer;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;
import net.infobank.moyamo.domain.EventGroup;
import org.apache.kafka.common.serialization.Deserializer;

import static com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES;

public class EventGroupDeserializer implements Deserializer<EventGroup> {

    private static final ObjectMapper mapper = new ObjectMapper();
    static {
        mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
        mapper.configure(FAIL_ON_UNKNOWN_PROPERTIES, false);
    }

    @Override
    public EventGroup deserialize(String topic, byte[] data) {
        EventGroup object = null;
        try {
            object = mapper.readValue(data, EventGroup.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return object;
    }
}
