package com.freelywx.admin.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.member.MemberShopping;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;

/**
 * 会员购物车
 * 
 * @author ghl
 * 
 */
@Controller
@RequestMapping(value = "/member/shopping")
public class MemberShoppingController {

	@RequestMapping("/index")
	public String index()   {
		return "member/shopping/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(MemberShopping.class, "sql.member/getMemberShoppingList", request);
		return page;
	}
}
