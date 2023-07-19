package net.infobank.moyamo.controller;

import net.infobank.moyamo.service.AdminBadgeService;
import net.infobank.moyamo.service.BadgeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin/**")
public class WebAdminBadgeController {

    @Autowired
    AdminBadgeService adminBadgeService;

    @Autowired
    BadgeService badgeService;

    //뱃지 리스트
    @RequestMapping("/badge")
    public String badge(Model model, HttpServletRequest request, HttpServletResponse response) {
        model.addAttribute("menuName", "뱃지");
        model.addAttribute("allBadges",badgeService.getAllBadgesByActiveTrue());
        return "/admin/badge";
    }

    //뱃지 등록
    @RequestMapping("/registBadge")
    public String registBadge(Model model, HttpServletRequest request, HttpServletResponse response) {

        String badgeName = request.getParameter("badgeName");
        String userList = request.getParameter("userList");
        adminBadgeService.registBadgeToUsers(badgeName, userList);

        return "redirect:/admin/badge";
    }

}
