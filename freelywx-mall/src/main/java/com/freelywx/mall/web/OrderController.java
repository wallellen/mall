package com.freelywx.mall.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.mall.util.MallService;
import com.mowei.model.coupon.CashCoupon;
import com.mowei.model.coupon.Coupon;
import com.mowei.model.coupon.Coupon2Member;
import com.mowei.model.marketing.TMarketingCrowd;
import com.mowei.model.marketing.TTempTemplate;
import com.mowei.model.member.Member;
import com.mowei.model.member.MemberAddress;
import com.mowei.model.order.Order;
import com.mowei.model.order.OrderDetail;
import com.mowei.model.order.OrderDetailAttr;
import com.mowei.model.order.TOOrderPay;
import com.mowei.model.product.TpProduct;
import com.mowei.model.product.TpProductPic;
import com.mowei.wx.utils.SHA1Util;
import com.rps.util.D;
import com.whtriples.menu.pojo.AccessToken;
import com.whtriples.message.req.DeliverMessage;
import com.whtriples.utils.MessageUtil;
import com.whtriples.utils.WeixinUtil;

@Controller
@Scope("session")
@RequestMapping("order")
public class OrderController {
	private static final Logger log = LoggerFactory
			.getLogger(OrderController.class);

	/**
	 * 订单确定页
	 * 
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("")
	public String order(HttpServletRequest request)
			throws UnsupportedEncodingException {
		log.info("~~~~~ORDER~~~~~");

		String prod_id = request.getParameter("prod_id");// 商品编号
		String count = request.getParameter("count");// 数量
		String color = request.getParameter("color");// 颜色
		String coupon = request.getParameter("coupon");// 优惠券

		color = URLEncoder.encode(color, "UTF-8");
		return "redirect:order/confirm?prod_id=" + prod_id + "&count=" + count
				+ "&color=" + color + "&coupon=" + coupon;// 重定向
	}

	/**
	 * 订单确认
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("confirm")
	public String orderjsp(HttpServletRequest request) {
		log.info("~~~~~ORDER JSP~~~~~");

		String access_token = request.getAttribute("access_token").toString();
		log.info("~~~~~ ACCESS_TOKEN ~~~~~" + access_token);
		request.setAttribute("access_token", access_token);

		String prod_id = request.getParameter("prod_id");// 商品编号
		String count = request.getParameter("count");// 数量
		String color = request.getParameter("color");// 颜色
		String coupon = request.getParameter("coupon");// 优惠券
		String type = request.getParameter("type");// 1、普通 2、送礼

		if ("2".equals(type))
			coupon = "0";

		Coupon2Member c2m = D.selectById(Coupon2Member.class, coupon);
		if (c2m != null) {
			boolean boo = false;
			if (c2m.getOrder_id() == null) {
				if (c2m.getCash_coupon_end_time() == null) {
					boo = true;
				} else {
					if (c2m.getCash_coupon_end_time().getTime() > new Date()
							.getTime())
						boo = true;
				}
			}

			if (boo) {
				if (c2m.getCoupon_type().equals("1")) {
					CashCoupon cc = D.selectById(CashCoupon.class,
							c2m.getCash_coupon_id());
					request.setAttribute("cc", cc);
				}
				if (c2m.getCoupon_type().equals("2")) {
					Coupon cc = D.selectById(Coupon.class,
							c2m.getCash_coupon_id());
					request.setAttribute("cc", cc);
				}
			}
		}

		// 根据请求的商品编号查询智能穿戴商品信息
		TpProduct product = D.selectById(TpProduct.class, prod_id);

		List<TpProductPic> prodPicList = MallService.getProdPic(product.getProd_id());
		request.setAttribute("prodPic", prodPicList.get(0));

		String url = "prod_id=" + prod_id + "&count=" + count + "&color="
				+ color + "&coupon=" + coupon + "&type=1";
		if (request.getParameter("address_id") == null) {
			List<MemberAddress> address = D.sql(
					"SELECT * FROM T_M_ADDRESS WHERE MEMBER_ID = ?").many(
					MemberAddress.class, MallService.getMember(request).getMember_id());
			if (address.size() > 0) {
				url = url + "&address_id=" + address.get(0).getAddress_id();
				request.setAttribute("address", address.get(0));
				request.setAttribute("addressS", "0");
			} else {
				request.setAttribute("addressS", "1");
			}
		} else {
			MemberAddress address = D.selectById(MemberAddress.class,
					request.getParameter("address_id"));
			url = url + "&address_id=" + address.getAddress_id();
			request.setAttribute("address", address);
			request.setAttribute("addressS", "0");
		}
		request.setAttribute("url", url);

		request.setAttribute("prod", product);
		request.setAttribute("prod_id", prod_id);
		request.setAttribute("count", count);
		request.setAttribute("color", color);
		request.setAttribute("coupon", coupon);

		// 获取广告
		// TaAdvertisement advertise = getAdverti();
		// request.setAttribute("advertise", advertise);

		request.setAttribute("tip", MallService.getTip("1"));

		if ("2".equals(type))
			return "order/gift";// 前往送礼确认页
		return "order/confirm";// 前往订单确认页
	}

	/**
	 * 送礼
	 * @param request
	 * @return
	 */
	
