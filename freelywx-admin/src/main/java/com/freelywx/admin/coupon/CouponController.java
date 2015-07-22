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
import com.freelywx.common.model.coupon.Coupon;
import com.freelywx.common.util.ComboxModel;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

/**
 * 优惠券
 * 
 * @author ghl
 * 
 */
@Controller
@RequestMapping(value = "/coupon/coupon")
public class CouponController {

	@RequestMapping("")
	public String index()  {
		return "coupon/coupon/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(Coupon.class, "sql.coupon/getCouponList", request);
		return page;
	}

	@RequestMapping("/edit")
	public String edit(HttpServletRequest request) {
		return "coupon/coupon/edit";
	}

	@RequestMapping("/getEditR")
	@ResponseBody
	public Coupon getEditR(HttpServletRequest request) {
		Long coupon_id = Long.valueOf(request.getParameter("coupon_id"));
		Coupon editR = D.selectById(Coupon.class, coupon_id);
		return editR;
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean save(@RequestBody Coupon coupon, HttpServletRequest request) {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		if (coupon.getCoupon_id() != null && coupon.getCoupon_id().intValue() != 0) {
			coupon.setLast_update_time(new Date());
			coupon.setLast_updated_by(user.getUser_id());
			D.updateWithoutNull(coupon);
		} else {
			coupon.setCoupon_id(null);
			coupon.setCreate_time(new Date());
			coupon.setCreated_by(user.getUser_id());
			D.insert(coupon);
		}
		return true;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public boolean delete(HttpServletRequest request) {
		Long coupon_id = Long.valueOf(request.getParameter("coupon_id"));
		D.deleteById(Coupon.class, coupon_id);
		return true;
	}

	@RequestMapping("/getProdType")
	@ResponseBody
	public List<ComboxModel> getProdType() {
		String sql = "select category_id id ,category_name text from T_P_CATEGORY";
		return D.sql(sql).many(ComboxModel.class);
	}

	@RequestMapping("/checkName")
	@ResponseBody
	public boolean checkName(Coupon coupon, HttpServletRequest request) {

		String sql = "SELECT coupon_id FROM T_C_COUPON WHERE coupon_id <> ? and coupon_name = ?";
		List<Coupon> list = D.sql(sql).many(Coupon.class, coupon.getCoupon_id(), coupon.getCoupon_name());
		if (list != null && list.size() > 0) {
			// 存在重复名称的情况
			return false;
		}
		return true;
	}
}
