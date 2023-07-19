package net.infobank.moyamo.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@Controller
@RequestMapping("/**")
public class LoginController {

	private static final String PAGE_ERROR_403 = "error403";

    // 로그인
    @RequestMapping(value = {"/"}, method={RequestMethod.GET ,RequestMethod.POST})
	public String rootLogin() {
    	log.info("rootLogin page");
    	return "redirect:/login";
	}

    //로그인 페이지
    @RequestMapping(value = {"/login"}, method={RequestMethod.GET ,RequestMethod.POST})
	public String login(Model model, HttpServletRequest request, String logout) {
		log.info("login page");
    	if (logout != null){
    		String errorFlag = (String)request.getAttribute("error_flag");
			String providerId = (String)request.getAttribute("providerId");

			log.info("errorFlag : {}", errorFlag);
			model.addAttribute("error_flag", errorFlag);
			model.addAttribute("providerId", providerId);
    	    model.addAttribute("logout", "You have been logged out successfully.");
        }
    	return "login";
	}

    // 로그인 실패시
    @RequestMapping(value = {"/loginError"}, method={RequestMethod.GET , RequestMethod.POST})
	public String error403(Model model) {
    	model.addAttribute("error", "Your username and password is invalid.");
		log.info(PAGE_ERROR_403);
    	return PAGE_ERROR_403;
	}

	// 권한없는 페이지를 들어갔을때
	@RequestMapping(PAGE_ERROR_403)
	public String access(){
		return PAGE_ERROR_403;
	}


	// AWS Ping/Pong
	@RequestMapping("ping")
	public String ping(){
		return PAGE_ERROR_403;
	}

}
