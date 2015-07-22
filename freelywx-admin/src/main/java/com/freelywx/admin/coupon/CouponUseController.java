package com.freelywx.admin.coupon;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.coupon.Coupon2Member;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;

/**
 * 劵使用情况
 * 
 * @author ghl
 * 
 */
@Controller
@RequestMapping(value = "/coupon/use")
public class CouponUseController {

	@RequestMapping("")
	public String index()  {
		return "coupon/use/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(Coupon2Member.class, "sql.coupon/getCouponUseList", request);
		return page;
	}
}
