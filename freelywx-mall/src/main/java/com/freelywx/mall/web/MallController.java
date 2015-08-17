package com.freelywx.mall.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.advertise.Advertisement;
import com.freelywx.common.model.member.Member;
import com.freelywx.common.model.member.MemberFavorites;
import com.freelywx.common.model.member.MemberLove;
import com.freelywx.common.model.product.TpAttr;
import com.freelywx.common.model.product.TpCategory;
import com.freelywx.common.model.product.TpProduct;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.freelywx.mall.pojo.SalesVolume;
import com.freelywx.mall.util.MallService;
import com.rps.util.D;

@Controller
@Scope("session")
@RequestMapping("")
public class MallController {
	private static final Logger log = LoggerFactory.getLogger(MallController.class);

	/**
	 * 商品列表页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("")
	public String index(HttpServletRequest request) {
		log.info("~~~~~MALL INDEX~~~~~");
		Advertisement advertise = MallService.getAdverti();
		request.setAttribute("advertise", advertise);

		return "product/list";
	}

	@RequestMapping("pageProd")
	public String pageProd(HttpServletRequest request) {
		log.info("~~~~~PAGE PROD~~~~~");

		String pageIndex = request.getParameter("pageIndex");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("pageSize", MallService.PAGESIZE);
		map.put("pageIndex", pageIndex);

		/*SqlAndParams sqlAndParams = (SqlAndParams) ClojureUtil.getFn(
				"sql.mall/pageProd").invoke(request, map);
		Page<TpProduct> page = D.sqlAndParams(sqlAndParams).pageSqlAndParams(
				TpProduct.class);*/
		PageModel page = PageUtil.getPageModel(TpProduct.class, "sql.mall/pageProd", request, map);
		List<TpProduct> productList = (List<TpProduct>) page.getData();

		List<MemberLove> loveList = D.sql("SELECT * FROM T_M_LOVE WHERE MEMBER_ID = ?").many(
				MemberLove.class, MallService.getMember(request).getMember_id());

		for (TpProduct tpProduct : productList) {
			tpProduct.setLove("1");

			List<MemberLove> loveCount = D.sql("SELECT * FROM T_M_LOVE WHERE PROD_ID = ?").many(MemberLove.class, tpProduct.getProd_id());
			tpProduct.setLoveCount(loveCount.size());

			if (loveList.size() > 0) {
				for (MemberLove love : loveList) {
					if (tpProduct.getProd_id() - love.getProd_id() == 0)
						tpProduct.setLove("0");
				}
			}

			tpProduct.setPicList(MallService.getProdPic(tpProduct.getProd_id()));
		}

		request.setAttribute("list", productList);
		request.setAttribute("pageIndex", pageIndex);
		request.setAttribute("pageTotal", page.getTotal());

		return "product/pageProd";
	}

	/**
	 * 商品详细页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("getProd")
	public String getProd(HttpServletRequest request) {
		log.info("~~~~~GET PROD~~~~~");


		Member member = MallService.getMember(request);
		long mId = member.getMember_id();

		List<TpProduct> list = D.defSql("sql.mall/listProd", request, null)
				.many(TpProduct.class);

		if (list.size() == 0)
			return "redirect:/";

		TpProduct prod = list.get(0);
		int pId = prod.getProd_id();

	//	MallService.prodVisit(request, mId, member.getOpenid()(), pId, "");

		prod.setPicList(MallService.getProdPic(pId));
		prod.setCategory(D.selectById(TpCategory.class, prod.getCategory_id()));

		List<TpAttr> attrList = D.sqlAt("sql.mall/getColor").many(TpAttr.class, pId);
		String[] colorArray = null;
		for (TpAttr tpAttr : attrList) {
			colorArray = tpAttr.getAttrValue().split("[|]");
		}
		prod.setColorArray(colorArray);

		String favorSql = "SELECT * FROM T_M_FAVORITES WHERE MEMBER_ID = ? AND PROD_ID = ?";
		List<MemberFavorites> favoritesList = D.sql(favorSql).many(
				MemberFavorites.class, mId, pId);
		prod.setFavor("1");
		if (favoritesList.size() > 0)
			prod.setFavor("0");

		String salesSql = "SELECT PROD_ID,COUNT(*) count FROM T_O_ORDER_DETAIL WHERE PROD_ID = ?";
		prod.setSalesVolume(D.sql(salesSql).one(SalesVolume.class, pId)
				.getCount());

		request.setAttribute("cvList", MallService.getCoupon(member, "1"));

		request.setAttribute("prod", prod);

		return "product/detail";// 前往商品详细页
	}

	/**
	 * 设置收藏
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("setFavor")
	public int setFavor(HttpServletRequest request) {
		log.info("~~~~~SET FAVOR~~~~~");

		String id = request.getParameter("prod_id");
		TpProduct product = D.selectById(TpProduct.class, id);
		if (product == null)
			return -1;

		MemberFavorites favor = new MemberFavorites();
		favor.setMember_id(MallService.getMember(request).getMember_id());
		favor.setProd_id(product.getProd_id());
		favor.setState("1");
		favor.setCreate_time(new Date());

		return D.insertWithoutNull(favor);
	}

	@ResponseBody
	@RequestMapping("delFavor")
	public int delFavor(HttpServletRequest request) {
		log.info("~~~~~DEL FAVOR~~~~~");

		String id = request.getParameter("prod_id");
		TpProduct product = D.selectById(TpProduct.class, id);
		if (product == null)
			return -1;

		String sql = "SELECT * FROM T_M_FAVORITES WHERE MEMBER_ID = ? AND PROD_ID = ?";
		MemberFavorites favor = D.sql(sql).one(MemberFavorites.class,
				MallService.getMember(request).getMember_id(), product.getProd_id());

		return D.delete(favor);
	}

	/**
	 * 设置喜欢
	 * 
	 * @param request
	 * @return
	 *//*
	@ResponseBody
	@RequestMapping("setLove")
	public int setLove(HttpServletRequest request) {
		log.info("~~~~~SET LOVE~~~~~");

		Long prod_id = Long.valueOf(request.getParameter("id"));

		MemberLove love = new MemberLove();
		love.setMember_id(MallService.getMember(request).getMember_id());
		love.setProd_id(prod_id);
		love.setState("1");
		love.setCreate_time(new Date());

		return D.insertWithoutNull(love);
	}

	@ResponseBody
	@RequestMapping("delLove")
	public int delLove(HttpServletRequest request) {
		log.info("~~~~~DEL LOVE~~~~~");

		Long prod_id = Long.valueOf(request.getParameter("id"));

		Member member = MallService.getMember(request);

		String sql = "SELECT * FROM T_M_LOVE WHERE member_id = ? AND prod_id = ?";
		MemberLove love = D.sql(sql).one(MemberLove.class,
				member.getMember_id(), prod_id);

		return D.delete(love);
	}*/

}
