package net.infobank.moyamo.service;

import lombok.RequiredArgsConstructor;
import net.infobank.moyamo.models.Badge;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.models.UserBadge;
import net.infobank.moyamo.repository.UserBadgeRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Objects;

@Service
@Transactional
@RequiredArgsConstructor
public class UserBadgeService {

    private final UserBadgeRepository userBadgeRepository;

    public boolean isPresentUserBadge(User currentUser, Badge badge){
        UserBadge userBadge = userBadgeRepository.findUserBadge(currentUser, badge).orElse(null);
        return !Objects.isNull(userBadge);
    }

}
