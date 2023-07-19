package net.infobank.moyamo.serializer;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.Posting;
import org.hibernate.search.bridge.StringBridge;

@Slf4j
public class PostingBridge implements StringBridge {

    public String objectToString(Object object) {
        Posting value = (Posting) object;
        if (value == null)
            return null;

        return String.valueOf(value.getId());
    }
}
