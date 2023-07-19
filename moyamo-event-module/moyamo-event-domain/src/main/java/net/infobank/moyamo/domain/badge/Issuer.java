package net.infobank.moyamo.domain.badge;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@SuppressWarnings("unused")
public interface Issuer {

    List<Badge> getBadges();

    default List<Badge> find(UserActivity activity) {
        return getBadges().stream().filter(badge -> badge.issue(activity)).collect(Collectors.toList());
    }

    default  Set<Badge> find(UserActivity activity, Set<String> issued) {
        return getBadges().stream()
                //발급되지 않은 뱃지 필터링
                .filter(badge -> issued == null || !issued.contains(badge.getKey()))
                .filter(badge -> badge.issue(activity)).collect(Collectors.toSet());
    }
}
