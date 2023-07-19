package net.infobank.moyamo.domain;

import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EventGroup {

    @NonNull
    private List<Event> events;

    public void add(Event event) {
        if( this.events == null) {
            this.events = new ArrayList<>();
        }
        this.events.add(event);
    }

}
