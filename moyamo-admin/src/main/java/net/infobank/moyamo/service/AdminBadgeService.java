package net.infobank.moyamo.service;

import net.infobank.moyamo.models.AdminBadge;
import net.infobank.moyamo.models.Badge;
import net.infobank.moyamo.repository.AdminBadgeRepository;
import net.infobank.moyamo.util.AuthUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
public class AdminBadgeService {

    @Autowired
    AdminBadgeRepository adminBadgeRepository;

    @Autowired
    BadgeService badgeService;

    @Autowired
    UserService userService;

    @Autowired
    AuthUtils authUtils;

    @Autowired
    EntityManager em;

    //조회
    public Map<String, Object> getAllAdminBadges(int draw, String query, Pageable pageable) {
        Map<String, Object> map = new HashMap<>();
        List<AdminBadge> badgeList = adminBadgeRepository.findBySearch(query, pageable);
        List<AdminBadge> badgeAllList = adminBadgeRepository.findBySearch(query);
        int cnt = badgeAllList.size();
        map.put("data", badgeList);
        map.put("totalCnt", cnt);
        map.put("recordsFiltered", cnt);
        map.put("draw",draw);
        return map;
    }

    //등록
    public void registBadgeToUsers(String badgeName, String userList) {
        Badge badge = badgeService.getBadgeByName(badgeName);
        if(Objects.isNull(badge) || StringUtils.isBlank(userList))
            return;
        List<Long> usersId = Arrays.stream(StringUtils.replace(userList, " ", "").split(",")).map(Long::new).collect(Collectors.toList());
        StringBuilder contentSB = new StringBuilder();

        for(Long userid : usersId) {
            if(userService.findUser(userid).isPresent()) {
                badgeService.addUserBadges(userid, badge.getId());
                contentSB.append(userid+", ");
            }
        }

        String content = contentSB.toString();
        if(content.isEmpty()) return;

        AdminBadge adminBadge = new AdminBadge();
        adminBadge.setTitle(badgeName);
        adminBadge.setContent(content.substring(0, content.length()-2));
        adminBadge.setWriter(authUtils.getCurrentUser().getNickname());
        adminBadgeRepository.save(adminBadge);
    }

}
