package com.freelywx.mall.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product")
public class ProductController {
	@RequestMapping("")
	public String init(HttpServletRequest request) { 
		String site_id = request.getParameter("site_id");
		request.setAttribute("site_id", site_id);
		return "product";
	}
}
