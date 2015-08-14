package com.freelywx.admin.admin.rbac;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.cache.DictCache;
import com.freelywx.common.model.sys.SysDictDetail;
import com.freelywx.common.util.PageModel;
import com.rps.util.D;

@Controller
@RequestMapping(value = "/admin/dictDetail")
public class DictDetailController {
	@Autowired
	DictCache dictCache;
	
	@RequestMapping("")
	public String init(String dictId,Model model){
		model.addAttribute("dictId", dictId);
		return "admin/base/dictDetail";
	}
	
	/*
	 * 显示-字典明细
	 */
	@ResponseBody
	@RequestMapping(value = "list")
	public PageModel list(String dictId){
		List<SysDictDetail> ddList = D.sql("select * from  T_B_DICT_DETAIL where dict_id = ?").many(SysDictDetail.class, dictId);
		return new PageModel(ddList.size(), ddList);
	}
	/*
	 * 添加
	 */
	@ResponseBody
	@RequestMapping(value = "create")
	public boolean create(@RequestBody SysDictDetail dictDetail){
		D.insert(dictDetail);
		dictCache.reload();
		return true;
	}
	/*
	 * 修改（之前）-根据字典编号查询出字典明细
	 */
	@ResponseBody
	@RequestMapping(value = "{dictId}/{dictParamValue}/{dictParamName}")
	public SysDictDetail get(@PathVariable("dictId") String dictId, 
			@PathVariable("dictParamValue") String dictParamValue, @PathVariable("dictParamName") String dictParamName){
		SysDictDetail d = D.sql("select * from T_B_DICT_DETAIL where dict_id = ? and dict_param_value = ?  ").oneOrNull(SysDictDetail.class,dictId,dictParamValue);
		return d;
	}
	/*
	 * 修改
	 */
	@ResponseBody
	@RequestMapping(value = "update")
	public boolean update(@RequestBody SysDictDetail dictDetail){
		try{
			D.updateWithoutNull(dictDetail);
			dictCache.reload();
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	/*
	 * 删除-根据字典编号删除字典明细
	 */
	@ResponseBody
	@RequestMapping(value = "delete/{dictId}/{dictParamValue}")
	public boolean delete(@PathVariable("dictId") String dictId, @PathVariable("dictParamValue") String dictParamValue){	
		D.sql("delete from T_B_DICT_DETAIL where dict_id = ? and dict_param_value = ?  ").update(dictId,dictParamValue);
		return true;
	}
	
	@ResponseBody
	@RequestMapping(value = "all")
	public List<SysDictDetail> listAll(String dictId){
		List<SysDictDetail> list = D.sql("select * from T_B_DICT_DETAIL where dict_id = ?").many(SysDictDetail.class, dictId);
		return list;
	}
}
