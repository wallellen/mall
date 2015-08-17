package com.freelywx.mall.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.mall.util.MallService;
import com.mowei.model.member.MemberAddress;
import com.rps.util.D;

@Controller
@Scope("session")
@RequestMapping("addr")
public class AddrController {

	private static final Logger log = LoggerFactory.getLogger(AddrController.class);

	/**
	 * 地址页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("address")
	public String address(HttpServletRequest request) {
		log.info("~~~~~ADDRESS~~~~~");

		request.setAttribute("prod_id", request.getParameter("prod_id"));
		request.setAttribute("count", request.getParameter("count"));
		request.setAttribute("color", request.getParameter("color"));
		request.setAttribute("coupon", request.getParameter("coupon"));

		List<MemberAddress> addressList = D.sql(
				"SELECT * FROM T_M_ADDRESS WHERE MEMBER_ID = ?").many(
				MemberAddress.class, MallService.getMember(request).getMember_id());
		request.setAttribute("addressList", addressList);

		return "address/list";
	}

	/**
	 * 获取地址
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("getAddress")
	public String getAddress(HttpServletRequest request) {
		log.info("~~~~~GETADDRESS~~~~~");

		request.setAttribute("prod_id", request.getParameter("prod_id"));
		request.setAttribute("count", request.getParameter("count"));
		request.setAttribute("color", request.getParameter("color"));
		request.setAttribute("coupon", request.getParameter("coupon"));
		request.setAttribute("id", request.getParameter("id"));

		String id = request.getParameter("id");
		if (id != null && id != "") {
			request.setAttribute("address",
					D.selectById(MemberAddress.class, id));
		}

		return "address/edit";
	}

	/**
	 * 新增地址
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("addAddress")
	public int addAddress(HttpServletRequest request) {
		log.info("~~~~~ADDADDRESS~~~~~");

		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");

		MemberAddress memberAddress = new MemberAddress();
		memberAddress.setMember_id(MallService.getMember(request).getMember_id());
		memberAddress.setConsignee_name(name);
		memberAddress.setAddress(address);
		memberAddress.setPhone(phone);
		memberAddress.setAddress_default("1");

		return D.insertWithoutNull(memberAddress);
	}

	/**
	 * 修改地址
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("updAddress")
	public Long updAddress(HttpServletRequest request) {
		log.info("~~~~~UPDADDRESS~~~~~");

		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");

		MemberAddress memberAddress = new MemberAddress();
		List<MemberAddress> list = D.sql(
				"SELECT * FROM T_M_ADDRESS WHERE MEMBER_ID = ?").many(
				MemberAddress.class, MallService.getMember(request).getMember_id());
		if (list.size() > 0) {
			memberAddress = list.get(0);
			memberAddress.setConsignee_name(name);
			memberAddress.setAddress(address);
			memberAddress.setPhone(phone);

			D.updateWithoutNull(memberAddress);
			return memberAddress.getAddress_id();
		} else {
			memberAddress.setMember_id(MallService.getMember(request).getMember_id());
			memberAddress.setConsignee_name(name);
			memberAddress.setAddress(address);
			memberAddress.setPhone(phone);
			memberAddress.setAddress_default("1");

			return (long) D.insertAndReturnInteger(memberAddress);
		}

		// MemberAddress memberAddress = D.selectById(MemberAddress.class, id);
		// memberAddress.setConsignee_name(name);
		// memberAddress.setAddress(address);
		// memberAddress.setPhone(phone);

		// return D.updateWithoutNull(memberAddress);
	}

	/**
	 * 删除地址
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("delAddress")
	public int delAddress(HttpServletRequest request) {
		log.info("~~~~~DELADDRESS~~~~~");

		return D.deleteById(MemberAddress.class, request.getParameter("id"));
	}

}
