package com.freelywx.admin.admin.rbac;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.user.TPUser;
import com.freelywx.common.model.user.TpFunOpt;
import com.freelywx.common.model.user.TpRole;
import com.freelywx.common.model.user.TpRoleFunOpt;
import com.freelywx.common.model.user.TpUserRole;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.rps.util.D;

@Controller
@RequestMapping(value = "/admin/role")
public class RoleController {
 
	@RequestMapping()
	public String init() {
		return "admin/rbac/role";
	}

	@ResponseBody
	@RequestMapping(value = "listAll")
	public PageModel listAll(HttpServletRequest request) {
		/*
		 * RoleCriteria sc = Criterias.buildCriteria(RoleCriteria.class,
		 * request); return roleService.pageByExample(sc);
		 */
		HashMap<String,Object> map = new  HashMap<String,Object>();
		map.put("user_type", SystemConstant.UserType.SYSTEM_USER);
		return PageUtil.getPageModel(TpRole.class, "sql.tprole/getPageRole", request,map);
	}

	@ResponseBody
	@RequestMapping(value = "{roleId}")
	public TpRole get(@PathVariable("roleId") String roleId) {
		return D.selectById(TpRole.class, roleId);
	}

	@ResponseBody
	@RequestMapping(value = "checkRoleNm")
	public boolean checkRoleNm(HttpServletRequest request) {
		String roleNm = request.getParameter("role_nm");
		String roleId = request.getParameter("role_id");
		TPUser user;
		if(!StringUtils.isEmpty(roleId)){
			user = D.sql("select * from T_P_ROLE where role_id = ? and role_name != ?").oneOrNull(TPUser.class, roleId,roleNm);
		}else{
			user = D.sql("select * from T_P_ROLE where role_nm = ?").oneOrNull(TPUser.class, roleNm);
		}
		if(user == null){
			return true;
		}else{
			return false;
		}
	}

	@ResponseBody
	@RequestMapping(value = "create")
	public boolean create(@RequestBody TpRole role) {
		try {
			role.setUser_type(SystemConstant.UserType.SYSTEM_USER);
			D.insert(role);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@ResponseBody
	@RequestMapping(value = "update")
	public boolean update(@RequestBody TpRole role) {
		try {
			D.updateWithoutNull(role);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

 
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "allOpt/{roleId}")
	public List<Map<String, Object>> allOpt(@PathVariable("roleId") Integer roleId) {
		List<TpRoleFunOpt> funRoleList = D.sql("select * from T_P_ROLE_FUN_OPT   where role_id = ?").many(TpRoleFunOpt.class, roleId);
		
		Set<Integer> idList = Sets.newHashSet();// 已绑定资源Id
		for (TpRoleFunOpt key : funRoleList) {
			idList.add(key.getFun_opt_id());
		}

		List<TpFunOpt> list = D.sql("select *  from T_P_FUN_OPT where user_type = ? ").many(TpFunOpt.class,SystemConstant.UserType.SYSTEM_USER);
		Map<Integer, Map<String, Object>> allFunOptMap = Maps.newHashMap();
		List<Map<String, Object>> rootFunOptList = Lists.newArrayList();

		for (TpFunOpt opt : list) {
			Map<String, Object> node = Maps.newHashMapWithExpectedSize(3);
			int funOptId = opt.getFun_opt_id();
			node.put("id", funOptId);
			node.put("pid", opt.getParent_fun_opt_id());
			node.put("text", opt.getFun_opt_nm());
			if (idList.contains(funOptId)) {
				node.put("checked", true);
			}
			allFunOptMap.put(funOptId, node);
		}

		for (Map<String, Object> node : allFunOptMap.values()) {
			if (node.get("pid") != null) {
				int parentId =  (Integer) node.get("pid");
				Map<String, Object> parent = allFunOptMap.get(parentId);
				if (parent != null) {
					List<Map<String, Object>> children = (List<Map<String, Object>>) parent.get("children");
					if (children == null) {
						children = Lists.newArrayList();
						parent.put("children", children);
					}
					children.add(node);
				}
			} else {
				rootFunOptList.add(node);
			}
		}
		return rootFunOptList;
	}

	/*
	 * 角色管理：保存绑定资源 绑定资源前先删除已绑定资源
	 * 
	 * @param roleId
	 * 
	 * @param detailId
	 * 
	 * @return zhangxiaomei 2013-8-25
	 */
	@ResponseBody
	@RequestMapping(value = "customer_bund/{roleId}/{checkedId}")
	public boolean customer_bund(@PathVariable("roleId") final String roleId, @PathVariable("checkedId") final Integer[] detailId) {
		try{
			if (!StringUtils.isEmpty(roleId) && detailId.length > 0) {
				D.startTranSaction(new Callable() {
					@Override
					public Object call() {
						// TODO Auto-generated method stub
						D.sql("delete from T_P_ROLE_FUN_OPT where role_id = ?").update( roleId);
						for(Integer id : detailId){
							TpRoleFunOpt tp = new TpRoleFunOpt();
							tp.setRole_id(Integer.parseInt (roleId));
							tp.setFun_opt_id(id);
							D.insert(tp);
						}
						return null;
					}
				});
				return  true  ;
			}else{
				return false;
			}
		}catch (Exception e) {
			// TODO: handle exception
			return false;
		}
	}

	/*
	 * 角色管理：删除角色之前验证所选角色是否存在
	 * 
	 * @param roleId
	 * 
	 * @return zhangxiaomei 2013-8-24
	 */
	@ResponseBody
	@RequestMapping(value = "delCheckExits/{roleId}")
	public boolean delCheckExits(@PathVariable("roleId") Integer roleId) {
		TpRole role = D.selectById(TpRole.class, roleId);
		return role == null ? false : true;
	}

	/*
	 * 角色管理：验证是否有用户与此角色绑定
	 * 
	 * @param roleId
	 * 
	 * @return zhangxiaomei 2013-8-24
	 */
	@ResponseBody
	@RequestMapping(value = "roleCheckExits/{roleId}")
	public boolean roleCheckExits(@PathVariable("roleId") Integer roleId) {
		List<TpUserRole> userRoleKey = D.sql("select * from T_P_USER_ROLE where role_id = ?").many(TpUserRole.class, roleId);
		return userRoleKey.size() >0 ? false:true;
	}

	/*
	 * 角色管理：删除
	 * 
	 * @param roleId
	 * 
	 * @return zhangxiaomei 2013-8-25
	 */
	@ResponseBody
	@RequestMapping(value = "delete/{roleId}")
	public boolean delete(@PathVariable("roleId") String roleId) {
		D.sql("delete from T_P_ROLE where role_id = ? ").update(roleId);
		return true;
	}

}
