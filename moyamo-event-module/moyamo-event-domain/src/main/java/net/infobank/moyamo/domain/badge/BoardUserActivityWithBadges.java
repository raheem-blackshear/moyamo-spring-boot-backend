package net.infobank.moyamo.domain.badge;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class BoardUserActivityWithBadges {
    private UserBadges userBadges;
    private BoardUserActivity activity;
}
