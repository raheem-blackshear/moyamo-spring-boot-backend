package net.infobank.moyamo.models;

import lombok.NonNull;
import net.infobank.moyamo.enumeration.PostingType;

import java.io.Serializable;
import java.time.ZonedDateTime;

public interface IUserPostingActivity extends Serializable {
    Long getId();

    @NonNull
    UserPostingRelation getRelation();

    ZonedDateTime getCreatedAt();

    @NonNull
    PostingType getPostingType();
}
