package net.infobank.moyamo.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Event implements Serializable {

    private static final long serialVersionUID = -1L;

//    @NonNull
    private PostingType postingType;

//    @NonNull
    private EventType type;

//    @NonNull
    private EventAction action;

//    @NonNull
    private Long owner;

    private String content;

    private Set<String> badges;

    /**
     * UTC timestamp
     */
    private Long timestamp;

    //누적 카운트
    private Integer cumulative;

}
