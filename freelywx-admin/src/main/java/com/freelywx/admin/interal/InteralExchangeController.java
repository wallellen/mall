package com.freelywx.admin.interal;


import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.interal.InteralExchange;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

/**
 * 积分规则
 * 
 * @author ghl
 * 
 */
@Controller
@RequestMapping(value = "/interal/exchange")
public class InteralExchangeController {

	@RequestMapping("")
	public String index()  {
		return "interal/exchange/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(InteralExchange.class, "sql.interal/getInteralExchangeList", request);
		return page;
	}

	@RequestMapping("/edit")
	public String edit(HttpServletRequest request) {
		return "interal/exchange/edit";
	}
	
	
	@RequestMapping("/getEditR")
	@ResponseBody
	public InteralExchange getEditR(HttpServletRequest request) {
		Long interal_exchange_id = Long.valueOf(request.getParameter("interal_exchange_id"));
		InteralExchange editR = D.selectById(InteralExchange.class, interal_exchange_id);
		return editR;
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean save(@RequestBody InteralExchange interalExchange, HttpServletRequest request) {
		//User user = (User) R.getSession(request, "user");
		if (interalExchange.getInteral_exchange_id() != null && interalExchange.getInteral_exchange_id().intValue() != 0) {
			interalExchange.setCreate_time(new Date());
			D.updateWithoutNull(interalExchange);
		} else {
			interalExchange.setInteral_exchange_id(null);
			interalExchange.setCreate_time(new Date());
			D.insert(interalExchange);
		}
		return true;
	}
}
