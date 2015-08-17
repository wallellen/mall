package com.freelywx.mall.util;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.freelywx.common.model.advertise.AdColoum;
import com.freelywx.common.model.advertise.Advertisement;
import com.freelywx.common.model.coupon.CashCoupon;
import com.freelywx.common.model.coupon.Coupon;
import com.freelywx.common.model.coupon.Coupon2Member;
import com.freelywx.common.model.interal.InteralLog;
import com.freelywx.common.model.interal.InteralRule;
import com.freelywx.common.model.member.Member;
import com.freelywx.common.model.member.MemberRule;
import com.freelywx.common.model.member.TMSignIn;
import com.freelywx.common.model.order.Order;
import com.freelywx.common.model.order.OrderDetail;
import com.freelywx.common.model.order.OrderDetailAttr;
import com.freelywx.common.model.product.TpAttr;
import com.freelywx.common.model.product.TpProduct;
import com.freelywx.common.model.product.TpProductPic;
import com.freelywx.common.model.visit.TVProdVisit;
import com.freelywx.common.util.AESUtil;
import com.freelywx.mall.pojo.CouponValue;
import com.freelywx.mall.pojo.SalesVolume;
import com.freelywx.mall.web.OrderController;
import com.rps.util.ClojureUtil;
import com.rps.util.D;

import net.sf.json.JSONObject;

public class MallService {
	private static final Logger log = LoggerFactory.getLogger(OrderController.class);

	public static String IMGURL =  ClojureUtil.getString ("config/serverPath");
	public static String ADMIN =  ClojureUtil.getString("config/admin");
	public static String APPID =  ClojureUtil.getString("config/appid");
	public static String APPSECRET =  ClojureUtil.getString("config/appsecret");
	public static String PAGESIZE =  ClojureUtil.getString("config/pageSize");

	/**
	 * 时间处理
	 * 
	 * @param t1
	 * @param t2
	 * @return
	 */
	public static String getTime(Date t1, Date t2) {
		long l = t1.getTime() - t2.getTime();
		long d = l / (24 * 60 * 60 * 1000);
		long h = (l / (60 * 60 * 1000) - d * 24);
		long m = ((l / (60 * 1000)) - d * 24 * 60 - h * 60);
		String time = null;
		if (d != 0) {
			time = d + "天前";
		} else if (h != 0) {
			time = h + "小时前";
		} else {
			time = m + "分钟前";
		}
		return time;
	}

	/**
	 * 获取用户
	 * 
	 * @param request
	 * @return
	 */
	public static Member getMember(HttpServletRequest request) {
		log.info("~~~~~GET MEMBER~~~~~");
		Member member = (Member) request.getSession().getAttribute("member");
		log.info("~~~~~ get memberid ~~~~~" + member.getMember_id());
		return member;
	}

	/**
	 * 获取商品图片集合
	 * 
	 * @param prod_id
	 * @return
	 */
	public static List<TpProductPic> getProdPic(int prod_id) {
		log.info("~~~~~GET PROD PIC~~~~~");

		List<TpProductPic> list = D.sql(
				"SELECT * FROM t_p_prod_pic WHERE prod_id = ?").many(
				TpProductPic.class, prod_id);
		for (TpProductPic tpProductPic : list) {
			//tpProductPic.setPic_url(IMGURL + tpProductPic.getUrl());
		}
		return list;
	}

	/**
	 * 获取微信端广告
	 * 
	 * @return
	 */
	public static Advertisement getAdverti() {
		List<AdColoum> taColoumList = D.sql("SELECT * FROM t_a_coloum WHERE type = 1").many(AdColoum.class);
		if (taColoumList.size() > 0) {
			Date date = new Date();
			List<Advertisement> advertiseList = D.sql(
					"SELECT * FROM t_ad_advertise WHERE coloum_id = ? and start_time <= ? and end_time >= ?")
					.many(Advertisement.class,
							taColoumList.get(0).getColoum_id(),date ,date);
			if (advertiseList != null && advertiseList.size() > 0) {
				advertiseList.get(0).setPic_url(
						IMGURL + advertiseList.get(0).getPic_url());
				return advertiseList.get(0);
			}else{
				Advertisement ad = D.sql(" select  * from  t_ad_advertise where coloum_id = ?  order by  ad_id desc limit 0,1 ").oneOrNull(Advertisement.class,taColoumList.get(0).getColoum_id());
				return ad;
			}
		}
		return null;
	}

