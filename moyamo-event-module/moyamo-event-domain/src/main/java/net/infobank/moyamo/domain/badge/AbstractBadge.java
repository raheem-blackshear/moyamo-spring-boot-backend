package net.infobank.moyamo.domain.badge;

import lombok.ToString;

@ToString
public abstract class AbstractBadge implements Badge {

    @ToString.Include
    public abstract String getName();

    @ToString.Include
    public abstract String getKey();
}
