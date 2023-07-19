package net.infobank.moyamo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin/**")
public class WebAdminProviderHistoryController {

    @RequestMapping("/providerHistory")
    public String tag(Model model) {
    	model.addAttribute("menuName", "가입내역 검색");
    	return "/admin/providerHistory";
    }

}