	/**
	 * 百度定位
	 * 
	 * @param lng
	 * @param lat
	 * @return
	 */
	public static String geolocation(String lng, String lat) {
		String url = "http://api.map.baidu.com/geocoder/v2/?ak=GSNHjZmFo8RGFfblA9ZTcsRr&location=LAT,LNG&output=json";
		url = url.replace("LAT", lat).replace("LNG", lng);
		JSONObject jo = new JSONObject();
		try {
			String result = null;

			HttpClient httpClient = new DefaultHttpClient();
			HttpGet httpGet = new HttpGet(url);

			HttpResponse response = httpClient.execute(httpGet);
			if (response.getStatusLine().getStatusCode() == 200)
				result = EntityUtils.toString(response.getEntity());

			JSONObject jo1 = new JSONObject();
			jo1 = JSONObject.fromObject(result);
			if ("0".equals(jo1.getString("status"))) {
				jo1 = JSONObject.fromObject(jo1.getString("result"));
				String address = jo1.getString("formatted_address");
				jo1 = JSONObject.fromObject(jo1.getString("location"));
				String lng_ = jo1.getString("lng");
				String lat_ = jo1.getString("lat");
				jo.put("lng", lng_);
				jo.put("lat", lat_);
				jo.put("address", address);
			}

		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return jo.toString();
	}

	/**
	 * 上传图片文件
	 * 
	 * @param file
	 * @return
	 */
	public static String uploadFile(MultipartFile file) {
		String uploadPath =  ClojureUtil.getString("config/uploadPath");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();

		String extPath = File.separator + "topicImg" + File.separator
				+ sdf.format(date) + File.separator;
		String savePath = uploadPath + extPath;

		File saveDirFile = new File(savePath);
		if (!saveDirFile.exists()) {
			saveDirFile.mkdirs();
		}

		String fileName = file.getOriginalFilename();
		if (null == fileName || "".equals(fileName)) {
			return "";
		}

		String time = "" + date.getTime();
		while (time.length() < 20) {
			time += "0";
		}

		String fileType = fileName.substring(fileName.lastIndexOf("."));
		String newName = AESUtil.parseByte2HexStr(AESUtil.encrypt(fileName,
				time)) + fileType;

		File newFile = new File(savePath + newName);
		String srcPath = StringUtils.replace(extPath + newName, "\\", "/");
		try {
			file.transferTo(newFile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return srcPath;
	}

	/**
	 * 组装话题信息
	 * 
	 * @param request
	 * @param topic
	 * @return
	 */
	/*public static TTTopic packTopic(HttpServletRequest request, TTTopic topic) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("topic_id", topic.getTopic_id());

		topic.setMember(D.selectById(Member.class, topic.getCreate_user()));
		topic.setReplyList(D.defSql("sql.tribe/listTTR", request, map).many(
				TTReply.class));
		topic.setPraiseList(D.defSql("sql.tribe/listTTP", request, map).many(
				TTPraise.class));

		List<TTTopicImg> topicImgList = D.sql(
				"SELECT * FROM T_T_TOPIC_IMG WHERE TOPIC_ID = ?").many(
				TTTopicImg.class, topic.getTopic_id());
		for (TTTopicImg ttTopicImg : topicImgList) {
			String img_url = ttTopicImg.getImg_url();
			if (!ttTopicImg.getImg_url().startsWith("http://"))
				ttTopicImg.setImg_url(IMGURL + img_url);
		}
		topic.setTopicImgList(topicImgList);

		if ("1".equals(topic.getIs_band())) {
			TpProduct product = D.selectById(TpProduct.class,
					topic.getProd_id());
			topic.setProduct(product);

			int sNum = 0;
			List<Order> oList = D.sql(
					"SELECT * FROM T_O_ORDER WHERE member_id = ?").many(
					Order.class, topic.getCreate_user());
			for (Order order : oList) {
				List<OrderDetail> odList = D.sql(
						"SELECT * FROM T_O_ORDER_DETAIL WHERE order_id = ?")
						.many(OrderDetail.class, order.getOrder_id());
				for (OrderDetail orderDetail : odList) {
					if (orderDetail.getProd_id() - product.getProd_id() == 0)
						sNum++;
				}
			}
			topic.setsNum(sNum);

			List<TpProductPic> prodPicList = D.sql(
					"SELECT * FROM T_P_PRODUCT_PIC WHERE PROD_ID = ?").many(
					TpProductPic.class, topic.getProd_id());
			for (TpProductPic tpProductPic : prodPicList) {
				tpProductPic.setPic_url(IMGURL + tpProductPic.getPic_url());
			}
			topic.setProd_img_url(prodPicList.get(0).getPic_url());

			List<SalesVolume> svList = D
					.sql("SELECT PROD_ID,COUNT(*) count FROM T_O_ORDER_DETAIL WHERE PROD_ID = ?")
					.many(SalesVolume.class, topic.getProd_id());
			topic.setsCount(svList.get(0).getCount());

			List<TTTopic> topicList = D.sql(
					"SELECT * FROM T_T_TOPIC WHERE PROD_ID = ?").many(
					TTTopic.class, topic.getProd_id());
			topic.settCount(topicList.size());

			List<TpAttr> prodAttrList = D.sql("sql.mall/getColor").many(TpAttr.class, topic.getProd_id());
			String[] colorArray = null;
			if (prodAttrList.size() > 0) {
				for (TpAttr tpAttr : prodAttrList) {
					colorArray = tpAttr.getAttrValue().split("[|]");
				}
			}
			topic.setColorArray(colorArray);
		}
		return topic;
	}*/

	/**
	 * 新增商品详情访问记录
	 * 
	 * @param request
	 * @param m
	 * @param o
	 * @param pi
	 * @param is
	 */
	public static void prodVisit(HttpServletRequest request, int m, String o,
			int pi, String is) {
		String sh = request.getParameter("share_id");
		String mi = request.getParameter("merchant_id");
		String ip = request.getHeader("x-forwarded-for");
		String u = request.getServletPath();

		if (ip == null)
			ip = "127.0.0.1";

		TVProdVisit pVisit = new TVProdVisit();
		if (sh != null)
			pVisit.setShare_id(Integer.parseInt(sh));
		if (mi != null)
			pVisit.setMerchant_id(Integer.valueOf(mi));
		pVisit.setMember_id(m);
		pVisit.setOpen_id(o);
		pVisit.setProd_id(pi);
		pVisit.setIp_address(ip);
		pVisit.setIs_bye(is);
		pVisit.setUrl(u);
		pVisit.setVisit_time(new Date());

		D.insert(pVisit);
	}

	/**
	 * 判断是否签到
	 * 
	 * @param member
	 * @return
	 * @throws ParseException
	 */
	public static Map<String, Object> checkSign(Member member) throws ParseException {
		Map<String, Object> map = new HashMap<String, Object>();

		String sql = "SELECT * FROM T_M_SIGN_IN WHERE USER_ID = ? ORDER BY CREATE_TIME DESC";
		List<TMSignIn> signList = D.sql(sql).many(TMSignIn.class,
				member.getMember_id());

		TMSignIn sign = null;
		int status = 0;
		if (signList.size() > 0) {
			sign = signList.get(0);

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -1);
			String time1 = sdf.format(new Date());
			String time2 = sdf.format(sign.getCreate_time());
			String time3 = sdf.format(calendar.getTime());
			Date date1 = sdf.parse(time1);
			Date date2 = sdf.parse(time2);
			long l = date1.getTime() - date2.getTime();
			long d = l / (24 * 60 * 60 * 1000);
			if (d < 1) {
				status = 1;
			} else {
				if (!time2.equals(time3)) {
					sign = null;
				}
			}
		}

		map.put("sign", sign);
		map.put("status", status);
		return map;
	}

	/**
	 * 获取积分总数
	 * 
	 * @param member
	 * @return
	 */
	public static int getInteral(Member member) {
		Date now = new Date();
		String sql = "SELECT * FROM T_I_INTERAL_LOG WHERE MEMBER_ID = ? AND USE_START_TIME <= ? AND USE_END_TIME >= ? ORDER BY CREATE_TIME ASC";
		List<InteralLog> interalList = D.sql(sql).many(InteralLog.class,
				member.getMember_id(), now, now);
		int interal = 0;
		for (InteralLog interalLog : interalList) {
			interal += interalLog.getInteral_rule_value();
		}
		return interal;
	}

	/**
	 * 获取积分集合
	 * 
	 * @param member
	 * @return
	 */
	public static List<InteralLog> getInteral1(Member member) {
		Date now = new Date();
		String sql = "SELECT * FROM T_I_INTERAL_LOG WHERE MEMBER_ID = ? AND USE_START_TIME <= ? AND USE_END_TIME >= ? ORDER BY CREATE_TIME ASC";
		List<InteralLog> interalList = D.sql(sql).many(InteralLog.class,
				member.getMember_id(), now, now);
		return interalList;
	}

	/**
	 * 新增积分
	 * 
	 * @param member
	 * @param type
	 */
	public static void addInteral(Member member, String type) {
		InteralRule rule = D.selectById(InteralRule.class, type);

		InteralLog interal = new InteralLog();
		interal.setMember_id(member.getMember_id());
		interal.setInteral_rule_id(rule.getInteral_rule_id());
		interal.setInteral_change_type("1");
		interal.setInteral_rule_name(rule.getInteral_rule_name());
		interal.setInteral_rule_desc(rule.getInteral_rule_desc());
		interal.setInteral_rule_unit(rule.getInteral_rule_unit());
		interal.setInteral_rule_value(rule.getInteral_rule_value());
		interal.setRule_start_time(rule.getRule_start_time());
		interal.setRule_end_time(rule.getRule_end_time());
		interal.setUse_start_time(rule.getUse_start_time());
		interal.setUse_end_time(rule.getUse_end_time());
		interal.setCreate_time(new Date());

		D.insert(interal);
	}

	/**
	 * 更新用户等级
	 * 
	 * @param member
	 * @return
	 */
	public static int upgrade(Member member) {
		String sql = "SELECT * FROM T_O_ORDER WHERE ORDER_STATUS = 2 AND MEMBER_ID = ?";
		List<Order> orderList = D.sql(sql).many(Order.class,
				member.getMember_id());
		int count = 0;
		for (Order order : orderList) {
			count += order.getPayment_price();
		}
		List<MemberRule> ruleList = D.selectAll(MemberRule.class);
		int level = 0;
		for (MemberRule rule : ruleList) {
			int rValue = rule.getSale_more_than();
			if (count >= rValue) {
				level = Integer.valueOf("" + rule.getRule_id());
			}
		}
		member.setMember_level(level);
		D.update(member);
		return level;
	}

	/**
	 * 获取用户的现金券
	 * 
	 * @param member
	 * @return
	 */
	public static List<CouponValue> getCoupon(Member member, String type) {
		String couponSql = "SELECT * FROM t_c_coupon_2_member WHERE coupon_state = 1 AND member_id = ?";
		List<Coupon2Member> coupon2MemberList = D.sql(couponSql).many(
				Coupon2Member.class, member.getMember_id());
		List<Coupon2Member> couponList = new ArrayList<Coupon2Member>();// 用于存储处理后的优惠券
		for (Coupon2Member coupon2Member : coupon2MemberList) {
			if (coupon2Member.getOrder_id() == null) {
				if (coupon2Member.getCash_coupon_end_time() == null) {
					couponList.add(coupon2Member);
				} else {
					if (coupon2Member.getCash_coupon_end_time().getTime() > new Date()
							.getTime())
						couponList.add(coupon2Member);
				}
			}
		}
		List<CouponValue> cvList = new ArrayList<CouponValue>();
		for (Coupon2Member coupon2Member : couponList) {

			if (coupon2Member.getCoupon_type().equals("1") && type.equals("1")) {
				CouponValue cv = new CouponValue();

				CashCoupon cc = D.selectById(CashCoupon.class,
						coupon2Member.getCash_coupon_id());
				cv.setId(coupon2Member.getCoupon_2_member());
				cv.setName(cc.getCash_coupon_name());
				cv.setValue(cc.getCash_coupon_value());

				cvList.add(cv);
			}

			if (coupon2Member.getCoupon_type().equals("2") && type.equals("2")) {
				CouponValue cv = new CouponValue();

				Coupon cc = D.selectById(Coupon.class,
						coupon2Member.getCash_coupon_id());
				cv.setId(coupon2Member.getCoupon_2_member());
				cv.setName(cc.getCoupon_name());
				cv.setValue(cc.getCoupon_value());

				cvList.add(cv);
			}

		}
		return cvList;
	}

	/**
	 * 获取现金券的金额
	 * 
	 * @param c2m
	 * @return
	 */
	public static int getCouponPrice(Coupon2Member c2m) {
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
				CashCoupon cashCoupon = D.selectById(CashCoupon.class,
						c2m.getCash_coupon_id());
				return cashCoupon.getCash_coupon_value() ;
			} else {
				Coupon coupon = D.selectById(Coupon.class,
						c2m.getCash_coupon_id());
				return  coupon.getCoupon_value() ;
			}
		}
		return 0;
	}

