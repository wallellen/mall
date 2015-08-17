package com.freelywx.mall.web;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.mall.util.MallService;
import com.mowei.model.coupon.CashCoupon;
import com.mowei.model.coupon.Coupon2Member;
import com.mowei.model.interal.InteralExchange;
import com.mowei.model.interal.InteralLog;
import com.mowei.model.member.Member;
import com.mowei.model.member.MemberFavorites;
import com.mowei.model.member.TMSignIn;
import com.mowei.model.product.TpProduct;
import com.mowei.model.tribe.TTPraise;
import com.mowei.model.tribe.TTReply;
import com.mowei.model.tribe.TTTopic;
import com.rps.util.D;

@Controller
@Scope("session")
@RequestMapping("member")
public class MemberController {

	private static final Logger log = LoggerFactory
			.getLogger(MemberController.class);

	@RequestMapping("")
	public String index(HttpServletRequest request) throws ParseException {
		log.info("~~~~~MEMBER INDEX~~~~~");

		Member member = MallService.getMember(request);
		member.setMember_level(MallService.upgrade(member));

		Map<String, Object> map = MallService.checkSign(member);
		request.setAttribute("sign", map.get("sign"));// 签到对象
		request.setAttribute("status", map.get("status"));// 是否签到

		List<Integer> level = new ArrayList<Integer>();
		for (int i = 0; i < member.getMember_level(); i++) {
			level.add(i);
		}
		request.setAttribute("level", level);// 等级

		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("user_id", member.getMember_id());
		List<TTTopic> list1 = D.defSql("sql.tribe/listTTT", request, map1)
				.many(TTTopic.class);
		List<TTReply> list2 = D.defSql("sql.tribe/listTTR", request, map1)
				.many(TTReply.class);
		List<TTPraise> list3 = D.defSql("sql.tribe/listTTP", request, map1)
				.many(TTPraise.class);
		request.setAttribute("list1", list1.size());// 发表的话题
		request.setAttribute("list2", list2.size());// 评论的话题
		request.setAttribute("list3", list3.size());// 赞过的话题

		request.setAttribute("interal", MallService.getInteral(member));// 积分
		request.setAttribute("member", member);// 用户

		return "member/index";
	}

	@ResponseBody
	@RequestMapping("sign")
	public int sign(HttpServletRequest request) throws ParseException {
		Member member = MallService.getMember(request);
		Map<String, Object> map = MallService.checkSign(member);

		if ("1".equals(map.get("status").toString()))
			return 2;

		TMSignIn last = (TMSignIn) map.get("sign");
		int count = 1;
		if (last != null)
			count = last.getSign_in_num() + 1;

		TMSignIn sign = new TMSignIn();
		sign.setUser_id(member.getMember_id());
		sign.setSign_in_type("1");
		sign.setCreate_time(new Date());
		sign.setSign_in_num(count);

		MallService.addInteral(member, "1");

		return D.insert(sign);
	}

	@RequestMapping("convert")
	public String inconvertdex(HttpServletRequest request) {
		Member member = MallService.getMember(request);
		InteralExchange ie = D.selectById(InteralExchange.class, 1);
		request.setAttribute("interal", MallService.getInteral(member));
		request.setAttribute("ie", ie);
		return "member/convert";
	}

	@ResponseBody
	@RequestMapping("addCoupon")
	public int addCoupon(HttpServletRequest request) {
		Integer num = Integer.valueOf(request.getParameter("num"));

		Member member = MallService.getMember(request);
		InteralExchange ie = D.selectById(InteralExchange.class, 1);
		int value = ie.getInteral_rule_value();
		int money = ie.getInteral_exchange_value();
		int count = num * value;
		Integer interal = MallService.getInteral(member);

		if (count <= interal) {
			List<InteralLog> interalList = MallService.getInteral1(member);
			for (InteralLog interalLog : interalList) {
				int iValue = interalLog.getInteral_rule_value();
				if (iValue > 0) {
					int diff = count - iValue;
					if (diff >= 0) {
						interalLog.setInteral_rule_value(0);
						interalLog.setUsed_valur(iValue);
						D.update(interalLog);
						if (diff == 0)
							break;
						count = diff;
					} else {
						interalLog.setInteral_rule_value(Math.abs(diff));
						interalLog.setUsed_valur(count);
						D.update(interalLog);
						break;
					}
				}
			}

			int nCount = 0;
			for (int i = 0; i < num; i++) {
				CashCoupon coupon = new CashCoupon();
				coupon.setCash_coupon_name(money + "元现金券");
				coupon.setCash_coupon_value(money * 100);
				coupon.setCash_coupon_start_time(new Date());
				coupon.setCash_coupon_sum(1);
				long coupon_id = D.insertAndReturnLong(coupon);

				Coupon2Member cm = new Coupon2Member();
				cm.setCash_coupon_id(coupon_id);
				cm.setCoupon_type("1");
				cm.setCoupon_state("1");
				cm.setMember_id(member.getMember_id());
				cm.setBind_time(new Date());
				cm.setCash_coupon_start_time(new Date());

				nCount += D.insert(cm);
			}

			return nCount;
		} else {
			return 0;
		}
	}

	@RequestMapping("favor")
	public String favor(HttpServletRequest request) {
		log.info("~~~~~MEMBER FAVOR~~~~~");

		Member member = MallService.getMember(request);
		String sql = "SELECT * FROM T_M_FAVORITES WHERE MEMBER_ID = ?";
		List<MemberFavorites> favorList = D.sql(sql).many(
				MemberFavorites.class, member.getMember_id());
		for (MemberFavorites favor : favorList) {
			TpProduct prod = D.selectById(TpProduct.class, favor.getProd_id());
			prod.setPic_url(MallService.getProdPic(prod.getProd_id()).get(0).getPic_url());
			favor.setProduct(prod);
		}

		request.setAttribute("favor", favorList);

		return "member/favor";
	}

	@RequestMapping("delFavor")
	public String delFavor(HttpServletRequest request) {
		log.info("~~~~~MEMBER DEL FAVOR~~~~~");

		String prod_id = request.getParameter("id");

		Member member = MallService.getMember(request);

		String sql = "SELECT * FROM T_M_FAVORITES WHERE MEMBER_ID = ? AND PROD_ID = ?";
		MemberFavorites favor = D.sql(sql).one(MemberFavorites.class,
				member.getMember_id(), prod_id);

		D.delete(favor);
		return "redirect:favor";
	}

	@RequestMapping("coupon")
	public String coupon(HttpServletRequest request) {
		log.info("~~~~~MEMBER COUPON~~~~~");

		String type = request.getParameter("type");
		if (type == null)
			return "redirect:member/";

		Member member = MallService.getMember(request);

		request.setAttribute("coupon", MallService.getCoupon(member, type));
		request.setAttribute("type", type);

		return "member/coupon";
	}

}
