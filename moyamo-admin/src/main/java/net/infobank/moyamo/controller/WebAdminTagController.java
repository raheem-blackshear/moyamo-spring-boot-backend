package net.infobank.moyamo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin/**")
public class WebAdminTagController {

    @RequestMapping("/tag")
    public String tag(Model model) {
    	model.addAttribute("menuName", "태그 관리");
    	return "/admin/tag";
    }

}
