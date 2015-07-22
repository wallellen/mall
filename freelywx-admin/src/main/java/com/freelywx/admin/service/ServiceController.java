package com.freelywx.admin.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.service.TCusService;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;

@Controller
@RequestMapping("/service")
public class ServiceController {
	@RequestMapping("")
	public String init() {
		
	//	ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
	//	return user.getMerchantWx();
		
		return "service/service";
	}

	@ResponseBody
	@RequestMapping("list")
	public PageModel SearchEmployees(HttpServletRequest request) throws Exception
	{ 		
		return PageUtil.getPageModel(TCusService.class, "sql.service/getServiceList",request);
	}
	
}