	@RequestMapping("gift")
	public String gift(HttpServletRequest request) {
		String order_id = request.getParameter("order_id");

		Order order = D.selectById(Order.class, order_id);
		String s = order.getShipper();// 收货人姓名
		String a = order.getAddress();// 收货地址
		String p = order.getPhone();// 手机号
		if (s != null && a != null && p != null)
			return "redirect:/";

		OrderDetail oDetail = D.sql(
				"SELECT * FROM T_O_ORDER_DETAIL WHERE ORDER_ID = ?").oneOrNull(
				OrderDetail.class, order_id);

		List<OrderDetailAttr> oDetailAttr = D.sql(
				"SELECT * FROM T_O_ORDER_DETAIL_ATTR WHERE ORDER_ID = ?").many(
				OrderDetailAttr.class, order_id);
		for (OrderDetailAttr ada : oDetailAttr) {
			if ("颜色".equals(ada.getProd_attr()))
				request.setAttribute("color", ada.getProd_attr_value());
		}

		TpProduct prod = D.selectById(TpProduct.class, oDetail.getProd_id());
		List<TpProductPic> prodPic = MallService.getProdPic(prod.getProd_id());

		List<MemberAddress> address = D.sql(
				"SELECT * FROM T_M_ADDRESS WHERE MEMBER_ID = ?").many(
				MemberAddress.class, MallService.getMember(request).getMember_id());
		if (address.size() > 0) {
			request.setAttribute("address", address.get(0));
			request.setAttribute("addressS", "0");
		} else {
			request.setAttribute("addressS", "1");
		}

		Coupon2Member c2m = D.sql(
				"SELECT * FROM T_C_COUPON_2_MEMBER WHERE ORDER_ID = ?")
				.oneOrNull(Coupon2Member.class, order_id);
		if (c2m != null) {
			if (c2m.getCoupon_type().equals("1")) {
				CashCoupon cc = D.selectById(CashCoupon.class,
						c2m.getCash_coupon_id());
				request.setAttribute("cc", cc);
			}
			if (c2m.getCoupon_type().equals("2")) {
				Coupon cc = D.selectById(Coupon.class, c2m.getCash_coupon_id());
				request.setAttribute("cc", cc);
			}
		}

		request.setAttribute("zone", MallService.getZone(request, "0", "1"));

		// TaAdvertisement advertise = getAdverti();
		// request.setAttribute("advertise", advertise);

		request.setAttribute("tip", MallService.getTip("1"));

		request.setAttribute("order", order);
		request.setAttribute("oDetail", oDetail);
		request.setAttribute("prod", prod);
		request.setAttribute("prodPic", prodPic.get(0));

		return "order/gifted";// 前往送礼确认页
	}

