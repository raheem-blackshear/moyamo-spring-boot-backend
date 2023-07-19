package net.infobank.moyamo.controller;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 포스팅 Web
 */
@AllArgsConstructor
@Controller
@RequestMapping("/admin/**")
public class WebAdminUserController {

    private static final String MENU_NAME_FIELD = "menuName";

	// 관리자
    @RequestMapping("/adminUser")
    public String adminUser(Model model) {
    	model.addAttribute(MENU_NAME_FIELD, "유저관리 - 관리자");
    	return "/admin/adminUser";
    }

    @RequestMapping("/modifyUser")
    public String modifyUser(Model model) {
    	model.addAttribute(MENU_NAME_FIELD, "유저관리 - 관리자");
    	return "redirect:/admin/adminUser";
    }

    // 관리자
    @RequestMapping("/expertUser")
    public String expertUser(Model model) {
    	model.addAttribute(MENU_NAME_FIELD, "유저관리 - 전문가");
    	return "/admin/expertUser";
    }
    // 관리자
    @RequestMapping("/normalUser")
    public String magazine(Model model) {
    	model.addAttribute(MENU_NAME_FIELD, "유저관리 - 일반유저");
    	return "/admin/normalUser";
    }
}
