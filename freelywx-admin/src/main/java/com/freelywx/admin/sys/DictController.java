package com.freelywx.admin.sys;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.sys.SysDict;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

@Controller
@RequestMapping(value = "/sys/dict")
public class DictController {
	@RequestMapping()
	public String init(){
		return "sys/base/dict";
	}
	
	@RequestMapping(value="edit")
	public String edit(){
		return "sys/base/dict_edit";
	}
	/*
	 * 
	 * 显示-字典列表
	 */
	@ResponseBody
	@RequestMapping(value = "list")
	public PageModel list(HttpServletRequest request){
		return PageUtil.getPageModel(SysDict.class, "sql.sysdict/getPageDict",request);
	}
	/*
	 * 检查-字典信息是否合法
	 */
	@ResponseBody
	@RequestMapping(value = "check")
	public boolean check(String defaultId,String dictId) {
		if(!StringUtils.isEmpty(defaultId)){
			if(StringUtils.equals(defaultId, dictId)){
				return false;
			}
		}
		List<SysDict> list = D.sql("select * from t_sys_dict where dict_id = ?   ").many(SysDict.class, dictId);
		return list.size() > 0 ? true : false;
	}
	
	@ResponseBody
	@RequestMapping(value = "save/{type}")
	public boolean save(@RequestBody SysDict dict,@PathVariable("type") String type) {
		if(StringUtils.equals(type, "2")){
			D.updateWithoutNull(dict);
		}else{
			D.insert(dict);
		}
		
		return true;
	}
	
	/*
	 * 修改（之前）-根据字典编号查询出字典
	 */
	@ResponseBody
	@RequestMapping(value = "/{dictId}")
	public SysDict get(@PathVariable("dictId") String dictId){
		return D.selectById(SysDict.class, dictId);
	}
	 
	/*
	 * 删除-根据字典编号删除字典明细
	 */
	@ResponseBody
	@RequestMapping(value = "delete/{dictId}")
	public boolean delete(@PathVariable("dictId") String dictId){	
		D.deleteById(SysDict.class, dictId);
		return true;
	}
}
