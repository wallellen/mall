package com.freelywx.mall.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.mall.util.MallService;
import com.mowei.model.marketing.TMarketingConfig;
import com.mowei.model.marketing.TMarketingCrowd;
import com.mowei.model.marketing.TMarketingCrowdPic;
import com.mowei.model.marketing.TTempTemplate;
import com.mowei.model.member.Member;
import com.mowei.model.order.Order;
import com.mowei.model.order.OrderDetail;
import com.mowei.model.order.TOOrderPay;
import com.mowei.model.product.TpProduct;
import com.mowei.model.product.TpProductPic;
import com.mowei.model.store.TPMerchant;
import com.rps.util.D;

@Controller
@Scope("session")
@RequestMapping("raise")
public class RaiseController  {
	private static final Logger log = LoggerFactory.getLogger(RaiseController.class);

	/**
	 * 首页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("")
	public String index(HttpServletRequest request) {
		log.info("~~~~~RAISE INDEX~~~~~");

		request.setAttribute("type", request.getParameter("type"));

		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String sql = "SELECT t.*,m.prod_name FROM T_MARKETING_CROWD t left join T_P_PRODUCT m on t.prod_id = m.prod_id where  t.START_TIME <= ? AND t.END_TIME >= ? ORDER BY t.END_TIME DESC";
		TMarketingCrowd crowd = D.sql(sql).oneOrNull(TMarketingCrowd.class,
				sdf.format(now), sdf.format(now));

		if (crowd == null)
			return "redirect:/";

		String sql1 = "SELECT * FROM T_MARKETING_CROWD_PIC WHERE CROWD_ID = ? ORDER BY SORT ASC";
		List<TMarketingCrowdPic> picList = D.sql(sql1).many(
				TMarketingCrowdPic.class, crowd.getCrowd_id());
		for (TMarketingCrowdPic tMarketingCrowdPic : picList) {
			tMarketingCrowdPic.setUrl(MallService.IMGURL + tMarketingCrowdPic.getUrl());
		}
		request.setAttribute("crowd", crowd);
		request.setAttribute("picList", picList);
		
		TTempTemplate template = getTemplate( ); 
		request.getSession().setAttribute("template", template.getTemplate_url());
		return "raise/index_"+ template.getTemplate_url();
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

	/**
	 * 详情
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("detail")
	public String detail(HttpServletRequest request) {
		log.info("~~~~~RAISE DETAIL~~~~~");

		String order_id = request.getParameter("order_id");
		String share = request.getParameter("share");

		Order order = D.selectById(Order.class, order_id);
		if (order == null || !"2".equals(order.getType()))
			return "redirect:/raise/";
		String sqlOd = "SELECT D.* FROM T_O_ORDER_DETAIL D LEFT JOIN T_O_ORDER O ON D.ORDER_ID = O.ORDER_ID WHERE O.ORDER_ID = ?";
		OrderDetail oDetail = D.sql(sqlOd).oneOrNull(OrderDetail.class,	order.getOrder_id());
		if (oDetail == null)
			return "redirect:/raise/";

		Member member = MallService.getMember(request);
		if (StringUtils.isEmpty(share)) {
			if (member.getMember_id() - order.getMember_id() != 0)
				return "redirect:/raise/";
		} else {
			Member share_member = D.selectById(Member.class, share);
			request.setAttribute("share_member", share_member);
		}
		
		Member orderMem = D.selectById(Member.class, order.getMember_id());
		request.setAttribute("orderMem", orderMem);
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String sqlC = "SELECT * FROM T_MARKETING_CROWD WHERE PROD_ID = ?  ";
		TMarketingCrowd crowd = D.sql(sqlC).oneOrNull(TMarketingCrowd.class,oDetail.getProd_id() );
		if (crowd == null)
			return "redirect:/raise/";

		String sqlOp = "SELECT P.*,M.MEMBER_IMG FROM T_O_ORDER_PAY P LEFT JOIN T_M_MEMBER M ON P.MEMBER_ID = M.MEMBER_ID  WHERE ORDER_ID = ? AND P.STATUS = 2";
		List<TOOrderPay> orderPayList = D.sql(sqlOp).many(TOOrderPay.class,order_id);
		for(TOOrderPay orderPay:orderPayList){
			Order o = D.selectById(Order.class, orderPay.getOrder_id());
			orderPay.setOrder(o);
		}
		request.setAttribute("orderPayList", orderPayList);

		TpProduct prod = D.selectById(TpProduct.class, oDetail.getProd_id());
		request.setAttribute("prod", prod);
		request.setAttribute("order", order);

		String ext3 = MallService.IMGURL + crowd.getExt3();
		crowd.setExt3(ext3);
		request.setAttribute("crowd", crowd);
		//request.setAttribute("picurl", picList.get(0).getUrl());
		TTempTemplate template = getTemplate( ); 
		return "raise/detail_"+ template.getTemplate_url();
	}
	

	/**
	 * 赞助
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("support")
	public String support(HttpServletRequest request) {
		log.info("~~~~~RAISE SUPPORT~~~~~");

		String share_member_id = request.getParameter("share_member_id");
		String order_id = request.getParameter("order_id");
		String pay_type = request.getParameter("pay_type");//1:赞助；2：补齐
		Long needPayAmount = 0l;
		Order order = D.selectById(Order.class, order_id);
		List<TOOrderPay> payList = D.sql(
				"select * from T_O_ORDER_PAY where order_id=? and status=?")
				.many(TOOrderPay.class, order_id, "2");
		for (TOOrderPay toOrderPay : payList) {
			if (null == toOrderPay.getPay_amount())
				toOrderPay.setPay_amount(0l);
			needPayAmount += toOrderPay.getPay_amount();
		}

		if (null == order.getReserve_amount())
			order.setReserve_amount(0l);

		needPayAmount = order.getPayment_price() - needPayAmount
				- order.getReserve_amount();
		request.setAttribute("needPayAmount", needPayAmount);
		request.setAttribute("share_member_id", share_member_id);
		request.setAttribute("order", order);

		OrderDetail orderDetail = D.sql(
				"SELECT * FROM T_O_ORDER_DETAIL WHERE ORDER_ID = ?").one(
				OrderDetail.class, order.getOrder_id());

		String sqlC = "SELECT * FROM T_MARKETING_CROWD WHERE PROD_ID = ?  ";
		TMarketingCrowd crowd = D.sql(sqlC).oneOrNull(TMarketingCrowd.class,orderDetail.getProd_id() );

		Member member = MallService.getMember(request);
		request.setAttribute("member", member);
		request.setAttribute("crowd", crowd);
		request.setAttribute("orderDetail", orderDetail);
		request.setAttribute("pay_type", pay_type);
		request.setAttribute("IP", request.getHeader("x-forwarded-for"));
		TTempTemplate template = getTemplate( ); 
		return "order/support_"+template.getTemplate_url();
	}

	@RequestMapping("join")
	public String join(HttpServletRequest request) {
		log.info("~~~~~RAISE JOIN~~~~~");

		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String sql = "SELECT * FROM T_MARKETING_CONFIG WHERE STATUS = 1 AND START_TIME <= ? AND END_TIME >= ?";
		List<TMarketingConfig> list = D.sql(sql).many(TMarketingConfig.class,
				sdf.format(now), sdf.format(now));
		if (list.size() > 0)
			request.setAttribute("config", list.get(0));
		TTempTemplate template = getTemplate( ); 
		return "raise/join_" + template.getTemplate_url();
	}

	@RequestMapping("addMerchant")
	@ResponseBody
	public Map<String, String> addMerchant(HttpServletRequest request) {
		log.info("~~~~~ADD MERCHANT~~~~~");

		Map<String, String> map = new HashMap<String, String>();
		try {
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");

			TPMerchant merchant = new TPMerchant();
			merchant.setMerchant_name(name);
			merchant.setPhone(phone);
			merchant.setEmail(email);
			merchant.setStatus("1");
			D.insert(merchant);

			map.put("result", "0");
		} catch (Exception e) {
			log.error("ADD MERCHANR ERROR", e);
			map.put("result", "1");
		}

		return map;
	}

	@RequestMapping("pay")
	@ResponseBody
	public Map<String, String> pay(HttpServletRequest request) {
		log.info("~~~~~RAISE PAY~~~~~");

		Map<String, String> map = new HashMap<String, String>();
		try {
			Member member = MallService.getMember(request);
			String order_id = request.getParameter("order_id");
			String payFee = request.getParameter("payFee");
			String share_member_id = request.getParameter("share_member_id");
			// String needPayAmount = request.getParameter("needPayAmount");
			String message = request.getParameter("message");

			Order order = D.selectById(Order.class, order_id);

			if (null == share_member_id || "".equals(share_member_id)
					|| (member.getMember_id() + "").equals(share_member_id)) { // 补齐剩余资金
				TOOrderPay orderPay = D
						.sql("SELECT * FROM T_O_ORDER_PAY WHERE ORDER_ID=? AND MEMBER_ID=?")
						.one(TOOrderPay.class, order_id, member.getMember_id());
				orderPay.setPay_amount(Long.parseLong(payFee));
				orderPay.setMessage(message);
				D.update(orderPay);
				map.put("orderPay_id", orderPay.getId() + "");
				map.put("pay_amount", orderPay.getPay_amount() + "");
			} else {
				TOOrderPay orderPay = new TOOrderPay();
				orderPay.setOrder_id(Long.parseLong(order_id));
				orderPay.setMember_id(member.getMember_id());
				orderPay.setMember_w_id(member.getMember_w_id());
				orderPay.setMember_name(member.getMember_name());
				orderPay.setPay_amount(Long.parseLong(payFee));
				orderPay.setPay_time(new Date());
				orderPay.setStatus("1");

				orderPay.setMessage(message);
				orderPay.setPay_amount(Long.parseLong(payFee));
				Long orderPay_id = D.insertAndReturnLong(orderPay);
				map.put("orderPay_id", orderPay_id + "");
				map.put("pay_amount", payFee);
			}
			if (null == order.getReserve_amount()) {
				order.setReserve_amount(Long.parseLong(payFee));
			} else {
				order.setReserve_amount(order.getReserve_amount()
						+ Long.parseLong(payFee));
			}
			D.update(order);

			map.put("result", "0");
		} catch (Exception e) {
			log.error("RAISE PAY ERROR", e);
			map.put("result", "1");
		}

		return map;
	}

	@RequestMapping("/checkAmount")
	@ResponseBody
	public boolean checkAmount(HttpServletRequest request) {
		log.info("~~~~~CHECK AMOUNT~~~~~");
		String order_id = request.getParameter("order_id");
		Long needPayAmount = 0l;
		Order order = D.selectById(Order.class, order_id);
		List<TOOrderPay> payList = D.sql(
				"SELECT * FROM T_O_ORDER_PAY WHERE ORDER_ID=? AND STATUS=?")
				.many(TOOrderPay.class, order_id, "2");
		for (TOOrderPay toOrderPay : payList) {
			if (null == toOrderPay.getPay_amount()) {
				toOrderPay.setPay_amount(0l);
			}
			needPayAmount += toOrderPay.getPay_amount();
		}

		if (null == order.getReserve_amount())
			order.setReserve_amount(0l);
		if (order.getPayment_price() <= needPayAmount + order.getReserve_amount()) {
			return true;
		}
		needPayAmount = order.getPayment_price() - needPayAmount - order.getReserve_amount();
		return false;
	}

	@RequestMapping("/operatePayerror")
	public String operatePayerror(HttpServletRequest request) {
		log.info("~~~~~OPERATE PAY ERROR~~~~~");

		String orderPay_id = request.getParameter("orderPay_id");

		TOOrderPay orderPay = D.selectById(TOOrderPay.class, orderPay_id);
		orderPay.setStatus("3");
		D.update(orderPay);

		Order order = D.selectById(Order.class, orderPay.getOrder_id());

		if (null == orderPay.getPay_amount())
			orderPay.setPay_amount(0l);
		if (null == order.getReserve_amount())
			order.setReserve_amount(0l);
		order.setReserve_amount(order.getReserve_amount()
				- orderPay.getPay_amount());
		D.update(order);

		return "redirect:/raise";
	}

	@RequestMapping("my")
	public String my(HttpServletRequest request) {
		
		Member member = MallService.getMember(request);
		//查询用户的所有的众筹信息
		String sql = "SELECT O.* FROM T_O_ORDER O where O.TYPE = 2    AND O.MEMBER_ID = ?";
		List<Order> orderList = D.sql(sql).list(Order.class, member.getMember_id());
		if(orderList !=null && orderList.size() > 0){
			request.setAttribute("orderFlag", true);
			
			Order order = orderList.get(0);
			String prodSql = "select * from T_P_PRODUCT  t right JOIN T_O_ORDER_DETAIL  m on t.PROD_ID = m.PROD_ID  where m.ORDER_ID = " + order.getOrder_id();
			List<TpProduct> prodList = D.sql(prodSql).list(TpProduct.class);
			order.setProdList(prodList);
			request.setAttribute("order", order);
			
		}
		request.setAttribute("server",  MallService.IMGURL);
		TTempTemplate template = getTemplate( ); 
		return "raise/my_"+template.getTemplate_url();
	}
	
	@RequestMapping("getCrowdOrder")
	@ResponseBody
	public List<Order> getCrowdOrder(HttpServletRequest request) {
		Member member = MallService.getMember(request);
		String sql = "SELECT O.* FROM T_O_ORDER O where O.TYPE = 2  AND O.MEMBER_ID = ?";
		List<Order> orderList = D.sql(sql).list(Order.class, member.getMember_id());
		for(Order order : orderList){
			String prodSql = "select * from T_P_PRODUCT  t right JOIN T_O_ORDER_DETAIL  m on t.PROD_ID = m.PROD_ID  where m.ORDER_ID = " + order.getOrder_id();
			List<TpProduct> prodList = D.sql(prodSql).list(TpProduct.class);
			order.setProdList(prodList);
		}
		return orderList;
	}
	
	@RequestMapping("getCrowdPay")
	@ResponseBody
	public List<TOOrderPay> getCrowdPay(HttpServletRequest request) {
		Member member = MallService.getMember(request);
		//Member member = D.selectById(Member.class, 61);
		String sql = "select  ORDER_ID, MEMBER_ID,sum( PAY_AMOUNT) as PAY_AMOUNT from ( SELECT P.* FROM T_O_ORDER_PAY P  LEFT JOIN T_O_ORDER O ON P.ORDER_ID = O.ORDER_ID"
		        +" WHERE O.TYPE = 2 AND P.MEMBER_ID = ? AND P.MEMBER_ID != O.MEMBER_ID AND P.STATUS = '2')  t group by ORDER_ID ,member_id ";
		
		
		List<TOOrderPay> payList = D.sql(sql).many(TOOrderPay.class,member.getMember_id());

		for (TOOrderPay op : payList) {
			Order o = D.selectById(Order.class, op.getOrder_id());
			String prodSql = "select * from T_P_PRODUCT  t right JOIN T_O_ORDER_DETAIL  m on t.PROD_ID = m.PROD_ID  where m.ORDER_ID = " + o.getOrder_id();
			List<TpProduct> prodList = D.sql(prodSql).list(TpProduct.class);
			for(TpProduct prod : prodList){
				List<TpProductPic> picList  = D.sql("select * from T_P_PRODUCT_PIC where prod_id = ? ").many(TpProductPic.class, prod.getProd_id());
				prod.setPicList(picList);
			}
			o.setProdList(prodList);
			op.setOrder(o);
			op.setMember(D.selectById(Member.class, o.getMember_id()));
		}
		
		return payList;
	}

	@RequestMapping("test")
	public String test(HttpServletRequest request) {
		log.info("~~~~~RAISE INDEX~~~~~");

		request.setAttribute("type", request.getParameter("type"));

		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String sql = "SELECT * FROM T_MARKETING_CROWD WHERE START_TIME <= ? AND END_TIME >= ? ORDER BY END_TIME DESC";
		TMarketingCrowd crowd = D.sql(sql).oneOrNull(TMarketingCrowd.class,
				sdf.format(now), sdf.format(now));

		if (crowd == null)
			return "redirect:/";

		String sql1 = "SELECT * FROM T_MARKETING_CROWD_PIC WHERE CROWD_ID = ? ORDER BY SORT ASC";
		List<TMarketingCrowdPic> picList = D.sql(sql1).many(
				TMarketingCrowdPic.class, crowd.getCrowd_id());
		for (TMarketingCrowdPic tMarketingCrowdPic : picList) {
			tMarketingCrowdPic.setUrl(MallService.IMGURL + tMarketingCrowdPic.getUrl());
		}
		request.setAttribute("crowd", crowd);
		request.setAttribute("picList", picList);
		
		//查询对应的模板
		TTempTemplate template = getTemplate( ); 
		return "raise/index_"+ template.getTemplate_url();
	}
	
	/**
	 * 详情
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("test1")
	public String test1(HttpServletRequest request) {
		log.info("~~~~~RAISE DETAIL~~~~~");

		String order_id = request.getParameter("order_id");
		String share = request.getParameter("share");

		Order order = D.selectById(Order.class, 310);
		if (order == null || !"2".equals(order.getType()))
			return "redirect:/raise/";
		String sqlOd = "SELECT D.* FROM T_O_ORDER_DETAIL D LEFT JOIN T_O_ORDER O ON D.ORDER_ID = O.ORDER_ID WHERE O.ORDER_ID = ?";
		OrderDetail oDetail = D.sql(sqlOd).oneOrNull(OrderDetail.class,	order.getOrder_id());
		if (oDetail == null)
			return "redirect:/raise/";

		Member member = D.selectById(Member.class, 61);
		if (StringUtils.isEmpty(share)) {
			if (member.getMember_id() - order.getMember_id() != 0)
				return "redirect:/raise/";
		} else {
			Member share_member = D.selectById(Member.class, share);
			request.setAttribute("share_member", share_member);
		}
		
		Member orderMem = D.selectById(Member.class, order.getMember_id());
		request.setAttribute("orderMem", orderMem);
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String sqlC = "SELECT * FROM T_MARKETING_CROWD WHERE PROD_ID = ?  ";
		TMarketingCrowd crowd = D.sql(sqlC).oneOrNull(TMarketingCrowd.class,oDetail.getProd_id() );
		if (crowd == null)
			return "redirect:/raise/";

		String sqlOp = "SELECT P.*,M.MEMBER_IMG FROM T_O_ORDER_PAY P LEFT JOIN T_M_MEMBER M ON P.MEMBER_ID = M.MEMBER_ID  WHERE ORDER_ID = ? AND P.STATUS = 2";
		List<TOOrderPay> orderPayList = D.sql(sqlOp).many(TOOrderPay.class,order_id);
		for(TOOrderPay orderPay:orderPayList){
			Order o = D.selectById(Order.class, orderPay.getOrder_id());
			orderPay.setOrder(o);
		}
		request.setAttribute("orderPayList", orderPayList);

		TpProduct prod = D.selectById(TpProduct.class, oDetail.getProd_id());
		request.setAttribute("prod", prod);
		request.setAttribute("order", order);

		/*String sql1 = "SELECT * FROM T_MARKETING_CROWD_PIC WHERE CROWD_ID = ? ORDER BY SORT ASC";
		List<TMarketingCrowdPic> picList = D.sql(sql1).many(
				TMarketingCrowdPic.class, crowd.getCrowd_id());
		for (TMarketingCrowdPic tMarketingCrowdPic : picList) {
			tMarketingCrowdPic.setUrl(IMGURL + tMarketingCrowdPic.getUrl());
		}*/
		String ext3 = MallService.IMGURL + crowd.getExt3();
		crowd.setExt3(ext3);
		request.setAttribute("crowd", crowd);
		//request.setAttribute("picurl", picList.get(0).getUrl());
		String url = (String) request.getSession().getAttribute("template");
		return "raise/detail_2";
	}
	
	
	@RequestMapping("test3")
	public String supporttest(HttpServletRequest request) {
		log.info("~~~~~RAISE SUPPORT~~~~~");

		String share_member_id = request.getParameter("share_member_id");
		int order_id = 301;
		String pay_type = "1";//1:赞助；2：补齐
		Long needPayAmount = 0L;
		Order order = D.selectById(Order.class, order_id);
		List<TOOrderPay> payList = D.sql(
				"select * from T_O_ORDER_PAY where order_id=? and status=?")
				.many(TOOrderPay.class, order_id, "2");
		for (TOOrderPay toOrderPay : payList) {
			if (null == toOrderPay.getPay_amount())
				toOrderPay.setPay_amount(0L);
			needPayAmount += toOrderPay.getPay_amount();
		}

		if (null == order.getReserve_amount())
			order.setReserve_amount(0L);

		needPayAmount = order.getPayment_price() - needPayAmount
				- order.getReserve_amount();
		request.setAttribute("needPayAmount", needPayAmount);
		request.setAttribute("share_member_id", share_member_id);
		request.setAttribute("order", order);

		OrderDetail orderDetail = D.sql(
				"SELECT * FROM T_O_ORDER_DETAIL WHERE ORDER_ID = ?").one(
				OrderDetail.class, order.getOrder_id());

		String sqlC = "SELECT * FROM T_MARKETING_CROWD WHERE PROD_ID = ?  ";
		TMarketingCrowd crowd = D.sql(sqlC).oneOrNull(TMarketingCrowd.class,orderDetail.getProd_id() );

		Member member = MallService.getMember(request);
		request.setAttribute("member", member);
		request.setAttribute("crowd", crowd);
		request.setAttribute("orderDetail", orderDetail);
		request.setAttribute("pay_type", pay_type);
		request.setAttribute("IP", request.getHeader("x-forwarded-for"));
		String url = (String) request.getSession().getAttribute("template");
		return "order/support_2" ;
	}
	
	@RequestMapping("mytest")
	public String mytest(HttpServletRequest request) {
		
		Member member = D.selectById(Member.class, 61);
		//查询用户的所有的众筹信息
		String sql = "SELECT O.* FROM T_O_ORDER O where O.TYPE = 2    AND O.MEMBER_ID = ?";
		List<Order> orderList = D.sql(sql).list(Order.class, member.getMember_id());
		if(orderList !=null && orderList.size() > 0){
			request.setAttribute("orderFlag", true);
			request.setAttribute("order", orderList.get(0));
			
		}
		request.setAttribute("server",  MallService.IMGURL);
		return "raise/my_2" ;
	}
	
	@RequestMapping("stest")
	public String stest(HttpServletRequest request) {
		log.info("~~~~~RAISE SUPPORT~~~~~");

		String share_member_id = request.getParameter("share_member_id");
		String order_id = "310";
		String pay_type = "1";//1:赞助；2：补齐
		Long needPayAmount = 0L;
		Order order = D.selectById(Order.class, 310);
		List<TOOrderPay> payList = D.sql(
				"select * from T_O_ORDER_PAY where order_id=? and status=?")
				.many(TOOrderPay.class, order_id, "2");
		for (TOOrderPay toOrderPay : payList) {
			if (null == toOrderPay.getPay_amount())
				toOrderPay.setPay_amount(0L);
			needPayAmount += toOrderPay.getPay_amount();
		}

		if (null == order.getReserve_amount())
			order.setReserve_amount(0L);

		needPayAmount = order.getPayment_price() - needPayAmount
				- order.getReserve_amount();
		request.setAttribute("needPayAmount", needPayAmount);
		request.setAttribute("share_member_id", share_member_id);
		request.setAttribute("order", order);

		OrderDetail orderDetail = D.sql(
				"SELECT * FROM T_O_ORDER_DETAIL WHERE ORDER_ID = ?").one(
				OrderDetail.class, order.getOrder_id());

		String sqlC = "SELECT * FROM T_MARKETING_CROWD WHERE PROD_ID = ?  ";
		TMarketingCrowd crowd = D.sql(sqlC).oneOrNull(TMarketingCrowd.class,orderDetail.getProd_id() );

		Member member = D.selectById(Member.class, 61);
		request.setAttribute("member", member);
		request.setAttribute("crowd", crowd);
		request.setAttribute("orderDetail", orderDetail);
		request.setAttribute("pay_type", pay_type);
		request.setAttribute("IP", request.getHeader("x-forwarded-for"));
		TTempTemplate template = getTemplate( ); 
		return "order/support_"+template.getTemplate_url();
	}
}
