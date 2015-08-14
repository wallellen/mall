package com.freelywx.admin.admin.merchant;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.common.JsonMapper;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.sys.SysFunOpt;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.rps.util.D;
@Controller
@RequestMapping(value = "/admin/merFunopt")
public class MerFunOptController {
 
	@RequestMapping()
	public String init() {
		return "admin/merRbac/merFunopt";
	}
 
	@RequestMapping(value = "listAll")
	public void listAll(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		List<SysFunOpt> allFunOpt = D.sql("Select * from T_P_FUN_OPT where user_type = ? ").many(SysFunOpt.class,SystemConstant.UserType.MERCHANT_USER);
		List<SysFunOpt> rootFunOpt = Lists.newArrayList();
		Map<Integer, SysFunOpt> allFunOptMap = Maps.newHashMap();

		for (SysFunOpt funOpt : allFunOpt) {
			allFunOptMap.put(funOpt.getFun_opt_id(), funOpt);
		}
		for (SysFunOpt funOpt : allFunOpt) {
			Integer parentId = funOpt.getParent_fun_opt_id();
			if (parentId != null) {
				SysFunOpt parent = allFunOptMap.get(parentId);
				if (parent != null) {
					if (parent.getChildren() == null) {
						parent.setChildren(new ArrayList<SysFunOpt>());
					}
					parent.getChildren().add(funOpt);
				}
			} else {
				rootFunOpt.add(funOpt);
			}
		}
		IOUtils.write(JsonMapper.nonNullMapper().toJson(allFunOpt), response.getWriter());
	}
	@RequestMapping(value="edit")
	public String edit(){
		return "admin/merRbac/merFunopt_edit";
	}
	
	@ResponseBody
	@RequestMapping(value = "save")
	public boolean save(@RequestBody SysFunOpt funopt) {
		if(funopt.getFun_opt_id()  != null  ){
			D.updateWithoutNull(funopt);
		}else{
			funopt.setUser_type(SystemConstant.UserType.MERCHANT_USER);
			D.insert(funopt);
		}
		
		return true;
	}
	 
	@ResponseBody
	@RequestMapping(value = "check")
	public boolean check(String fun_opt_nm,String fun_opt_id) {
		if(!StringUtils.isEmpty(fun_opt_id)){
			SysFunOpt funopt = D.selectById(SysFunOpt.class, Integer.parseInt(fun_opt_id));
			if(StringUtils.equals(fun_opt_nm, funopt.getFun_opt_nm())){
				return false;
			}
		}
		List<SysFunOpt> foList = D.sql("select * from T_P_FUN_OPT where fun_opt_nm = ?").many(SysFunOpt.class, fun_opt_nm);
		return foList.size() > 0 ? true : false;
	}
 
	@ResponseBody
	@RequestMapping(value = "checkUrl")
	public boolean checkUrl(String url,String fun_opt_id) { 
		if(!StringUtils.isEmpty(fun_opt_id)){
			SysFunOpt funopt = D.selectById(SysFunOpt.class, Integer.parseInt(fun_opt_id));
			if(StringUtils.equals(url, funopt.getUrl())){
				return false;
			}
		}
		List<SysFunOpt> foList = D.sql("select * from T_P_FUN_OPT where url = ?").many(SysFunOpt.class, url);
		return foList.size() > 0 ? true : false;
//		String regEx = "^[A-Za-z]+$";
//		Pattern pat = Pattern.compile(regEx);
//		Matcher mat = pat.matcher(url);
//		boolean rs = mat.find();
//		if(rs){
			
//		}
//		return false;
	} 

	@ResponseBody
	@RequestMapping(value = "getFunopt/{funOptId}")
	public SysFunOpt getFunopt(@PathVariable("funOptId") Long funOptId) {
		return D.selectById(SysFunOpt.class, funOptId);
	}

	@ResponseBody
	@RequestMapping(value = "update")
	public boolean update(@RequestBody SysFunOpt funopt) {
		D.updateWithoutNull(funopt);
		return true;
	}

	@ResponseBody
	@RequestMapping(value = "delFreCheck/{funOptId}")
	public boolean delFreCheck(@PathVariable("funOptId") Long funOptId) {
		SysFunOpt funopt = D.selectById(SysFunOpt.class, funOptId);
		return funopt == null ? false : true;
	}

	@ResponseBody
	@RequestMapping(value = "checkChild/{funOptId}")
	public boolean checkChild(@PathVariable("funOptId") Long funOptId) {
		List<SysFunOpt> list = D.sql("select * from T_P_FUN_OPT where parent_fun_opt_id = ?").many(SysFunOpt.class, funOptId);
		return list.isEmpty();
	}

	@ResponseBody
	@RequestMapping(value = "delete/{funOptId}")
	public boolean delete(@PathVariable("funOptId") Long funOptId) {
		D.deleteById(SysFunOpt.class, funOptId);
		return true;
	}

	@ResponseBody
	@RequestMapping("selFunopt")
	public List<Map<String, Object>> selFunopt() {
		List<Map<String, Object>> treeList = Lists.newArrayList(); 
		List<SysFunOpt> list = D.sql("select * from T_P_FUN_OPT where parent_fun_opt_id is not null and user_type = ? ").many(SysFunOpt.class, SystemConstant.UserType.MERCHANT_USER) ;
		for (SysFunOpt fo : list) {
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", fo.getFun_opt_id());
			map.put("text", fo.getFun_opt_nm());
			treeList.add(map);
		}
		return treeList;
	}
}
