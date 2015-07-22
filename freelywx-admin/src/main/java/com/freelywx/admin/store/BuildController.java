package com.freelywx.admin.store;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.store.TsiteBuilding;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

@Controller
@RequestMapping("/build")
public class BuildController {
	
	@RequestMapping("init")
	public String init() {
		return "store/build";//TmStore
	}
	
	@ResponseBody
	@RequestMapping("list")
	public PageModel SearchEmployees(HttpServletRequest request,HttpServletResponse response) throws Exception
	{ 		
		PageModel page = PageUtil.getPageModel(TsiteBuilding.class, "sql.store/getPageBuild", request);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete/{build_id}")
	public int delete(@PathVariable("build_id") Integer build_id) { 
		return D.deleteById(TsiteBuilding.class, build_id);
	}
	
	/*
	 * 修改（之前）-查询信息
	 */
	@ResponseBody
	@RequestMapping(value = "/{build_id}")
	public TsiteBuilding get(@PathVariable("build_id") Integer build_id) {
		TsiteBuilding u = D.selectById(TsiteBuilding.class, build_id);
		return u;
	}
	
	@RequestMapping("/edit")
	public String editCategory(HttpServletRequest request) {
		return "store/editbuild";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public boolean saveCategory(@RequestBody TsiteBuilding TsiteBuilding, HttpServletRequest request) {
		try {
			if (TsiteBuilding.getBuild_id() != null) {
				D.updateWithoutNull(TsiteBuilding);
			} else {
				D.insert(TsiteBuilding);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
