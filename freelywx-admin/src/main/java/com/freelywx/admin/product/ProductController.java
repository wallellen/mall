package com.freelywx.admin.product;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.config.Config;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.product.TpAttr;
import com.freelywx.common.model.product.TpCategory;
import com.freelywx.common.model.product.TpCategoryTree;
import com.freelywx.common.model.product.TpProdCategory;
import com.freelywx.common.model.product.TpProduct;
import com.freelywx.common.model.product.TpProdAttr;
import com.freelywx.common.model.product.TpProductPic;
import com.freelywx.common.model.product.TpProductPicPc;
import com.freelywx.common.util.CodeUtil;
import com.freelywx.common.util.JacksonUtil;
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
@RequestMapping(value = "/prod")
public class ProductController {

	@RequestMapping("")
	public String init()  {
		return "product/product/product";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response)  {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		Map<String,Object> map = new HashMap<>();
		map.put("site_id", user.getSite_id());
		PageModel page = PageUtil.getPageModel(TpProduct.class, "sql.product/getProdlist", request,map);
		return page;
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean saveProd(HttpServletRequest request) {
		//编辑商品的时候，应该删除原来的商品，然后新创建一个商品信息
		try {
			String prodStr = request.getParameter("prodStr");
			final String picStr = request.getParameter("picStr");
			//final String pcPicStr = request.getParameter("pcPicStr");
			//final String smallPcPicStr = request.getParameter("smallPcPicStr");
			final String attrStr = request.getParameter("attrStr");
			//final String qrcodePicStr = request.getParameter("qrcodePicStr");
			final TpProduct product = JacksonUtil.readValue(prodStr, TpProduct.class);
			// 设置二维码
			/*String str1 = qrcodePicStr.substring(1, qrcodePicStr.length() - 1);
			if (!StringUtils.isEmpty(str1)) {
				String[] url = str1.split(":");
				if (!StringUtils.isEmpty(url[1]) && !"\"\"".equals(url[1])) {
					product.setQr_code(url[1].replace("\"", ""));
				}
			}*/
			final ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
			if (product.getProd_id() != null) {
				product.setUpdate_time(new Date());
				product.setUpdate_by(user.getUser_id());
				D.updateWithoutNull(product);

				// 编辑图片
				D.sql("delete from t_p_prod_pic where prod_id = ?").update(product.getProd_id());
				int prod_id = product.getProd_id();
				savePic(picStr, prod_id);
				//D.sql("delete from T_P_PRODUCT_PIC_PC where prod_id = ?").update(product.getProd_id());
				//savePcPic(pcPicStr, smallPcPicStr, prod_id);
				// 编辑属性
				D.sql("delete from t_p_prod_attr where prod_id = ?").update(product.getProd_id());
				if (!StringUtils.isEmpty(attrStr)) {

					int count = 0;
					Map<String, Object> map = parserToMap(attrStr);
					for (String key : map.keySet()) {
						System.out.println("key= " + key + " and value= " + map.get(key));
						String value = (String) map.get(key);
						if (!StringUtils.isEmpty(value) && key.endsWith("_text")) {
							// 属性编号
							String attr_id = key.split("_")[0];

							// 盘底属性是否为动态属性
							boolean attr_type = Boolean.valueOf((String) map.get(attr_id + "_attr_type"));
							TpProdAttr prodAttr = new TpProdAttr();
							prodAttr.setProd_id(product.getProd_id());
							prodAttr.setAttr_id(Integer.parseInt(attr_id));
							prodAttr.setAttr_value(value);

							// 动态属性
							String dynamicType = SystemConstant.ProdAttrType.DYNAMIC;
							// 静态属性
							String staticType = SystemConstant.ProdAttrType.INSTATIC;
							prodAttr.setAttr_type(attr_type ? dynamicType : staticType);
							prodAttr.setSort(++count);
							D.insert(prodAttr);

						}
					}
				}
			} else {
				D.startTranSaction(new Callable() {
					@Override
					public Object call() {
						// String id =
						// D.sqlAt("sql.sequence/getNextVal").oneOrNull(String.class,
						// "MOWEI.PRODUCT");
						// 解决mysql数据库版本不一样 存储过程返回的数据类型 start
						Object id = D.sqlAt("sql.sequence/getNextVal").queryByResultSetHandler(new ResultSetHandler() {
							@Override
							public Object handle(ResultSet rs) throws SQLException {
								Object ret = null;
								if (rs.next()) {
									System.out.println("-----in ---rs.next()-----------");
									ret = rs.getObject(1);
								}
								return ret;
							}
						}, "MOWEI.PRODUCT");
						String prodId = "";
						if (id instanceof String) {
							prodId = String.valueOf(id);
						} else if (id instanceof byte[]) {
							prodId = new String((byte[]) id);
						}
						// ----------------------------------end
						int prod_id = Integer.parseInt(prodId);
						String prodCode = CodeUtil.generatorProdCode(prod_id);
						product.setProd_id(prod_id);
						product.setProd_code(prodCode);
						product.setCreate_time(new Date());
						product.setCreate_by(user.getUser_id());
						product.setStatus(SystemConstant.ProdShelf.DISABLE);
						product.setSite_id(user.getSite_id());
						// product.setStatus("2");
						D.insert(product);
						
						// 保存分类和商品的关联关系
						List<TpCategoryTree> categoryTreeList = D.sql(
								"select * from  t_p_category_tree where child_id = ?").many(
								TpCategoryTree.class, product.getCategory_id());
						for (TpCategoryTree categoryTree : categoryTreeList) {
							TpProdCategory prodCategory = new TpProdCategory();
							prodCategory.setCategory_id(categoryTree.getCategory_id());
							prodCategory.setProd_id(prod_id);
							D.insert(prodCategory);
						}
						savePic(picStr, prod_id);
					//	savePcPic(pcPicStr, smallPcPicStr, prod_id);
						// 插入属性
						if (!StringUtils.isEmpty(attrStr)) {
							String str2 = attrStr.substring(1, attrStr.length() - 1);
							int count = 0;
							for (String attr : str2.split(",")) {
								if (!StringUtils.isEmpty(attr)) {
									String[] url = attr.split(":");
									if (!StringUtils.isEmpty(url[1]) && !"\"\"".equals(url[1]) && !"\"false\"".equals(url[1])) {
										TpProdAttr prodAttr = new TpProdAttr();
										prodAttr.setProd_id(prod_id);
										String id1 = url[0].split("_")[0].replace("\"", "");
										prodAttr.setAttr_id(Integer.parseInt(id1));
										prodAttr.setAttr_value(url[1].replace("\"", ""));
										prodAttr.setSort(++count);
										D.insert(prodAttr);
									}
								}
							}
						}
						return null;
					}
				});
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 保存图片
	 * @param picStr
	 * @param prod_id
	 */
	private void savePic(final String picStr, int prod_id) {
		String str1 = picStr.substring(1, picStr.length() - 1);
		for (String pic : str1.split(",")) {
			if (!StringUtils.isEmpty(pic)) {
				String[] url = pic.split(":");
				if (!StringUtils.isEmpty(url[1]) && !"\"\"".equals(url[1])) {
					TpProductPic prodPic = new TpProductPic();
					prodPic.setProd_id(prod_id);
					prodPic.setUrl(url[1].replace("\"", ""));
					D.insert(prodPic);
				}
			}
		}
	}
	
	/**
	 * 保存PC图片
	 * @param pcPicStr
	 * @param smallPcPicStr
	 * @param prod_id
	 */
	private void savePcPic(final String pcPicStr, final String smallPcPicStr, int prod_id){
		// 大图
		String str1 = pcPicStr.substring(1, pcPicStr.length() - 1);
		// 小图
		String str2 = smallPcPicStr.substring(1, smallPcPicStr.length() - 1);
		int i=0;
		for (String smallPic : str2.split(",")) {
			if (!StringUtils.isEmpty(smallPic)) {
				String[] url = smallPic.split(":");
				if (!StringUtils.isEmpty(url[1]) && !"\"\"".equals(url[1])) {
					TpProductPicPc proPcPic = new TpProductPicPc();
					proPcPic.setProd_id(prod_id);
					proPcPic.setUrl_small(url[1].replace("\"", ""));
					
					String[] smallPics = str1.split(",");
					if (smallPics.length > i && !StringUtils.isEmpty(smallPics[i])) {
						String[] smallUrl = smallPics[i].split(":");
						if (!StringUtils.isEmpty(smallUrl[1]) && !"\"\"".equals(smallUrl[1])) {
							proPcPic.setUrl(smallUrl[1].replace("\"", ""));
						}
					}
					D.insertWithoutNull(proPcPic);
				}
			}
			i++;
		}
	}

	@RequestMapping("/check")
	@ResponseBody
	public boolean check(HttpServletRequest request) {
		try {
			String prodName = request.getParameter("prodName");
			String prodId = request.getParameter("prodId");
			if (!StringUtils.isEmpty(prodId)) {
				List<TpCategory> categoryList = D.sql("select * from t_p_product where prod_name = ? and prod_id != ?")
						.many(TpCategory.class, prodName, prodId);
				if (categoryList.size() > 0) {
					return false;
				}
			} else {
				TpProduct product = D.sql("select * from t_p_product where prod_name = ?").oneOrNull(TpProduct.class,
						prodName);
				if (product != null) {
					return false;
				}
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@RequestMapping("/delete")
	@ResponseBody
	public boolean deleteProd(HttpServletRequest request) {
		try {
			
			String prodIds = request.getParameter("prodId");
			final String[] ids = prodIds.split(",");
			
			D.startTranSaction(new Callable() {
				@Override
				public Object call() {
					for(String str :ids){
						final Long prodId = Long.valueOf(str);
						// TODO Auto-generated method stub
						D.deleteById(TpProduct.class, prodId);
						D.sql(" delete from t_p_prod_pic where prod_id = ? ").update(prodId);
						D.sql(" delete from t_p_prod_attr where prod_id = ? ").update(prodId);
						D.sql(" delete from t_p_prod_category where prod_id = ? ").update(prodId);
						D.sql(" delete from t_p_prod_pic_pc where prod_id = ? ").update(prodId);
					}
					return null;
				}
			});
			// TpProduct product = D.selectById(TpProduct.class, prodId);

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
	public String editProd(HttpServletRequest request, Model model) {
		String categoryId = request.getParameter("categoryId");
		String prodId = request.getParameter("prodId");
		if (!StringUtils.isEmpty(categoryId)) {
			// 查询商品关联的属性 .新增商品
			List<TpAttr> attrList = D.sqlAt("sql.product/getAttrByCategoryId").many(TpAttr.class, categoryId);
			model.addAttribute("attrList", attrList);
			model.addAttribute("categoryId", "categoryId");
		} else {
			TpProduct product = D.selectById(TpProduct.class, prodId);
			List<TpAttr> attrList = D.sqlAt("sql.product/getAttrByCategoryId").many(TpAttr.class,product.getCategory_id());
			model.addAttribute("attrList", attrList);
			model.addAttribute("categoryId", product.getCategory_id());
			model.addAttribute("server_url", Config.SERVER_BASE);
		}
		return "product/product/editProduct";
	}

	/**
	 * 商品上架或者下架
	 * 
	 * @param productId
	 * @param flag
	 * @param approveInfo
	 * @param request
	 * @return
	 */
	/*
	 * @RequestMapping("/shelf") public String shelfProd(HttpServletRequest
	 * request,Model model) { String categoryId =
	 * request.getParameter("categoryId"); String prodId =
	 * request.getParameter("prodId");
	 * if(!StringUtil.isNullOrEmpty(categoryId)){ //查询商品关联的属性 List<TpAttr>
	 * attrList = D.sqlAt("sql.product/getAttrByCategoryId").many(TpAttr.class,
	 * categoryId); model.addAttribute("attrList", attrList);
	 * model.addAttribute("categoryId", "categoryId");
	 * 
	 * }else{ TpProduct product = D.selectById(TpProduct.class, prodId);
	 * List<TpAttr> attrList =
	 * D.sqlAt("sql.product/getAttrByCategoryId").many(TpAttr.class,
	 * product.getCategory_id()); model.addAttribute("attrList", attrList);
	 * model.addAttribute("categoryId",product.getCategory_id()); }
	 * 
	 * return "product/editProduct"; }
	 */

	@RequestMapping("/shelf")
	@ResponseBody
	public boolean shelfByStatus(HttpServletRequest request) {
		try {
			String flag = request.getParameter("flag");
			ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
			//判断是上架还是下架
			String status;
			if ("on".equals(flag)) {
				status = SystemConstant.ProdShelf.ENABLE;
			} else {
				status = SystemConstant.ProdShelf.DISABLE;
			}
			
			String prodIds = request.getParameter("prodId");
			String[] ids = prodIds.split(",");
			for(String str :ids){
				int prodId = Integer.parseInt(str);
				TpProduct product = new TpProduct();
				product.setProd_id(prodId);
				product.setStatus(status);
				product.setUpdate_time(new Date());
				product.setUpdate_by(user.getUser_id());
				D.updateWithoutNull(product);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}


	@RequestMapping("/product")
	@ResponseBody
	public TpProduct getProduct(HttpServletRequest request) {
		try {
			int prodId = Integer.parseInt(request.getParameter("prodId"));
			// TpProduct product = D.selectById(TpProduct.class, prodId);
			return D.selectById(TpProduct.class, prodId);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/pic")
	@ResponseBody
	public List<TpProductPic> getProductPic(HttpServletRequest request) {
		try {
			int prodId = Integer.parseInt(request.getParameter("prodId"));
			// TpProduct product = D.selectById(TpProduct.class, prodId);
			List<TpProductPic> picList = D.sql("select * from t_p_prod_pic where prod_id = ?").many(
					TpProductPic.class, prodId);
			return picList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping("/pcpic")
	@ResponseBody
	public List<TpProductPicPc> getProductPicPc(HttpServletRequest request) {
		try {
			int prodId = Integer.parseInt(request.getParameter("prodId"));
			// TpProduct product = D.selectById(TpProduct.class, prodId);
			List<TpProductPicPc> picList = D.sql("select * from t_p_prod_pic_pc where prod_id = ?").many(
					TpProductPicPc.class, prodId);
			return picList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/attr")
	@ResponseBody
	public List<TpProdAttr> getProductAttr(HttpServletRequest request) {
		try {
			Long prodId = Long.valueOf(request.getParameter("prodId"));
			// TpProduct product = D.selectById(TpProduct.class, prodId);
			List<TpProdAttr> attrList = D.sql("select * from t_p_prod_attr where prod_id = ?").many(
					TpProdAttr.class, prodId);
			return attrList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static Map<String, Object> parserToMap(String s) {
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject json = JSONObject.fromObject(s);
		Iterator<String> keys = json.keys();
		while (keys.hasNext()) {
			String key = (String) keys.next();
			String value = json.get(key).toString();
			if (value.startsWith("{") && value.endsWith("}")) {
				map.put(key, parserToMap(value));
			} else {
				map.put(key, value);
			}

		}
		return map;
	}
}
