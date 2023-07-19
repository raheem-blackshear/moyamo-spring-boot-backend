package net.infobank.moyamo.domain.badge;

public interface Badge {
    boolean issue(UserActivity activity);
    String getName();
    String getKey();
}
