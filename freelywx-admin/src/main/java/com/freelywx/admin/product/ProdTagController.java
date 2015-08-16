package com.freelywx.admin.product;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.product.TpProdTag;
import com.freelywx.common.model.product.TpProduct;
import com.freelywx.common.model.product.TpRecommend;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

/**
 * 商品管理
 * 
 * @author Administrator
 * 
 */

@Controller
@RequestMapping(value = "/prodTag")
public class ProdTagController {

	@RequestMapping("")
	public String init()  {
		return "product/prodType/prodType";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response)  {
		PageModel page = PageUtil.getPageModel(TpProdTag.class, "sql.product/getProdTypeList", request);
		return page;
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean saveCategory(@RequestBody TpProdTag prodType, HttpServletRequest request) {
		try {
			ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
			if (prodType.getTag_id() != null) {
				prodType.setUpdate_time(new Date());
				prodType.setUpdate_by(user.getUser_id());
				D.updateWithoutNull(prodType);
			} else {
				prodType.setStatus(SystemConstant.State.STATE_ENABLE);
				prodType.setCreate_time(new Date());
				prodType.setCreate_by(user.getUser_id());
				D.insert(prodType);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 跳转
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/edit")
	public String editType(HttpServletRequest request) {
		return "product/prodType/editProdType";
	}

	/**
	 * 获取分类的详情
	 * 
	 * @param categoryId
	 * @return
	 */
	@RequestMapping("/prodType")
	@ResponseBody
	public TpProdTag getCategory(HttpServletRequest request) {
		try {
			Long prodTypeId = Long.valueOf(request.getParameter("prodTypeId"));
			TpProdTag prodType = D.selectById(TpProdTag.class, prodTypeId);
			return prodType;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/delete")
	@ResponseBody
	public HashMap<String, String> deleteCategory(HttpServletRequest request) {
		final HashMap<String, String> map = new HashMap<String, String>();
		try {
			Long prodTypeId = Long.valueOf(request.getParameter("prodTypeId"));
			String sql = "select *  from T_P_RECOMMEND   where  PROD_TYPE_ID = ? ";
			List<TpRecommend> prodList = D.sql(sql).many(TpRecommend.class, prodTypeId);
			if (prodList.size() > 0) {
				map.put("status", "1");
			} else {
				D.deleteById(TpProdTag.class, prodTypeId);
				map.put("status", "2");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("status", "0");
		}
		return map;
	}

	@RequestMapping("/listSelect")
	@ResponseBody
	public PageModel listSelect(HttpServletRequest request, HttpServletResponse response)  { 
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("status",SystemConstant.ProdShelf.ENABLE);
		PageModel page = PageUtil.getPageModel(TpProduct.class, "sql.product/getPageProdlistByType", request,map);
		return page;
	}

	@RequestMapping("/listNoSelect")
	@ResponseBody
	public List<TpProduct> listNoSelect(HttpServletRequest request, HttpServletResponse response)
			 {
		String prodTypeId = request.getParameter("prod_type_id");
		List<TpProduct> list = D.sqlAt("sql.product/getNotProdlistByType").many(TpProduct.class,
				SystemConstant.ProdShelf.ENABLE, prodTypeId);
		return list;
	}

	@RequestMapping("/listAllSelect")
	@ResponseBody
	public List<TpProduct> listAllSelect(HttpServletRequest request, HttpServletResponse response)
			 {
		String prodTypeId = request.getParameter("prod_type_id");
		List<TpProduct> list = D.sqlAt("sql.product/getProdlistByType").many(TpProduct.class,
				SystemConstant.ProdShelf.ENABLE, prodTypeId);
		return list;
	}

	@RequestMapping("/bindList")
	public String bindType(HttpServletRequest request, Model model) {
		String prod_type_id = request.getParameter("prod_type_id");
		model.addAttribute("prod_type_id", prod_type_id);
		return "prodType/productList";
	}

	@RequestMapping("/bind/add")
	public String bindAdd(HttpServletRequest request, Model model) {
		/*
		 * String prod_type_id = request.getParameter("prod_type_id");
		 * model.addAttribute("prod_type_id", prod_type_id);
		 */
		return "product/prodType/productBind";
	}

	@RequestMapping("/bind")
	@ResponseBody
	public boolean bind(@RequestParam final String attrIds, @RequestParam final int tagId) {
		try {
			D.startTranSaction(new Callable() {
				@Override
				public Object call() {
					// 先删除原有的关系
					D.sql("delete   from t_p_recommend where tag_id = ?").update(tagId);
					String[] ids = attrIds.split(",");
					for (int i = 0; i < ids.length; i++) {
						if (!StringUtils.isEmpty(ids[i])) {
							TpRecommend tpca = new TpRecommend();
							tpca.setTag_id(tagId);
							tpca.setProd_id(Integer.parseInt(ids[i]));
							tpca.setSort(i + 1);
							D.insert(tpca);
						}
					}
					return null;
				}
			});
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}

	@RequestMapping("/bind/delete")
	@ResponseBody
	public boolean deleteBind(HttpServletRequest request) {
		try {
			Long recommend_id = Long.valueOf(request.getParameter("recommend_id"));
			D.deleteById(TpRecommend.class, recommend_id);
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}

	@RequestMapping("/check")
	@ResponseBody
	public boolean check(HttpServletRequest request) {
		try {
			String typeName = request.getParameter("typeName");
			String typeId = request.getParameter("typeId");
			if (!StringUtils.isEmpty(typeId)) {
				List<TpProdTag> categoryList = D.sql(
						"select * from T_P_PROD_TYPE where type_name = ? and prod_type_id != ?").many(TpProdTag.class,
						typeName, typeId);
				if (categoryList.size() > 0) {
					return false;
				}
			} else {
				TpProdTag prodType = D.sql("select * from T_P_PROD_TYPE where type_name = ?").oneOrNull(
						TpProdTag.class, typeName);
				if (prodType != null) {
					return false;
				}
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