	/**
	 * 封装订单
	 * 
	 * @param member
	 * @param coupon
	 * @param prod_id
	 * @param type
	 * @param pay_type
	 * @param count
	 * @param color
	 * @return
	 */
	public static int packOrder(Member member, String coupon, String prod_id,
			String type, String pay_type, Integer count, String color,int integral) {

		int couponPrice = 0;// 优惠金额
		Coupon2Member c2m = new Coupon2Member();
		if (!coupon.equals("0")) {
			c2m = D.selectById(Coupon2Member.class, coupon);
			couponPrice = getCouponPrice(c2m);
		}

		TpProduct tpProduct = D.selectById(TpProduct.class, prod_id);
		int totalPrice = tpProduct.getSale_price() * count;// 商品价格*数量=总金额

		Order order = new Order();
		if (type != null){
			order.setOrder_type(type);
		}
			
		order.setOrder_type(pay_type);// 订单类型
		order.setMember_id(member.getMember_id());// 用户编号
		//order.setPay_member_id(member.getMember_id());
		if (member.getMember_level()  > 0){
			member.setMember_level(0);
		}
		order.setLevel(Integer.valueOf(member.getMember_level()));// 用户等级
		order.setType_amount(1);// 种类数量
		order.setProd_amount(count);// 商品数量
		order.setRetail_price(tpProduct.getRetail_price() * count);
		order.setCoupon_price(couponPrice);	// 优惠券金额
		order.setDiscount_price(0);			//折扣金额
		order.setAmount_price(totalPrice);	// 总商品金额
		
		int freighPrice = 0;// 运费
		if (tpProduct.getFreigh_price() != null){
			freighPrice = tpProduct.getFreigh_price();
		}
			
		int payAmount = totalPrice + freighPrice -couponPrice - integral;
		order.setTransit_price(freighPrice);// 运费
		order.setPayment_price(payAmount);// 支付金额
		order.setPayment_type(pay_type);// 支付类型
		order.setCreate_time(new Date());
		order.setOrder_status("1");
		order.setUpdate_time(new Date());

		int order_id = D.insertAndReturnInteger(order);

		if (!coupon.equals("0")) {
			c2m.setOrder_id(order_id);
			D.update(c2m);
		}

		OrderDetail orderDetail = new OrderDetail();
		orderDetail.setOrder_id(order_id);
	//	orderDetail.setDetail_index(1);
		orderDetail.setProd_id(tpProduct.getProd_id());
		orderDetail.setProd_code(tpProduct.getProd_code());
		orderDetail.setProd_name(tpProduct.getProd_name());
		orderDetail.setAmount(count);
		orderDetail.setPrice(tpProduct.getSale_price());
		orderDetail.setDiscount_price(0);
		orderDetail.setTransit_price(tpProduct.getFreigh_price());
		List<TpProductPic> prodPicList = D.sql(
				"SELECT * FROM t_p_prod_pic WHERE prod_id = ?").many(
				TpProductPic.class, tpProduct.getProd_id());
		orderDetail.setProd_img_url(prodPicList.get(0).getUrl());

		int detailId = D.insertAndReturnInteger(orderDetail);

		if (color != null) {
			OrderDetailAttr orderDetailAttr = new OrderDetailAttr();
			orderDetailAttr.setDetail_id(detailId);
			orderDetailAttr.setProd_id(tpProduct.getProd_id());
			orderDetailAttr.setProd_attr("颜色");
			orderDetailAttr.setProd_attr_value(color);

			D.insertWithoutNull(orderDetailAttr);
		}
		return order_id;
	}

}
