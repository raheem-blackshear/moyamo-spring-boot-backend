package net.infobank.moyamo.models;

import java.time.ZonedDateTime;

public interface IActivity {
    Long getId() ;
    ZonedDateTime getCreatedAt();
}
