package net.infobank.moyamo.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.repository.AdminBannerRepositoryCustom;
import net.infobank.moyamo.service.AdminBadgeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@AllArgsConstructor
@Controller
@RequestMapping("/admin/**")
public class WebAdminHomeController {

    //배너 리스트
    @GetMapping("/home")
    public String getHome(Model model) {
        model.addAttribute("menuName", "모아보기");
        return "/admin/home";
    }

}
