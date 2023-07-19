package net.infobank.moyamo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin/**")
public class WebAdminMentionController {

    @RequestMapping("/mention")
    public String reportingComment(Model model) {
        model.addAttribute("menuName", "언급 댓글");
        return "/admin/mention";
    }
}
