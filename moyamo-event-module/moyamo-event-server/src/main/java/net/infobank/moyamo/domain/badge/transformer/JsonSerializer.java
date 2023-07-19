package net.infobank.moyamo.domain.badge.transformer;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.common.serialization.Serializer;

public class JsonSerializer<T> implements Serializer<T> {

    final Class<T> clazz;

    private static final ObjectMapper mapper = new ObjectMapper();
    static {
        mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
    }

    public JsonSerializer(Class<T> t) {
        this.clazz = t;
    }

    @Override
    public byte[] serialize(String topic, T data) {
        byte[] retVal = null;
        try {
            retVal = mapper.writeValueAsString(data).getBytes();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return retVal;
    }
}
