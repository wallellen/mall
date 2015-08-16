package com.freelywx.admin.product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.product.TpAttr;
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
@RequestMapping(value = "/prodAttr")
public class ProdAttrController {

	@RequestMapping("")
	public String init() throws Exception {
		return "product/prodAttr/attr";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request,
			HttpServletResponse response) throws  IOException {
		PageModel page = PageUtil.getPageModel(TpAttr.class,
				"sql.product/getAttrList", request);
		return page;
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean saveCategory(@RequestBody TpAttr attr,	HttpServletRequest request) {
		try {
			ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
			if (attr.getAttr_id() != null) {
				attr.setUpdate_time(new Date());
				attr.setUpdate_by(user.getUser_id());
				D.updateWithoutNull(attr);
			} else {
				attr.setStatus(SystemConstant.State.STATE_ENABLE);
				attr.setCreate_time(new Date());
				attr.setCreate_by(user.getUser_id());
				D.insert(attr);
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
	public String editCategory(HttpServletRequest request) {
		return "product/prodAttr/editAttr";
	}

	/**
	 * 获取分类的详情
	 * 
	 * @param categoryId
	 * @return
	 */
	@RequestMapping("/attr")
	@ResponseBody
	public TpAttr getCategory(HttpServletRequest request) {
		try {
			Long attrId = Long.valueOf(request.getParameter("attrId"));
			TpAttr attr = D.selectById(TpAttr.class, attrId);
			return attr;
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
			Long attrId = Long.valueOf(request.getParameter("attrId"));
			List<TpAttr> prodList = D.sql("select * from t_p_category_attr where attr_id = ? ").many(TpAttr.class, attrId);
			
			
			if(prodList.size()>0 ){
				map.put("status", "1");
			}else{
				D.deleteById(TpAttr.class, attrId);
				map.put("status", "2");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("status", "0");
		}
		return map;
	}

	/**
	 * 查询所有的属性信息(编辑状态查询未选中的属性)
	 * 
	 * @return
	 * @throws BusinessException
	 */
	@RequestMapping("/listAll")
	@ResponseBody
	public List<TpAttr> listAll(HttpServletRequest request)  {
		String categoryId = request.getParameter("categoryId");
		List<TpAttr> list = new ArrayList<TpAttr>();
		if (StringUtils.isEmpty(categoryId)) {
			list = D.sql("select * from t_p_attr ").many(TpAttr.class);
		} else {
			list = D.sql(
					"select t1.* from t_p_attr t1 where t1.attr_id not in  ( select attr_id from  t_p_category_attr t2 where  t2.attr_id = t1.attr_id  and t2.category_id in " +
					" (select t1.category_id  from  t_p_category t1 where t1.child_id = ? ) )")
					.many(TpAttr.class, categoryId);
		}
		return list;
	}
	/**
	 * 查询选中的属性信息
	 * @param request
	 * @return
	 * @throws BusinessException
	 */
	@RequestMapping("/listSelect")
	@ResponseBody
	public List<TpAttr> listSelect(HttpServletRequest request)  {
		String categoryId = request.getParameter("categoryId");
		List<TpAttr> list = new ArrayList<TpAttr>();
		if (!StringUtils.isEmpty(categoryId)) {
			list = D.sql(
					"select t1.* from  t_p_category_attr t2 left join t_p_attr t1 on t2.attr_id = t1.attr_id" +
					" where  t2.category_id in" +
					" (select t1.category_id  from  t_p_category_tree t1 where t1.child_id = ? ) order by t2.sort")
					.many(TpAttr.class, categoryId);
		}
		return list;
	}
	@RequestMapping("/check")
	@ResponseBody
	public boolean check(HttpServletRequest request) {
		try{
			String attrName =  request.getParameter("attrName") ;
			String attrId =  request.getParameter("attrId") ;
			if(!StringUtils.isEmpty(attrId)){
				List<TpAttr> categoryList = D.sql("select * from t_p_attr where attr_name = ? and attr_id != ?").many(TpAttr.class, attrName,attrId);
				if(categoryList.size()>0){
					return false;
				}
			}else{
				TpAttr attr = D.sql("select * from t_p_attr where attr_name = ?").oneOrNull(TpAttr.class, attrName);
				if(attr != null){
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
