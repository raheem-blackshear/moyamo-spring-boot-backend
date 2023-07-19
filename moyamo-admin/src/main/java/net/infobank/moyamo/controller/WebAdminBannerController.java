package net.infobank.moyamo.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.enumeration.BannerStatus;
import net.infobank.moyamo.repository.AdminBannerRepositoryCustom;
import net.infobank.moyamo.service.AdminBadgeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@AllArgsConstructor
@Controller
@RequestMapping("/admin/**")
public class WebAdminBannerController {

    private final AdminBadgeService adminBadgeService;
    private final AdminBannerRepositoryCustom adminBannerRepositoryCustom;

    //배너 리스트
    @GetMapping("/banner")
    public String getBanner(Model model, @RequestParam(value = "q", required = false) String q, @RequestParam(value = "status", required = false) BannerStatus status) {
        model.addAttribute("menuName", "배너");
        return "/admin/banner";
    }

    @PostMapping("/banner")
    public String postBanner(Model model, @RequestParam(value = "q", required = false) String q, @RequestParam(value = "status", required = false) BannerStatus status) {
        model.addAttribute("menuName", "배너");
        model.addAttribute("list", adminBannerRepositoryCustom.findAll(q, status));
        return "redirect:/admin/banner";
    }

    //뱃지 등록
    @RequestMapping("/banner/regist")
    public String registBadge(HttpServletRequest request) {

        String badgeName = request.getParameter("badgeName");
        String userList = request.getParameter("userList");
        adminBadgeService.registBadgeToUsers(badgeName, userList);

        return "redirect:/admin/banner";
    }

}
