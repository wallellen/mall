package com.freelywx.mall.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.freelywx.mall.pojo.SalesVolume;
import com.freelywx.mall.util.MallService;
import com.freelywx.mall.util.PageUtil;
import com.mowei.model.member.Member;
import com.mowei.model.order.Order;
import com.mowei.model.order.OrderDetail;
import com.mowei.model.product.TpAttr;
import com.mowei.model.product.TpProduct;
import com.mowei.model.product.TpProductPic;
import com.mowei.model.tribe.TTEmoji;
import com.mowei.model.tribe.TTPraise;
import com.mowei.model.tribe.TTReply;
import com.mowei.model.tribe.TTTopic;
import com.mowei.model.tribe.TTTopicImg;
import com.mowei.util.PageModel;
import com.rps.util.ClojureUtil;
import com.rps.util.D;
import com.rps.util.dao.Page;
import com.rps.util.dao.SqlAndParams;

@Controller
@Scope("session")
@RequestMapping("tribe")
public class TribeController {
	private static final Logger log = LoggerFactory
			.getLogger(TribeController.class);

	/**
	 * 社区首页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("")
	public String index(HttpServletRequest request) {
		log.info("~~~~~TRIBE INDEX~~~~~");

		return "tribe/index";
	}

	/**
	 * 话题分页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("pageTTT")
	public String pageTTT(HttpServletRequest request) {
		log.info("~~~~~TRIBE PAGETTT~~~~~");

		String pageIndex = request.getParameter("pageIndex");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("pageSize", MallService.PAGESIZE);
		map.put("pageIndex", pageIndex);
		
		PageModel page = PageUtil.getPageModel(TTTopic.class, "sql.tribe/pageTTT", request, map);
		//List<TpProduct> productList = (List<TpProduct>) page.getData();

		Map<Object, Object> dateMap = new HashMap<Object, Object>();
		List<TTTopic> topicList = (List<TTTopic>) page.getData();
		for (TTTopic ttTopic : topicList) {
			ttTopic.setMember(D.selectById(Member.class,
					ttTopic.getCreate_user()));

			HashMap<String, Object> map1 = new HashMap<String, Object>();
			map1.put("topic_id", ttTopic.getTopic_id());

			ttTopic.setReplyList(D.defSql("sql.tribe/listTTR", request, map1)
					.many(TTReply.class));
			ttTopic.setPraiseList(D.defSql("sql.tribe/listTTP", request, map1)
					.many(TTPraise.class));

			List<TTTopicImg> topicImgList = D.sql(
					"SELECT * FROM T_T_TOPIC_IMG WHERE TOPIC_ID = ?").many(
					TTTopicImg.class, ttTopic.getTopic_id());
			for (TTTopicImg ttTopicImg : topicImgList) {
				String img_url = ttTopicImg.getImg_url();
				if (!ttTopicImg.getImg_url().startsWith("http://"))
					ttTopicImg.setImg_url(MallService.IMGURL + img_url);
			}
			ttTopic.setTopicImgList(topicImgList);

			dateMap.put(ttTopic.getTopic_id(),
					MallService.getTime(new Date(), ttTopic.getCreate_time()));

			// if ("1".equals(ttTopic.getIs_band())) {
			// ttTopic.setProd_img_url(getProdPic((long) ttTopic.getProd_id())
			// .get(0).getPic_url());
			// }

		}

		request.setAttribute("topicList", topicList);
		request.setAttribute("pageIndex", pageIndex);
		request.setAttribute("pageTotal", page.getTotal());
		request.setAttribute("dateMap", dateMap);

		return "tribe/pageTTT";
	}

	/**
	 * 话题详情
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("get")
	public String get(HttpServletRequest request) {
		log.info("~~~~~TRIBE GET~~~~~");

		String id = request.getParameter("id");

		TTTopic topic = D.selectById(TTTopic.class, id);
		topic = MallService.packTopic(request, topic);

		List<TTEmoji> emoji = D.selectAll(TTEmoji.class);

		request.setAttribute("emoji", emoji);
		request.setAttribute("topic", topic);

		return "tribe/get";
	}

	/**
	 * 回复列表分页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("pageTTR")
	public String pageTTR(HttpServletRequest request) {
		log.info("~~~~~TRIBE PAGETTR~~~~~");

		String pageIndex = request.getParameter("pageIndex");
		String type = request.getParameter("type");

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageSize", MallService.PAGESIZE);
		map.put("pageIndex", pageIndex);

		TTTopic topic = new TTTopic();
		if (type.equals("pj")) {
			String prod_id = request.getParameter("prod_id");
			topic = D
					.sql("SELECT * FROM T_T_TOPIC WHERE topic_type = 1 AND prod_id = ?")
					.one(TTTopic.class, prod_id);
			if (topic != null)
				map.put("topic_id", topic.getTopic_id());
		} else {
			String id = request.getParameter("topic_id");
			topic = D.selectById(TTTopic.class, id);
		}

		int pageI = -1;
		int pageT = 0;
		int pageI1 = -1;
		int pageT1 = 0;
		if (topic != null) {
			request.setAttribute("topic", topic);

			SqlAndParams sqlAndParams = (SqlAndParams) ClojureUtil.getFn(
					"sql.tribe/pageTTR").invoke(request, map);
			Page<TTReply> page = D.sqlAndParams(sqlAndParams).pageSqlAndParams(
					TTReply.class);

			List<TTReply> replyList = page.getData();
			Pattern pattern = Pattern
					.compile("\\[([\\u4E00-\\u9FA5]|[\\uFE30-\\uFFA0])+\\]");
			for (TTReply ttReply : replyList) {
				ttReply.setMember(D.selectById(Member.class,
						ttReply.getReply_user()));

				String cont = ttReply.getReply_cont();
				Matcher m = pattern.matcher(cont);
				List<String> list = new ArrayList<String>();
				while (m.find()) {
					list.add(m.group());
				}

				for (String string : list) {
					String[] arr = string.replaceAll("\\[", "").split("]");
					for (String string2 : arr) {
						string2 = string2.trim();
						TTEmoji emoji = D.sql(
								"SELECT * FROM T_T_EMOJI WHERE TEXT = ?").one(
								TTEmoji.class, string2);
						if (emoji != null)
							cont = cont.replace(
									"[" + string2 + "]",
									"<img title=" + emoji.getText() + " alt="
											+ emoji.getText() + " src="
											+ emoji.getLink()
											+ " width='30' height='30'>");
					}
				}
				ttReply.setReply_cont(cont);
			}

			request.setAttribute("replyList", replyList);

			if (type.equals("pj")) {
				pageI1 = page.getPageIndex();
				pageT1 = page.getPageTotal();
			} else {
				pageI = page.getPageIndex();
				pageT = page.getPageTotal();
			}
		}

		request.setAttribute("pageIndex1", pageI1);
		request.setAttribute("pageTotal1", pageT1);
		request.setAttribute("pageIndex", pageI);
		request.setAttribute("pageTotal", pageT);
		return "tribe/pageTTR";
	}

	/**
	 * 发表页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("add")
	public String add(HttpServletRequest request) {
		log.info("~~~~~TRIBE ADD~~~~~");

		String is_band = request.getParameter("is_band");
		String prod_id = request.getParameter("prod_id");

		if ("2".equals(is_band) && prod_id == null) {
			prod_id = "0";
		} else {
			TpProduct product = D.selectById(TpProduct.class, prod_id);
			request.setAttribute("prod", product);

			List<SalesVolume> svList = D
					.sql("SELECT PROD_ID,COUNT(*) count FROM T_O_ORDER_DETAIL WHERE PROD_ID = ?")
					.many(SalesVolume.class, prod_id);
			request.setAttribute("sCount", svList.get(0).getCount());

			List<TTTopic> topicList = D.sql(
					"SELECT * FROM T_T_TOPIC WHERE PROD_ID = ?").many(
					TTTopic.class, prod_id);
			request.setAttribute("tCount", topicList.size());

			List<TpProductPic> prodPicList = D.sql(
					"SELECT * FROM T_P_PRODUCT_PIC WHERE PROD_ID = ?").many(
					TpProductPic.class, prod_id);
			for (TpProductPic tpProductPic : prodPicList) {
				tpProductPic.setPic_url(MallService.IMGURL + tpProductPic.getPic_url());
			}
			request.setAttribute("pic_url", prodPicList.get(0).getPic_url());

			List<TpAttr> prodAttrList = D.sqlAt("sql.mall/getColor").many(TpAttr.class, prod_id);
			String[] colorArray = null;// 颜色数组
			if (prodAttrList.size() > 0) {
				for (TpAttr tpAttr : prodAttrList) {
					colorArray = tpAttr.getAttrValue().split("[|]");
				}
			}
			request.setAttribute("colorArray", colorArray);
		}

		request.setAttribute("is_band", is_band);
		request.setAttribute("prod_id", prod_id);

		return "tribe/add";
	}

	/**
	 * 定位
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("geolocation")
	public String geolocation(HttpServletRequest request) {
		log.info("~~~~~TRIBE GEOLOCATION~~~~~");

		String lng = request.getParameter("lng");
		String lat = request.getParameter("lat");

		return MallService.geolocation(lng, lat);
	}

	/**
	 * 发表
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("adding")
	public int adding(HttpServletRequest request) {
		log.info("~~~~~TRIBE ADDING~~~~~");

		String topic_title = request.getParameter("topic_title");
		String topic_cont = request.getParameter("topic_cont");
		String is_band = request.getParameter("is_band");
		int prod_id = Integer.valueOf(request.getParameter("prod_id"));
		String is_show = request.getParameter("is_show");
		String xx = request.getParameter("xx");
		String yy = request.getParameter("yy");
		String imgNum = request.getParameter("imgNum");
		String imgUrl = request.getParameter("imgUrl");

		Member member = MallService.getMember(request);
		String topic_type = "2";
		String[] adminA = MallService.ADMIN.split(",");
		for (String string : adminA) {
			if (string.equals("" + member.getMember_id()))
				topic_type = "1";
		}

		TTTopic topic = new TTTopic();

		topic.setTopic_title(topic_title);
		topic.setTopic_type(topic_type);
		topic.setTopic_cont(topic_cont);

		topic.setIs_band(is_band);
		if ("1".equals(is_band)) {
			topic.setProd_id(prod_id);
		}

		topic.setIs_show(is_show);
		if ("1".equals(is_show)) {
			topic.setXx(xx);
			topic.setYy(yy);
			if (!"0".equals(xx) && !"0".equals(yy)) {
				JSONObject jo = JSONObject.fromObject(MallService.geolocation(xx, yy));
				topic.setAddress(jo.getString("address"));
			}
		}

		topic.setCreate_user(member.getMember_id());
		topic.setCreate_time(new Date());
		topic.setStatus("0");

		if ("1".equals(topic_type) && "1".equals(is_band)) {
			List<TTTopic> topicList = D
					.sql("SELECT * FROM T_T_TOPIC WHERE topic_type = 1 AND prod_id = ?")
					.many(TTTopic.class, prod_id);
			if (topicList.size() > 0)
				return -1;
		}

		int topic_id = D.insertAndReturnInteger(topic);

		log.info("~~~~~~~~~~imgNum     " + imgNum);
		log.info("~~~~~~~~~~imgUrl     " + imgUrl);
		if (!"0".equals(imgNum)) {
			String[] imgArr = imgUrl.split(",");
			for (String string : imgArr) {
				if (!"".equals(string.trim())) {
					TTTopicImg topicImg = new TTTopicImg();
					topicImg.setTopic_id(Integer.valueOf(topic_id));
					topicImg.setImg_url(string.trim());
					topicImg.setUpload_time(new Date());
					D.insert(topicImg);
				}

			}
		}

		return topic_id;
	}

	/**
	 * 个人
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("my")
	public String my(HttpServletRequest request) {
		log.info("~~~~~TRIBE MY~~~~~");

		Member member = MallService.getMember(request);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", member.getMember_id());

		List<TTTopic> list1 = D.defSql("sql.tribe/listTTT", request, map).many(
				TTTopic.class);// 发表的话题
		List<TTReply> list2 = D.defSql("sql.tribe/listTTR", request, map).many(
				TTReply.class);// 评论的话题
		List<TTPraise> list3 = D.defSql("sql.tribe/listTTP", request, map)
				.many(TTPraise.class);// 赞过的话题

		request.setAttribute("member", member);
		request.setAttribute("list1", list1.size());
		request.setAttribute("list2", list2.size());
		request.setAttribute("list3", list3.size());

		return "tribe/my";
	}

	/**
	 * 话题列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("list")
	public String list(HttpServletRequest request) {
		String type = request.getParameter("type");
		request.setAttribute("type", type);
		return "tribe/list";
	}

	/**
	 * 话题列表分页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("pageMy")
	public String pageMy(HttpServletRequest request) {
		String type = request.getParameter("type");
		String pageIndex = request.getParameter("pageIndex");

		int index = -1;
		int total = 0;

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageSize", MallService.PAGESIZE);
		map.put("pageIndex", pageIndex);
		if (!type.equals("tz"))
			map.put("user_id", MallService.getMember(request).getMember_id());

		List<TTTopic> list = new ArrayList<TTTopic>();

		// 发表的话题
		if (type.equals("fb")) {
			SqlAndParams sqlAndParams = (SqlAndParams) ClojureUtil.getFn(
					"sql.tribe/pageTTT").invoke(request, map);
			Page<TTTopic> page = D.sqlAndParams(sqlAndParams).pageSqlAndParams(
					TTTopic.class);
			list = page.getData();
			for (TTTopic topic : list) {
				topic = MallService.packTopic(request, topic);
			}

			index = page.getPageIndex();
			total = page.getPageTotal();
		}

		// 回复的话题
		if (type.equals("hf")) {
			SqlAndParams sqlAndParams = (SqlAndParams) ClojureUtil.getFn(
					"sql.tribe/pageTTR").invoke(request, map);
			Page<TTReply> page = D.sqlAndParams(sqlAndParams).pageSqlAndParams(
					TTReply.class);
			List<TTReply> replyList = page.getData();
			for (TTReply reply : replyList) {
				TTTopic topic = D
						.selectById(TTTopic.class, reply.getTopic_id());
				topic = MallService.packTopic(request, topic);

				boolean boo = true;// 去重在一个帖子中的多次回复）
				for (TTTopic ttt : list) {
					if (ttt.getTopic_id() == topic.getTopic_id())
						boo = false;
				}
				if (boo)
					list.add(topic);
			}

			index = page.getPageIndex();
			total = page.getPageTotal();
		}

		// 赞过的话题
		if (type.equals("zg")) {
			SqlAndParams sqlAndParams = (SqlAndParams) ClojureUtil.getFn(
					"sql.tribe/pageTTP").invoke(request, map);
			Page<TTPraise> page = D.sqlAndParams(sqlAndParams)
					.pageSqlAndParams(TTPraise.class);
			List<TTPraise> praiseList = page.getData();
			for (TTPraise praise : praiseList) {
				TTTopic topic = D.selectById(TTTopic.class,
						praise.getTopic_id());
				topic = MallService.packTopic(request, topic);
				list.add(topic);
			}

			index = page.getPageIndex();
			total = page.getPageTotal();
		}

		// 拓展的话题
		if (type.equals("tz")) {
			map.put("prod_id", request.getParameter("prod_id"));
			map.put("topic_type", "2");
			SqlAndParams sqlAndParams = (SqlAndParams) ClojureUtil.getFn(
					"sql.tribe/pageTTT").invoke(request, map);
			Page<TTTopic> page = D.sqlAndParams(sqlAndParams).pageSqlAndParams(
					TTTopic.class);
			list = page.getData();
			for (TTTopic topic : list) {
				topic = MallService.packTopic(request, topic);
			}

			index = page.getPageIndex();
			total = page.getPageTotal();

			if (page.getData().size() == 0 && Integer.valueOf(pageIndex) == 0)
				total = 0;
		}

		request.setAttribute("list", list);
		request.setAttribute("pageIndex", index);
		request.setAttribute("pageTotal", total);

		return "tribe/pageMy";
	}

	/**
	 * 回复
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("reply")
	public int reply(HttpServletRequest request) {
		log.info("~~~~~TRIBE REPLY~~~~~");

		int topic_id = Integer.valueOf(request.getParameter("topic_id"));
		String reply_cont = request.getParameter("reply_cont");
		String xx = request.getParameter("xx");
		String yy = request.getParameter("yy");

		TTTopic topic = D.selectById(TTTopic.class, topic_id);
		Member member = MallService.getMember(request);
		if ("1".equals(member.getStatus()))
			return -1;

		TTReply reply = new TTReply();
		reply.setTopic_id(topic_id);
		reply.setReply_cont(reply_cont);
		reply.setReply_time(new Date());
		reply.setReply_user(member.getMember_id());
		if ("1".equals(topic.getIs_band())) {
			String reply_user_type = "3"; // 游客

			List<Order> oList = D.sql(
					"SELECT * FROM T_O_ORDER WHERE member_id = ?").many(
					Order.class, member.getMember_id());
			for (Order order : oList) {
				List<OrderDetail> odList = D.sql(
						"SELECT * FROM T_O_ORDER_DETAIL WHERE order_id = ?")
						.many(OrderDetail.class, order.getOrder_id());
				for (OrderDetail orderDetail : odList) {
					if (orderDetail.getProd_id()
							- Long.valueOf(topic.getProd_id()) == 0)
						reply_user_type = "2";// 已购
				}
			}

			String[] adminA = MallService.ADMIN.split(",");
			for (String string : adminA) {
				if (string.equals("" + member.getMember_id()))
					reply_user_type = "1";// 管理员
			}

			reply.setReply_user_type(reply_user_type);
		}
		reply.setXx(xx);
		reply.setYy(yy);
		if (!"0".equals(xx) && !"0".equals(yy)) {
			JSONObject jo = JSONObject.fromObject(MallService.geolocation(xx, yy));
			reply.setAddress(jo.getString("address"));
		}
		reply.setStatus("0");

		return D.insertWithoutNull(reply);
	}

	/**
	 * 点赞
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("praise")
	public int praise(HttpServletRequest request) {
		log.info("~~~~~TRIBE PRAISE~~~~~");

		int topic_id = Integer.valueOf(request.getParameter("topic_id"));
		String xx = request.getParameter("xx");
		String yy = request.getParameter("yy");

		Member member = MallService.getMember(request);
		if ("1".equals(member.getStatus()))
			return -1;

		String sql = "SELECT * FROM T_T_PRAISE WHERE topic_id = ? AND praise_user = ?";
		List<TTPraise> list = D.sql(sql).many(TTPraise.class, topic_id,
				member.getMember_id());
		if (list.size() > 0)
			return 0;

		TTPraise praise = new TTPraise();
		praise.setTopic_id(topic_id);
		praise.setPraise_time(new Date());
		praise.setPraise_user(member.getMember_id());
		praise.setXx(xx);
		praise.setYy(yy);
		if (!"0".equals(xx) && !"0".equals(yy)) {
			JSONObject jo = JSONObject.fromObject(MallService.geolocation(xx, yy));
			praise.setAddress(jo.getString("address"));
		}
		praise.setStatus("0");

		return D.insertWithoutNull(praise);
	}

	/**
	 * 上传
	 * 
	 * @param request
	 */
	@ResponseBody
	@RequestMapping("upload")
	public void upload(HttpServletRequest request) {
		String topic_id = request.getParameter("id");

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		String img_url = MallService.uploadFile(fileMap.get("fileList"));

		TTTopicImg topicImg = new TTTopicImg();
		topicImg.setTopic_id(Integer.valueOf(topic_id));
		topicImg.setImg_url(img_url);
		topicImg.setUpload_time(new Date());

		D.insert(topicImg);
	}

	@ResponseBody
	@RequestMapping("upload1")
	public String upload1(HttpServletRequest request) {
		log.info("^^^^^^^^^^^^^^^^^     UPLOAD1      ^^^^^^^^^^^^^^^^^^^");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		log.info("^^^^^^^^^^^^^^^^^     fileMap      ^^^^^^^^^^^^^^^^^^^"
				+ fileMap.get("fileList").getOriginalFilename());

		String path = MallService.uploadFile(fileMap.get("fileList"));

		log.info("^^^^^^^^^^^^^^^^^     path      ^^^^^^^^^^^^^^^^^^^" + path);
		return path;
	}

	@ResponseBody
	@RequestMapping("bind")
	public void bind(HttpServletRequest request) {
		String topic_id = request.getParameter("id");
		String img_url = request.getParameter("url");

		TTTopicImg topicImg = new TTTopicImg();
		topicImg.setTopic_id(Integer.valueOf(topic_id));
		topicImg.setImg_url(img_url);
		topicImg.setUpload_time(new Date());

		D.insert(topicImg);
	}

}
