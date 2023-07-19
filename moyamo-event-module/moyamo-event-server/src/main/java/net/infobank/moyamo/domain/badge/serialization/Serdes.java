package net.infobank.moyamo.domain.badge.serialization;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import net.infobank.moyamo.domain.Event;
import net.infobank.moyamo.domain.EventGroup;
import net.infobank.moyamo.domain.badge.*;
import net.infobank.moyamo.domain.badge.transformer.JsonDeserializer;
import net.infobank.moyamo.domain.badge.transformer.JsonSerializer;
import org.apache.kafka.common.serialization.Deserializer;
import org.apache.kafka.common.serialization.Serde;
import org.apache.kafka.common.serialization.Serializer;

import java.util.List;
import java.util.Map;

import static com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES;

@SuppressWarnings({"java:S100", "unused"})
public class Serdes {

    private Serdes() throws IllegalAccessException {
        throw new IllegalAccessException("Serdes is static");
    }

    public static EventSerde EventSerde() {
        return new EventSerde();
    }

    public static TopUsersSerde TopUsersSerde() {
        return new TopUsersSerde();
    }

    public static UserBadgesSerde UserBadgesSerde() { return new UserBadgesSerde(); }

    public static QuestionUserActivitySerde BoardUserActivitySerde() {
        return new QuestionUserActivitySerde();
    }

    public static BoardUserActivityWithBadgesSerde BoardUserActivityWithBadgesSerde() {
        return new BoardUserActivityWithBadgesSerde();
    }

    public static EventGroupSerde EventGroupSerde() {return new EventGroupSerde();}

    public static NewBadgeSerde NewBadgeSerde() {return new NewBadgeSerde();}

    @Data
    public static class EventSerde implements Serde<Event> {


        @Override
        public Serializer<Event> serializer() {
            return new JsonSerializer<>(Event.class);
        }
        @Override
        public Deserializer<Event> deserializer() {
            return new JsonDeserializer<>(Event.class);
        }
    }

    @Data
    public static class EventGroupSerde implements Serde<EventGroup> {

        @Override
        public Serializer<EventGroup> serializer() {
            return new JsonSerializer<>(EventGroup.class);
        }

        @Override
        public Deserializer<EventGroup> deserializer() {
            return new JsonDeserializer<>(EventGroup.class);
        }
    }


    @Data
    public static class NewBadgeSerde implements Serde<NewBadge> {

        @Override
        public Serializer<NewBadge> serializer() {
            return new JsonSerializer<>(NewBadge.class);
        }

        @Override
        public Deserializer<NewBadge> deserializer() {
            return new JsonDeserializer<>(NewBadge.class);
        }

    }

    @Data
    public static class UserBadgesSerde implements Serde<UserBadges> {

        @Override
        public Serializer<UserBadges> serializer() {
            return new JsonSerializer<>(UserBadges.class);
        }

        @Override
        public Deserializer<UserBadges> deserializer() {
            return new JsonDeserializer<>(UserBadges.class);
        }

    }

    @Data
    public static class TopUsersSerde implements Serde<TopUsers> {

        private static final ObjectMapper mapper = new ObjectMapper();

        private static final TypeReference<List<TopUsers.UserScore>> reference = new TypeReference<List<TopUsers.UserScore>>() {};
        static {
            mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
            mapper.configure(FAIL_ON_UNKNOWN_PROPERTIES, false);
        }



        @Override
        public Serializer<TopUsers> serializer() {

            return new Serializer<TopUsers>() {
                @Override
                public void configure(final Map<String, ?> map, final boolean b) {
                    //
                }

                @Override
                public byte[] serialize(final String s, final TopUsers topFiveSongs) {
                   byte[] retVal = null;
                    try {
                        retVal = mapper.writeValueAsString(topFiveSongs.iterator()).getBytes();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    return retVal;
                }
            };
        }

        @Override
        public Deserializer<TopUsers> deserializer() {
            return (s, bytes) -> {
                if (bytes == null || bytes.length == 0) {
                    return null;
                }

                TopUsers object = new TopUsers();
                try {
                    List<TopUsers.UserScore> list = mapper.readValue(bytes, reference);
                    list.forEach(object::add);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return object;
            };
        }
    }


    @Data
    public static class QuestionUserActivitySerde implements Serde<BoardUserActivity> {

        @Override
        public Serializer<BoardUserActivity> serializer() {
            return new JsonSerializer<>(BoardUserActivity.class);
        }

        @Override
        public Deserializer<BoardUserActivity> deserializer() {
            return new JsonDeserializer<>(BoardUserActivity.class);
        }

    }

    @Data
    public static class BoardUserActivityWithBadgesSerde implements Serde<BoardUserActivityWithBadges> {

        @Override
        public Serializer<BoardUserActivityWithBadges> serializer() {
            return new JsonSerializer<>(BoardUserActivityWithBadges.class);
        }

        @Override
        public Deserializer<BoardUserActivityWithBadges> deserializer() {
            return new JsonDeserializer<>(BoardUserActivityWithBadges.class);
        }

    }




}
