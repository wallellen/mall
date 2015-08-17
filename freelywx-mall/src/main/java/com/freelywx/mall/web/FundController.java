package com.freelywx.mall.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Scope("session")
@RequestMapping("fund")
public class FundController {

	@ResponseBody
	@RequestMapping("")
	public String index(HttpServletRequest request) {
		return "fund";
	}

}
