package net.infobank.moyamo.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/admin/**")
public class WebAdminAgreeController {

    @RequestMapping("/agree")
    public String tag(Model model)  {
    	model.addAttribute("menuName", "약관동의 처리");
    	return "/admin/agree";
    }

}
