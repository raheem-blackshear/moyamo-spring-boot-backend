package net.infobank.moyamo.domain.badge.transformer;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.common.serialization.Deserializer;

import static com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES;

public class JsonDeserializer<T> implements Deserializer<T> {

    private Class<T> clazz;

    private static final ObjectMapper mapper = new ObjectMapper();
    static {
        mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
        mapper.configure(FAIL_ON_UNKNOWN_PROPERTIES, false);
    }

    public JsonDeserializer(Class<T> clazz) {
        this.clazz = clazz;
    }

    @Override
    public T deserialize(String topic, byte[] data) {
        T object = null;
        try {
            object = mapper.readValue(data, clazz);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return object;
    }
}
