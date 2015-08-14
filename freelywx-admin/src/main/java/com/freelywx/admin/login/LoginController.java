package com.freelywx.admin.login;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.freelywx.admin.shiro.CaptchaFormAuthenticationFilter;

@Controller
@RequestMapping(value = "/login")
public class LoginController {

	@RequestMapping(method = RequestMethod.GET)
	public String login() {
		return "login";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String fail(@RequestParam(CaptchaFormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String userName, Model model) {
		System.out.println("2");
		model.addAttribute(CaptchaFormAuthenticationFilter.DEFAULT_USERNAME_PARAM, userName);
		return "login";
	}

}
