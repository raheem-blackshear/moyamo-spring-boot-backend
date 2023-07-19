package net.infobank.moyamo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin/**")
public class WebAdminNoticeController {

    @RequestMapping("/notice")
    public String tag(Model model) {
    	model.addAttribute("menuName", "공지사항");
        model.addAttribute("type", "notice");
    	return "/admin/notice";
    }

}
