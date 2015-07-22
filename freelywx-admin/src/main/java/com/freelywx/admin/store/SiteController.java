package com.freelywx.admin.store;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.model.store.TmSite;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

@Controller
@RequestMapping("/site")
public class SiteController {
	
	@RequestMapping("init")
	public String init() {
		return "store/site";//TmStore
	}
	
	@ResponseBody
	@RequestMapping("list")
	public PageModel SearchEmployees(HttpServletRequest request,HttpServletResponse response) throws Exception
	{ 		
		PageModel page = PageUtil.getPageModel(TmSite.class, "sql.store/getPageSite", request);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete/{site_id}")
	public boolean delete(@PathVariable("site_id") Integer site_id) { 
		return D.deleteById(TmSite.class, site_id) > 0;
	}
	
	/*
	 * 修改（之前）-查询信息
	 */
	@ResponseBody
	@RequestMapping(value = "/all")
	public List<TmSite> get(HttpServletRequest request, HttpServletResponse response) {
		String siteName = request.getParameter("site_name");
		String sql;
		if (StringUtils.isEmpty(siteName)) {
			sql = "select * from t_m_site   order by sort ";
			return D.sql(sql).many(TmSite.class);
		} else {
			sql = "select * from t_m_site where  site_name like ?  order by sort ";
			return D.sql(sql).many(TmSite.class, "%" + siteName + "%");
		}
	}
	/*
	 * 修改（之前）-查询信息
	 */
	@ResponseBody
	@RequestMapping(value = "/{site_id}")
	public TmSite get(@PathVariable("site_id") Integer site_id) {
		TmSite u = D.selectById(TmSite.class, site_id);
		return u;
	}
	
	@RequestMapping("/edit")
	public String editCategory(HttpServletRequest request) {
		return "store/editsite";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public boolean saveCategory(@RequestBody TmSite tmSite) {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		try {
			if (tmSite.getSite_id() != null) {
				D.updateWithoutNull(tmSite);
			} else {
				tmSite.setUser_id(user.getUser_id());
				D.insert(tmSite);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