	@RequestMapping("zone")
	public String zone(HttpServletRequest request) {
		String pid = request.getParameter("pid");
		String nid = request.getParameter("nid");
		request.setAttribute("nid", nid);
		request.setAttribute("zone", MallService.getZone(request, pid, nid));
		return "order/zone";
	}

	@ResponseBody
	@RequestMapping("updOrder")
	public String updOrder(HttpServletRequest request) {
		String orderId = request.getParameter("order_id");
		Integer count = Integer.valueOf(request.getParameter("count"));
		String prod_id = request.getParameter("prod_id");
		String color = request.getParameter("color");
		String coupon = request.getParameter("coupon");
		String pay_type = request.getParameter("pay_type");
		String type = request.getParameter("type");

		Member member = MallService.getMember(request);
		if ("0".equals(orderId)) {
			orderId = MallService.packOrder(member, coupon, prod_id, type, pay_type, count,
					color).toString();
		} else {
			Order order = D.selectById(Order.class, orderId);

			TpProduct tpProduct = D.selectById(TpProduct.class, prod_id);

			Long totalPrice = tpProduct.getSale_price() * count;// 商品价格*数量=总金额

			order.setProd_amount(count);// 商品数量
			order.setTotal_prod_price(totalPrice);// 总金额
			order.setTotal_discount_price(totalPrice
					- order.getTotal_coupon_price());// 使用优惠券后的总金额

			Long freighPrice = 0L;// 运费
			if (tpProduct.getFreigh_price() != null)
				freighPrice = tpProduct.getFreigh_price();
			order.setTransit_price(freighPrice);// 运费
			order.setPayment_price(order.getTotal_discount_price()
					+ freighPrice);// 支付金额

			D.update(order);
		}

		return orderId;
	}

	@ResponseBody
	@RequestMapping("updAddrOrder")
	public int updAddrOrder(HttpServletRequest request) {
		String order_id = request.getParameter("order_id");
		String address_id = request.getParameter("address_id");// 地址
		String n = request.getParameter("n");// 姓名
		String p = request.getParameter("p");// 电话
		String a = request.getParameter("a");// 地址

		Order order = D.selectById(Order.class, order_id);
		if (order != null) {
			if (address_id != null) {
				n = order.getShipper();
				p = order.getPhone();
				a = order.getAddress();
				if (n != null && p != null && a != null)
					return -1;
				MemberAddress address = D.selectById(MemberAddress.class,
						address_id);
				if (address != null) {
					order.setShipper(address.getConsignee_name());// 收货人姓名
					order.setAddress(address.getAddress());// 收货地址
					order.setPhone(address.getPhone());// 手机号
					return D.update(order);
				}
			} else if (n != null && p != null && a != null) {
				order.setShipper(n);// 收货人姓名
				order.setAddress(a);// 收货地址
				order.setPhone(p);// 手机号
				return D.update(order);
			}
		}

		return 0;
	}

