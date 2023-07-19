package net.infobank.moyamo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin/**")
public class WebAdminEventController {

    @RequestMapping("/event")
    public String tag(Model model) {
    	model.addAttribute("menuName", "이벤트");
        model.addAttribute("type", "event");
    	return "/admin/notice";
    }

}
