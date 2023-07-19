package net.infobank.moyamo.domain.badge.issuer;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import net.infobank.moyamo.domain.badge.AbstractBadge;
import net.infobank.moyamo.domain.badge.Badge;
import net.infobank.moyamo.domain.badge.Issuer;
import net.infobank.moyamo.domain.badge.UserActivity;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class CustomBadgeIssuer implements Issuer {

    private final String prefix;

    @SuppressWarnings("unused")
    public CustomBadgeIssuer() {
        this.prefix = "뱃지:";
    }

    @SuppressWarnings("unused")
    public CustomBadgeIssuer(String prefix) {
        this.prefix = prefix;
    }

    @EqualsAndHashCode(callSuper = true)
    @Data
    @AllArgsConstructor
    public static class CustomBadge extends AbstractBadge implements Badge {

        @Accessors(chain = true)
        private String key;

        @Accessors(chain = true)
        private String name;

        @Accessors(chain = true)
        private int num;

        @Override
        public boolean issue(UserActivity activity) {
            return activity.getCommentCount() % num >= 0 || activity.getPostingCount() % num >= 0;
        }
    }

    @Override
    public List<Badge> getBadges() {
        return Collections.singletonList(new CustomBadge(prefix, prefix, 100));
    }

    @SuppressWarnings("unused")
    public Set<Badge> find(UserActivity activity, Set<String> issued, int num) {
        return getBadges().stream()
                .map(badge -> {
                    String suffix = String.format("%d", (activity.getPostingCount() + activity.getCommentCount()));
                    return new CustomBadge(badge.getKey() + suffix, badge.getName() + suffix,num);
                })
                //발급되지 않은 뱃지 필터링
                .filter(badge -> issued == null || !issued.contains(badge.getName()))
                //
                .filter(badge -> badge.issue(activity))

                .collect(Collectors.toSet());
    }

}