	/**
	 * 生成订单
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("create")
	public String create(HttpServletRequest request) {

		String orderId = request.getParameter("order_id");
		String prod_id = request.getParameter("prod_id");// 商品编号
		Integer count = Integer.valueOf(request.getParameter("new_count"));// 数量
		String color = request.getParameter("color");// 颜色
		String coupon = request.getParameter("coupon");// 优惠券
		String address_id = request.getParameter("address_id");// 地址
		String pay_type = request.getParameter("pay_type");// 1、微信支付 2、货到付款
		String type = request.getParameter("type");// 1、普通 2、众筹

		Member member = MallService.getMember(request);

		Order order = new Order();
		if ("0".equals(orderId) || orderId == null) {
			Long order_id = MallService.packOrder(member, coupon, prod_id, type, pay_type,
					count, color);
			order = D.selectById(Order.class, order_id);
			if ("2".equals(type)) {
				String message = request.getParameter("message");
				log.info("~~~~~message1-------------------"+message);
				try {
					log.info("~~~~~message2-------------------"+new String(message.getBytes("iso8859-1"),"utf-8"));
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				order.setMessage(message);
			}

		} else {
			TpProduct tpProduct = D.selectById(TpProduct.class, prod_id);
			Long totalPrice = tpProduct.getSale_price() * count;// 商品价格*数量=总金额

			Long freighPrice = 0L;// 运费
			if (tpProduct.getFreigh_price() != null)
				freighPrice = tpProduct.getFreigh_price();

			order = D.selectById(Order.class, orderId);
			order.setProd_amount(count);// 商品数量
			order.setTotal_prod_price(totalPrice);// 总金额
			order.setTotal_discount_price(totalPrice
					- order.getTotal_coupon_price());// 使用优惠券后的总金额
			order.setTransit_price(freighPrice);// 运费
			order.setPayment_price(order.getTotal_discount_price()
					+ freighPrice);// 支付金额
		}

		MemberAddress address = D.selectById(MemberAddress.class, address_id);
		if (address_id == null || "".equals(address_id) || address == null) {
			String address_id_r = request.getParameter("address_id_r");// 地址
			address = D.selectById(MemberAddress.class, address_id_r);
		}
		order.setShipper(address.getConsignee_name());// 收货人姓名
		order.setAddress(address.getAddress());// 收货地址
		order.setPhone(address.getPhone());// 手机号
		D.update(order);

		TOOrderPay opay = new TOOrderPay();
		opay.setOrder_id(order.getOrder_id());
		opay.setMember_id(member.getMember_id());
		opay.setMember_w_id(member.getMember_w_id());
		opay.setMember_name(member.getMember_name());
		if ("2".equals(type)) {   //2、众筹
			opay.setPay_amount(0l);
		} else {
			opay.setPay_amount(order.getPayment_price());
		}
		opay.setPay_time(new Date());
		opay.setStatus("1");
		Long pay_id = D.insertAndReturnLong(opay);

		if ("2".equals(type))
			return "redirect:/raise/detail?order_id=" + order.getOrder_id();
		return "redirect:/order/finish?order_id=" + order.getOrder_id()
				+ "&type=1&pay_type=" + pay_type + "&pay_id=" + pay_id;// 重定向
	}

	@ResponseBody
	@RequestMapping("checkCoupon")
	public int checkCoupon(HttpServletRequest request) {
		String coupon = request.getParameter("coupon");// 优惠券
		if (coupon != null || !"".equals(coupon)) {
			Coupon2Member c2m = D.selectById(Coupon2Member.class, coupon);
			if (c2m != null) {
				if (c2m.getOrder_id() != null && c2m.getOrder_id() > 0) {
					return -1;
				}
			}
		}
		return 0;
	}

	/**
	 * 订单完成页/订单详细页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("finish")
	public String ordered(HttpServletRequest request) {
		log.info("~~~~~ORDER ED~~~~~");

		String IP = request.getHeader("x-forwarded-for");
		request.setAttribute("IP", IP);

		String order_id = request.getParameter("order_id");
		String type = request.getParameter("type");
		String pay_type = request.getParameter("pay_type");
		String pay_id = request.getParameter("pay_id");
		request.setAttribute("pay_id", pay_id);

		Order order = D.selectById(Order.class, order_id);
		if (order.getMember_id() - MallService.getMember(request).getMember_id() != 0)
			return "redirect:/";

		List<OrderDetail> orderDetailList = D.sql(
				"select * from T_O_ORDER_DETAIL where order_id = ?").many(
				OrderDetail.class, order_id);
		List<OrderDetailAttr> orderDetailAttrList = D.sql(
				"select * from T_O_ORDER_DETAIL_ATTR where order_id = ?").many(
				OrderDetailAttr.class, order_id);

		request.setAttribute("order", order);
		if (orderDetailList.size() > 0) {
			TpProduct prod = D.selectById(TpProduct.class,
					orderDetailList.get(0).getProd_id());
			request.setAttribute("prodPic",
					MallService.getProdPic(orderDetailList.get(0).getProd_id()).get(0));
			request.setAttribute("prod", prod);
			request.setAttribute("orderDetail", orderDetailList.get(0));
		}
		if (orderDetailAttrList.size() > 0) {
			request.setAttribute("orderDetailAttr", orderDetailAttrList.get(0));
		}

		List<Coupon2Member> cmList = D.sql(
				"SELECT * FROM T_C_COUPON_2_MEMBER WHERE ORDER_ID = ?").many(
				Coupon2Member.class, order_id);
		if (cmList.size() > 0) {
			if (cmList.get(0).getCoupon_type().equals("1")) {
				CashCoupon cc = D.selectById(CashCoupon.class, cmList.get(0)
						.getCash_coupon_id());
				request.setAttribute("cc", cc);
			}
			if (cmList.get(0).getCoupon_type().equals("2")) {
				Coupon cc = D.selectById(Coupon.class, cmList.get(0)
						.getCash_coupon_id());
				request.setAttribute("cc", cc);
			}
		}

		// 获取广告
		// TaAdvertisement advertise = getAdverti();
		// request.setAttribute("advertise", advertise);

		request.setAttribute("tip", MallService.getTip("2"));

		if ("1".equals(type)) {  //普通订单就需要去进行支付
			if ("1".equals(pay_type))  //付款类型：1在线支付；2货到付款
				return "order/pay";// 前往微信支付页
			return "order/finish";// 前往订单完成页
		}
		return "order/detail";// 前往订单详细页
	}

	/**
	 * 订单列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("list")
	public String orderlist(HttpServletRequest request) {
		log.info("~~~~~ORDER LIST~~~~~");

		List<Order> orderList = D.sql(
				"SELECT * FROM T_O_ORDER WHERE MEMBER_ID = ?").many(
				Order.class, MallService.getMember(request).getMember_id());
		request.setAttribute("orderList", orderList);

		if (orderList.size() > 0) {
			Map<Object, Object> map = new HashMap<Object, Object>();
			for (Order order : orderList) {
				List<OrderDetail> orderDetailList = D.sql(
						"select * from T_O_ORDER_DETAIL where order_id = ?")
						.many(OrderDetail.class, order.getOrder_id());
				if (orderDetailList.size() > 0) {
					orderDetailList.get(0).setProd_img_url(
							MallService.IMGURL + orderDetailList.get(0).getProd_img_url());
					map.put(order.getOrder_id(), orderDetailList.get(0));
				}
			}
			request.setAttribute("map", map);
		}

		return "order/list";// 前往订单列表页
	}

	/**
	 * 支付操作后处理
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("pay")
	public String orderpay(HttpServletRequest request) {
		log.info("~~~~~ORDER PAY~~~~~");

		String order_id = request.getParameter("order_id");
		String pay_id = request.getParameter("pay_id");
		String type = request.getParameter("type");

		boolean boo = false;
		if ("1".equals(type))
			boo = true;

		Order order = D.selectById(Order.class, order_id);
		log.info("~~~~~ BOO ~~~~~" + boo);
		if (boo) {
			TOOrderPay oPay = D.selectById(TOOrderPay.class, pay_id);
			oPay.setStatus("2");
			oPay.setCompleta_time(new Date());
			D.update(oPay);

			order.setPayment_type("1");// 支付方式：微信支付
			order.setPayment_time(new Date());// 支付时间
			order.setOrder_status("2");// 更新订单状态
			order.setLast_update_time(new Date());// 最后修改时间
			D.updateWithoutNull(order);
		} else {
			TOOrderPay oPay = D.selectById(TOOrderPay.class, pay_id);
			oPay.setStatus("3");
			D.update(oPay);
		}

		try {
			AccessToken at = AccessToken.getInstance(MallService.APPID, MallService.APPSECRET);
			log.info("~~~~~ AT ~~~~~" + at.getToken());
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("content", "你刚刚已通过微信支付了订单号：" + order.getOrder_id());
			WeixinUtil.sendMsg("" + MallService.getMember(request).getMember_id(),
					MessageUtil.RESP_MESSAGE_TYPE_TEXT, at.getToken(), map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/order/finish?order_id=" + order_id + "&type=1";// 重定向
	}

	/**
	 * 众筹 开始操作 
	 * @param request
	 * @return
	 */
	@RequestMapping("start")
	public String start(HttpServletRequest request) {
		log.info("~~~~~ORDER RAISE START~~~~~");

		String access_token = request.getAttribute("access_token").toString();
		log.info("access_token " + access_token);
		request.setAttribute("access_token", access_token);

		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Member member = MallService.getMember(request);

		String crowdId = request.getParameter("crowdId");
		TMarketingCrowd crowd = null;
		String sql = "";
		if(StringUtils.isEmpty(crowdId)){
			sql = "SELECT * FROM T_MARKETING_CROWD WHERE START_TIME <= ? AND END_TIME >= ? ORDER BY END_TIME DESC";
			crowd = D.sql(sql).oneOrNull(TMarketingCrowd.class,sdf.format(now), sdf.format(now));
		}else{
			sql = "SELECT * FROM T_MARKETING_CROWD WHERE crowd_id = ?";
			crowd = D.sql(sql).oneOrNull(TMarketingCrowd.class,crowdId);
		}
		
		if (crowd == null)
			return "redirect:/";

		String orderSql = "SELECT O.* FROM T_O_ORDER O LEFT JOIN T_O_ORDER_DETAIL D ON O.ORDER_ID = D.ORDER_ID WHERE O.MEMBER_ID = ? AND O.TYPE = 2 AND D.PROD_ID = ?";
		List<Order> order = D.sql(orderSql).many(Order.class, member.getMember_id(),	crowd.getProd_id());
		if (order.size() > 0)
			return "redirect:/raise/detail?order_id="+ order.get(0).getOrder_id();

		MemberAddress address = D.sql(
				"SELECT * FROM T_M_ADDRESS WHERE MEMBER_ID = ?").oneOrNull(
				MemberAddress.class, MallService.getMember(request).getMember_id());

		request.setAttribute("crowd", crowd);
		request.setAttribute("address", address);
		TTempTemplate template = getTemplate( ); 
		return "order/start_"+template.getTemplate_url();
	}

