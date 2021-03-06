package com.freelywx.admin.sys;

import java.io.IOException;
import java.util.List;

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
import com.freelywx.common.model.sys.SysMenue;
import com.rps.util.D;

 
@Controller
@RequestMapping("/sys/menue")
public class MenueController {
	 
	@RequestMapping()
	public String init() {
		return "sys/rbac/menue";
	}
	
	@RequestMapping(value="edit")
	public String edit(){
		return "sys/rbac/menue_edit";
	}
	
	@ResponseBody
	@RequestMapping(value = "save")
	public boolean save(@RequestBody SysMenue menue) {
		//menue.setMenueId((int) seqService.getSeq(Menue.class));
		if (menue.getPar_menue_id() == 0) {
			menue.setPar_menue_id(1);
		}
		if(menue.getMenue_id()  > 0  ){
			D.updateWithoutNull(menue);
		}else{
			menue.setUser_type(SystemConstant.UserType.SYSTEM_USER);
			D.insert(menue);
		}
		return true;
	}
	
	/*
	 * 菜单管理：查询所有记录信息列表
	 * @param request
	 */
	@RequestMapping(value = "listAll")
	public void listAll(HttpServletRequest request,HttpServletResponse response)throws IOException {
		List<SysMenue> allMenue = D.sql("select * from t_sys_menue  order by sort ASC").many(SysMenue.class );
		for(SysMenue funOpt : allMenue){
			if(funOpt.getPar_menue_id() == 0){
				allMenue.remove(funOpt);
				break;
			}
		}
		IOUtils.write(JsonMapper.nonNullMapper().toJson(allMenue), response.getWriter());
	}

	/*
	 * 菜单管理：新增时验证菜单名称是否已经存在
	 * @param menueNm
	 * @return false :可以添加；true：验证失败
	 */
	@ResponseBody
	@RequestMapping(value = "check")
	public boolean check(String menueNm,String menuId) {
		if(!StringUtils.isEmpty(menuId)){
			SysMenue menue = D.selectById(SysMenue.class, Integer.parseInt(menuId));
			if(StringUtils.equals(menueNm, menue.getMenue_nm())){
				return false;
			}
		}
		List<SysMenue> list = D.sql("select * from t_sys_menue where menue_nm = ?  ").many(SysMenue.class, menueNm );
		return list.size() > 0 ? true : false;
	}

	/*
	 * 菜单管理：删除之前验证记录是否存在
	 * @param menueId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "fredelcheck/{menueId}")
	public boolean fredelcheck(@PathVariable("menueId") Integer menueId) {
		SysMenue menue = D.selectById(SysMenue.class, menueId);
		return menue!=null?true:false; 
	}
	
	/*
	 * 菜单管理：删除节点验证是否有子节点
	 * @param menueId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "checkChild/{menueId}")
	public boolean checkChild(@PathVariable("menueId") Integer menueId) {
		List<SysMenue> list = D.sql("select * from t_sys_menue where par_menue_id = ?").many(SysMenue.class, menueId);
		 return list.isEmpty();
	}


	/*
	 * 菜单管理：删除选中的节点
	 * @param menueId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "deleteMenue/{menueId}")
	public boolean deleteMenue(@PathVariable("menueId") Integer menueId) {
		D.deleteById(SysMenue.class, menueId);
	    return true;
	}

	/*
	 * 菜单管理：获取待更新记录信息
	 * @param menueId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getMenueById/{menueId}")
	public SysMenue getFunIds(@PathVariable("menueId") Integer menueId) {
		return D.selectById(SysMenue.class, menueId);
	}

}
