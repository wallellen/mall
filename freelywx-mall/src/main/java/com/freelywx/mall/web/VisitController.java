package com.freelywx.mall.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.mall.util.MallService;
import com.mowei.model.visit.TVShare;
import com.mowei.model.visit.TVVisit;
import com.rps.util.D;

@Controller
@Scope("session")
@RequestMapping("visit")
public class VisitController {

	private static final Logger log = LoggerFactory
			.getLogger(VisitController.class);

	/**
	 * 链接访问日志
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("visit")
	public int visit(HttpServletRequest request) {
		log.info("~~~~~VISIT~~~~~");

		String t = request.getParameter("t");
		String l = request.getParameter("l");
		String o = request.getParameter("o");
		String s = request.getParameter("s");
		String i = request.getParameter("i");
		String c = request.getParameter("c");
		String os = request.getParameter("os");
		String bs = request.getParameter("bs");

		TVVisit visit = new TVVisit();
		visit.setVisit_title(t);
		visit.setVisit_url(l);
		visit.setVisit_url_from(o);
		visit.setVisit_screen(s);
		visit.setVisit_ip(i);
		visit.setVisit_city(c);
		visit.setVisit_os(os);
		visit.setVisit_browser(bs);

		visit.setMember_id(Integer.valueOf(MallService.getMember(request).getMember_id()
				.toString()));
		visit.setOpen_id(MallService.getMember(request).getMember_w_id());
		visit.setVisit_time_in(new Date());

		return D.insertWithoutNull(visit);
	}

	/**
	 * 微信分享日志
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("share")
	public int share(HttpServletRequest request) {
		log.info("~~~~~SHARE~~~~~");

		String mt = request.getParameter("merchant_id");
		String p = request.getParameter("prod_id");
		String o = request.getParameter("order_id");
		String s = request.getParameter("s_type");// 1、好友 2、朋友圈
		String t = request.getParameter("type");// 1、普通 2、众筹
		String u = request.getParameter("url");
		String ip = request.getHeader("x-forwarded-for");

		TVShare share = new TVShare();

		if (mt != null)
			share.setMerchant_id(Long.valueOf(mt));
		share.setMember_id(MallService.getMember(request).getMember_id());

		if (p != null)
			share.setProd_id(Integer.valueOf(p));
		if (o != null)
			share.setOrder_id(Long.valueOf(o));

		share.setType(t);
		share.setIp_address(ip);
		share.setUrl(u);

		share.setShare_type(s);
		share.setShate_time(new Date());

		return D.insert(share);
	}

}