	/**
	 * 支付操作后通知
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "notice", method = RequestMethod.POST)
	public void ordernotice(HttpServletRequest request,
			HttpServletResponse response) {
		log.info("~~~~~ORDER NOTICE~~~~~");
		try {
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			MessageUtil messageUtil = new MessageUtil();
			String sign = request.getParameter("sign");// 签名
			String trade_mode = request.getParameter("trade_mode");// 交易模式 1
																	// 及时到账
			String trade_state = request.getParameter("trade_state");// 交易状态 0
																		// 成功
			String partner = request.getParameter("partner");// 商户号
			String bank_type = request.getParameter("bank_type");// 付款银行 WX
			String total_fee = request.getParameter("total_fee");// 总金额
			String fee_type = request.getParameter("fee_type");// 1 人民币
			String notify_id = request.getParameter("notify_id");// 通知ID
			String transaction_id = request.getParameter("transaction_id");// 订单号
			String out_trade_no = request.getParameter("out_trade_no");// 商户订单号
			String time_end = request.getParameter("time_end");// 支付完成时间
																// yyyyMMddhhmmss

			log.info("~~~~~ sign ~~~~~" + sign);
			log.info("~~~~~ trade_mode ~~~~~" + trade_mode);
			log.info("~~~~~ trade_state ~~~~~" + trade_state);
			log.info("~~~~~ partner ~~~~~" + partner);
			log.info("~~~~~ bank_type ~~~~~" + bank_type);
			log.info("~~~~~ total_fee ~~~~~" + total_fee);
			log.info("~~~~~ fee_type ~~~~~" + fee_type);
			log.info("~~~~~ notify_id ~~~~~" + notify_id);
			log.info("~~~~~ transaction_id ~~~~~" + transaction_id);
			log.info("~~~~~ out_trade_no ~~~~~" + out_trade_no);
			log.info("~~~~~ time_end ~~~~~" + time_end);

			InputStream is = null;
			String xml = null;
			try {
				is = request.getInputStream();
				BufferedReader br = new BufferedReader(new InputStreamReader(
						is, "UTF-8"));
				// 读取HTTP请求内容
				String buffer = null;
				StringBuffer sb = new StringBuffer();
				while ((buffer = br.readLine()) != null) {
					sb.append(buffer);
				}
				xml = sb.toString();
				System.out.println(xml);
			} catch (IOException e) {
				log.error("error  info");
			}
			boolean result = false;
			try {
				Map<String, String> map = messageUtil.parseXmlString(xml);
				String openId = map.get("OpenId");
				String appId = map.get("AppId");
				String timestamp = Long.toString(new Date().getTime() / 1000);
				DeliverMessage message = new DeliverMessage();

				StringBuffer buff = new StringBuffer();
				buff.append("appid=" + appId);
				buff.append("&appkey="
						+ "Qd0SG67RInaeeLW3DAB0wKLJXAjz93SQAn6DNwlQfnWlvfetbaZzf6D63j2vdeHaW805wmN957OqHUedpz8328spjOhonjUHOo7a6LDZIjhK5TPQNjdbNxsYb6dWeXtU");
				buff.append("&deliver_msg=ok");
				buff.append("&deliver_status=1");
				buff.append("&deliver_timestamp=" + timestamp);
				buff.append("&openid=" + openId);
				buff.append("&out_trade_no=" + out_trade_no);
				buff.append("&transid=" + transaction_id);

				message.setAppid(appId);
				message.setOpenid(openId);
				message.setTransid(transaction_id);
				message.setOut_trade_no(out_trade_no);
				message.setDeliver_timestamp(timestamp);
				message.setDeliver_status("1");
				message.setDeliver_msg("ok");
				message.setApp_signature(SHA1Util.Sha1(buff.toString()));
				message.setApp_method("sha1");

				AccessToken at = AccessToken.getInstance(MallService.APPID, MallService.APPSECRET);
				result = WeixinUtil.delivernotify(messageUtil.toJson(message),
						at.getToken());
				log.info("~~~~~ 发货通知 ~~~~~" + result);

			} catch (Exception e) {
				e.printStackTrace();

			}

			// 响应消息
			PrintWriter out = response.getWriter();
			out.print("success");
			out.close();

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	private TTempTemplate getTemplate( ) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//查询对应的模板
		String sql2 = "SELECT * FROM T_TEMP_TEMPLATE WHERE START_TIME <= ? AND END_TIME >= ?  and status = '1' and type_id = 1  ORDER BY END_TIME DESC";
		List<TTempTemplate> templateList = D.sql(sql2).list(TTempTemplate.class,sdf.format(now), sdf.format(now));
		if(templateList == null || templateList.size() == 0){
			templateList = D.selectAll(TTempTemplate.class);
		}
		TTempTemplate template = null;
		if(templateList != null && templateList.size() >0){
			template = templateList.get(0);
		}
		return template;
	}
}
