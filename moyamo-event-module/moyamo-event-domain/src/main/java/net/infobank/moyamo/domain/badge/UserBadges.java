package net.infobank.moyamo.domain.badge;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

/**
 * User 의 발급받은 뱃지 목록 관리
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserBadges implements Serializable {
    private Long id;
    private Set<String> badges;

    public void addBadge(NewBadge badge) {
        if(this.badges == null) {
            this.badges = new HashSet<>();
        }
        this.badges.addAll(badge.getBadges());
    }
}
