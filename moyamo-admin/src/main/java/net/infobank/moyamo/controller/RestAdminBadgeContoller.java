package net.infobank.moyamo.controller;

import net.infobank.moyamo.service.AdminBadgeService;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/rest")
public class RestAdminBadgeContoller {

    final AuthUtils authUtils;

    final AdminBadgeService adminBadgeService;

    public RestAdminBadgeContoller(AuthUtils authUtils, AdminBadgeService adminBadgeService) {
        this.authUtils = authUtils;
        this.adminBadgeService = adminBadgeService;
    }

    @RequestMapping("/getBadges")
    public ResponseEntity<Map<String, Object>> getBadges(@RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {
        return new ResponseEntity<>(adminBadgeService.getAllAdminBadges(draw, query, PageRequest.of(start/length, length, Sort.by(Sort.Direction.DESC, "id"))), HttpStatus.OK);
    }

}
