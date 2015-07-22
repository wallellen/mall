package com.freelywx.admin.interal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.interal.InteralLog;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;

/**
 * 积分日志
 * 
 * @author ghl
 * 
 */
@Controller
@RequestMapping(value = "/interal/log")
public class InteralLogController {

	@RequestMapping("")
	public String index()  {
		return "interal/log/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(InteralLog.class, "sql.interal/getInteralLogList", request);
		return page;
	}
}
