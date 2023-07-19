package net.infobank.moyamo.domain.badge.issuer;

import net.infobank.moyamo.domain.badge.Badge;
import net.infobank.moyamo.domain.badge.Badges;
import net.infobank.moyamo.domain.badge.Issuer;

import java.util.List;

public class BoastWithFreeIssuer implements Issuer {

    @Override
    public List<Badge> getBadges() {
        return Badges.BoastWithClinic.getBadges();
    }
}
