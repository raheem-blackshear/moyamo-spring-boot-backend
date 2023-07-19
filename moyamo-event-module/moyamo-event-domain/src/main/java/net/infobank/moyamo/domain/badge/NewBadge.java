package net.infobank.moyamo.domain.badge;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import net.infobank.moyamo.domain.Event;

import java.io.Serializable;
import java.util.Set;

@ToString
@Data
@NoArgsConstructor
@AllArgsConstructor
public class NewBadge implements Serializable {

    private static final long serialVersionUID = -1L;

    private Long owner;

    private Event event;

    private Set<String> badges;
}
