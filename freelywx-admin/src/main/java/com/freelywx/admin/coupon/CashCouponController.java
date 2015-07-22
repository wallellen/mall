package com.freelywx.admin.coupon;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.model.coupon.CashCoupon;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

/**
 * 现金劵
 * 
 * @author ghl
 * 
 */
@Controller
@RequestMapping(value = "/coupon/cash")
public class CashCouponController {

	@RequestMapping("")
	public String index()  {
		return "coupon/cash/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(CashCoupon.class, "sql.coupon/getCashCouponList", request);
		return page;
	}

	@RequestMapping("/edit")
	public String edit(HttpServletRequest request) {
		return "coupon/cash/edit";
	}

	@RequestMapping("/getEditR")
	@ResponseBody
	public CashCoupon getEditR(HttpServletRequest request) {
		Long cash_coupon_id = Long.valueOf(request.getParameter("cash_coupon_id"));
		CashCoupon editR = D.selectById(CashCoupon.class, cash_coupon_id);
		return editR;
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean save(@RequestBody CashCoupon cashCoupon, HttpServletRequest request) {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		if (cashCoupon.getCash_coupon_id() != null && cashCoupon.getCash_coupon_id().intValue() != 0) {
			cashCoupon.setLast_update_time(new Date());
			cashCoupon.setLast_updated_by(user.getUser_id());
			D.updateWithoutNull(cashCoupon);
		} else {
			cashCoupon.setCash_coupon_id(null);
			cashCoupon.setCreate_time(new Date());
			cashCoupon.setCreated_by(user.getUser_id());
			D.insert(cashCoupon);
		}
		return true;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public boolean delete(HttpServletRequest request) {
		Long cash_coupon_id = Long.valueOf(request.getParameter("cash_coupon_id"));
		D.deleteById(CashCoupon.class, cash_coupon_id);
		return true;
	}

	@RequestMapping("/checkName")
	@ResponseBody
	public boolean checkName(CashCoupon cashCoupon, HttpServletRequest request) {

		String sql = "SELECT cash_coupon_id FROM T_C_CASH_COUPON WHERE cash_coupon_id <> ? and cash_coupon_name = ?";
		List<CashCoupon> list = D.sql(sql).many(CashCoupon.class, cashCoupon.getCash_coupon_id(),
				cashCoupon.getCash_coupon_name());
		if (list != null && list.size() > 0) {
			// 存在重复名称的情况
			return false;
		}
		return true;
	}
}
