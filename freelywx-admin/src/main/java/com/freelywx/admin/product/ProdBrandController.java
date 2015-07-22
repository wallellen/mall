package com.freelywx.admin.product;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.model.product.TpBrand;
import com.freelywx.common.model.product.TpCategory;
import com.freelywx.common.model.product.TpProduct;
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
@RequestMapping(value = "/prodBrand")
public class ProdBrandController {

	@RequestMapping("")
	public String init() throws  IOException {
		return "product/prodBrand/prodBrand";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response){
		PageModel page = PageUtil.getPageModel(TpBrand.class, "sql.product/getProdBrandList", request);
		return page;
	}

	@RequestMapping("/listAll")
	@ResponseBody
	public List<TpCategory> listAll(HttpServletRequest request, HttpServletResponse response) throws 
			IOException {
		String sql = "select * from T_P_BRAND order by display_order ";
		return D.sql(sql).many(TpCategory.class);
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean saveCategory(@RequestBody TpBrand brand, HttpServletRequest request) {
		try {
			ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
			if (brand.getBrand_id() != null) {
				brand.setLast_update_time(new Date());
				brand.setLast_updated_by(user.getUser_id());
				D.updateWithoutNull(brand);
			} else {
				//brand.setBrand_status("");
				brand.setCreate_time(new Date());
				brand.setCreated_by(user.getUser_id());
				D.insert(brand);
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
	public String editCategory(HttpServletRequest request,Model model) {
		//model.addAttribute("server_url", Config.SERVER_BASE);
		return "product/prodBrand/editProdBrand";
	}


	/*@RequestMapping("/selectBrand")
	public String selectCategory(HttpServletRequest request, Model model) {
		model.addAttribute("category_id", request.getParameter("id"));
		model.addAttribute("default_category_id", request.getParameter("pid"));
		return "prodCategory/selectBrand";
	}
*/
	/**
	 * 获取分类的详情
	 * 
	 * @param categoryId
	 * @return
	 */
	@RequestMapping("/brand")
	@ResponseBody
	public TpBrand getCategory(HttpServletRequest request) {
		try {
			Long brandId = Long.valueOf(request.getParameter("brandId"));
			return D.selectById(TpBrand.class, brandId);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/delete")
	@ResponseBody
	public HashMap<String, String> deleteBrand(HttpServletRequest request) {
		final HashMap<String, String> map = new HashMap<String, String>();
		try {
			Long brandId = Long.valueOf(request.getParameter("brandId"));
			List<TpProduct> prodList = D.sql("select * from T_P_PRODUCT where brand_id = ? ").many(TpProduct.class, brandId);
			if(prodList.size()>0 ){
				map.put("status", "1");
			}else{
				D.deleteById(TpBrand.class, brandId);
				map.put("status", "2");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("status", "0");
		}
		return map;
	}
	
	@RequestMapping("/checkCn")
	@ResponseBody
	public boolean checkCn(HttpServletRequest request) {
		try{
			String brandName =  request.getParameter("brandName") ;
			String brandId =  request.getParameter("brandId") ;
			if(!StringUtils.isEmpty(brandId)){
				List<TpBrand> brandList = D.sql("select * from T_P_BRAND where brand_name = ? and brand_id != ?").many(TpBrand.class, brandName,brandId);
				if(brandList.size()>0){
					return false;
				}
			}else{
				TpBrand brand = D.sql("select * from T_P_BRAND where brand_name = ?").oneOrNull(TpBrand.class, brandName);
				if(brand != null){
					return false;
				}
			}
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@RequestMapping("/checkEn")
	@ResponseBody
	public boolean checkEn(HttpServletRequest request) {
		try{
			String brandEnName =  request.getParameter("brandEnName") ;
			String brandId =  request.getParameter("brandId") ;
			if(!StringUtils.isEmpty(brandId)){
				List<TpBrand> brandList = D.sql("select * from T_P_BRAND where brand_name_en = ? and brand_id != ?").many(TpBrand.class, brandEnName,brandId);
				if(brandList.size()>0){
					return false;
				}
			}else{
				TpBrand brand = D.sql("select * from T_P_BRAND where brand_name_en = ?").oneOrNull(TpBrand.class, brandEnName);
				if(brand != null){
					return false;
				}
			}
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
