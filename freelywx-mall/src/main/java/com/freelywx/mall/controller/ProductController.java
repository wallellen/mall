package com.freelywx.mall.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.freelywx.common.model.store.TmSite;
import com.rps.util.D;

@Controller
@RequestMapping("/product")
public class ProductController {
	@RequestMapping("")
	public String init(HttpServletRequest request) { 
		String site_id = request.getParameter("site_id");
		//TmSite site = D.selectById(TmSite.class, site_id);
		//后台做一个对应的公告信息
		//request.setAttribute("site", site);
		return "product";
	}
}
