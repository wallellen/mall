package com.freelywx.admin.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.member.MemberAddress;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;

/**
 * 会员地址
 * 
 * @author ghl
 * 
 */
@Controller
@RequestMapping(value = "/member/address")
public class MemberAddressController {

	@RequestMapping("/index")
	public String index()   {
		return "member/address/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(MemberAddress.class, "sql.member/getMemberAddressList", request);
		return page;
	}
}
