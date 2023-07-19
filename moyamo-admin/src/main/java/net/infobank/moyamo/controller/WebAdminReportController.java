package net.infobank.moyamo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin/**")
public class WebAdminReportController {

    @RequestMapping("/reporting")
    public String reporting(Model model) {
    	model.addAttribute("menuName", "게시글 신고 관리");
    	return "/admin/reporting";
    }

    @RequestMapping("/commentReporting")
    public String reportingComment(Model model) {
        model.addAttribute("menuName", "댓글 신고 관리");
        return "/admin/commentReporting";
    }
}
