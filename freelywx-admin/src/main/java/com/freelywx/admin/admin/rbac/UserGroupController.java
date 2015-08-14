package com.freelywx.admin.admin.rbac;

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

import com.freelywx.common.model.sys.SysRole;
import com.freelywx.common.model.sys.SysUser;
import com.freelywx.common.model.sys.SysUserGroup;
import com.freelywx.common.model.sys.SysUserGroupRole;
import com.freelywx.common.model.sys.SysUserGroupUser;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.rps.util.D;

/**
 * 用户组控制器类
 * 方法上的注释为页面中Button的标题
 */
@Controller
@RequestMapping(value = "/admin/userGroup")
public class UserGroupController {

	@RequestMapping()
	public String init() {
		return "admin/rbac/userGroup";
	}
	/*
	 * 显示-用户组列表
	 */
	@ResponseBody
	@RequestMapping(value = "list")
	public PageModel list(HttpServletRequest request) {
		return PageUtil.getPageModel(SysUserGroup.class, "sql.sysuserGroupUser/getPageUserGroup",request);
	}
	/*
	 * 检查-用户组信息是否合法
	 */
	@ResponseBody
	@RequestMapping(value = "check")
	public boolean check(String grpNm) {
		List<SysUserGroup> list = D.sql("select * from T_P_USER_GRP where grp_nm = ?").many(SysUserGroup.class, grpNm);
		return list.isEmpty();
	}
	
	/*
	 * 添加用户组
	 */
	@ResponseBody
	@RequestMapping(value = "create")
	public boolean create(@RequestBody SysUserGroup userGroup) {
		//userGroup.setGrpId(seqService.getSeq(UserGroup.class));
		D.insert(userGroup);
		return true;
	}
	/*
	 * 修改用户组（之前）-查询用户组信息
	 */
	@ResponseBody
	@RequestMapping(value = "{grpId}")
	public SysUserGroup get(@PathVariable("grpId") Long grpId) {
		return D.selectById(SysUserGroup.class, grpId);
	}
	/*
	 * 修改用户组
	 */
	@ResponseBody
	@RequestMapping(value = "update")
	public boolean update(@RequestBody  SysUserGroup userGroup) {
		try {
			D.updateWithoutNull(userGroup);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	/*
	 * 删除用户组-根据用户组编号删除用户组
	 */
	@ResponseBody
	@RequestMapping(value = "delete/{grpId}")
	public boolean delete(@PathVariable("grpId") Long grpId) {
		//1、判断该用户组中是否已绑定有用户
		List<SysUserGroupUser> list = D.sql("select * from T_P_USER_GRP_USER where grp_id = ?").many(SysUserGroupUser.class, grpId);
		if(list.size() > 0){
			return false;
		}		
		//2、删除未绑定用户的用户组
		D.deleteById(SysUserGroup.class, grpId);
		return true;
	}
	/*
	 * 查看用户（之前）-检查该用户组中是否有关联的用户信息
	 */
	@ResponseBody
	@RequestMapping(value ="checkExits/{grpId}")
	public boolean checkExits(@PathVariable("grpId") Long grpId){
		List<SysUserGroupUser> list = D.sql("select * from T_P_USER_GRP_USER where grp_id = ?").many(SysUserGroupUser.class, grpId);
		return list.isEmpty();
	}
	/*
	 * 查看用户-根据用户组编号查询该用户组下的所有用户登录名称
	 */
	@ResponseBody
	@RequestMapping(value = "getUserNameByGrpId/{grpId}")
	public List<Map<String, Object>> getUserNameByGrpId(@PathVariable("grpId") String grpId) {
		// 1、查询出所有的用户登录名称和用户状态
		List<SysUser> userList = D.sql("select * from T_P_USER where user_id in (select user_id from T_P_USER_GRP_USER where grp_id = ?)").many(SysUser.class, grpId);
		// 2、初始化treeList
		List<Map<String, Object>> treeList = Lists.newArrayList();
		// 3、将用户分为有有效和无效的保存到treeList中
		for (SysUser user : userList) {
			Map<String, Object> map = Maps.newHashMap();
			if("1".equals(user.getUser_status())){ 
				map.put("text", user.getLogin_id());
			}else{	//无效
				map.put("text", user.getUser_name()+"(无效)");
			}			
			treeList.add(map);
		}
		// 4、返回treeList
		return treeList;
	}
	/*
	 * 绑定用户（之前）-查出所有用户并将该用户组已有用户默认选中
	 */
	@ResponseBody
	@RequestMapping(value = "getAllUser/{grpId}")
	public List<Map<String, Object>> getAllUser(@PathVariable("grpId") Integer grpId){
		// 1、查询出所有用户
		List<SysUser> userList = D.sql("select * from T_P_USER").many(SysUser.class);
		
		// 2、找出与用户组用户关联的信息
		List<SysUserGroupUser> list = D.sql("select * from T_P_USER_GRP_USER where grp_id = ?").many(SysUserGroupUser.class, grpId);
		
		// 3、将用户组用户关联的用户编号保存到Set集合中
		Set<Integer> userIdSet = Sets.newHashSet();
		for (SysUserGroupUser key : list) {
			userIdSet.add(key.getUser_id());
		}
		
		// 4、初始化treeList
		List<Map<String, Object>> treeList = Lists.newArrayList();
		
		// 5、将与用户组用户关联的用户默认选中并添加到treeList中
		for (SysUser user : userList) {
			if("1".equals(user.getUser_status())){ //有效用户
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", user.getUser_id());
				map.put("loginId", user.getLogin_id());
				map.put("userName", user.getUser_name());
				if(userIdSet.contains(user.getUser_id())){
					map.put("ischecked", true);
				}
				treeList.add(map);
			}			
		}
		
		return treeList;
	}
	/*
	 * 绑定用户
	 */
	@ResponseBody
	@RequestMapping(value = "insertUesrGroupUser/{grpId}")
	public boolean insertUesrGroupUser(@PathVariable("grpId") final Integer grpId, final Integer[] userIds) {		
		try{
			D.startTranSaction(new Callable() {
				@Override
				public Object call() {
					// TODO Auto-generated method stub
					D.sql("delete from T_P_USER_GRP_USER where grp_id = ?").update(grpId);
					for(Integer userId : userIds){
						SysUserGroupUser tp = new SysUserGroupUser();
						tp.setGrp_id(grpId);
						tp.setUser_id(userId);
						D.insert(tp);
					}
					return null;
				}
			});
			return true;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}
	/*
	 * 绑定角色（之前）-查出所有角色并将该用户组已有角色默认选中
	 */
	@ResponseBody
	@RequestMapping(value = "getAllRole/{grpId}")
	public List<Map<String, Object>> getAllRole(@PathVariable("grpId") Long grpId) {
		// 1、查询出所有角色
		List<SysRole> roleList = D.selectAll(SysRole.class);
		
		// 2、找出与用户组角色关联的信息
		List<SysUserGroupRole> keyList = D.sql("select * from T_P_USER_GRP_ROLE where grp_id = ?").many(SysUserGroupRole.class, grpId);
		
		// 3、将与用户组角色关联的角色编号保存到Set集合中
		Set<Integer> roleIdSet = Sets.newHashSet();
		for (SysUserGroupRole key : keyList) {
			roleIdSet.add(key.getRole_id());
		}
		
		// 4、初始化treeList
		List<Map<String, Object>> treeList = Lists.newArrayList();
		
		// 5、将与用户组角色关联的角色默认选中并添加到treeList中
		for (SysRole role : roleList) {
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", role.getRole_id());
			map.put("text", role.getRole_nm());
			if (roleIdSet.contains(role.getRole_id())) {
				map.put("ischecked", true);
			}
			treeList.add(map);
		}

		return treeList;
	}
	/*
	 * 绑定角色
	 */
	@ResponseBody
	@RequestMapping(value = "insertUesrGroupRole/{grpId}")
	public boolean insertUesrGroupRole(@PathVariable("grpId") final Integer grpId, final Integer[] roleIds) {		
		// 添加用户组角色
		//userGroupRoleService.insertUesrGroupRole(grpId, roleIds);	
		try{
			D.startTranSaction(new Callable() {
				@Override
				public Object call() {
					// TODO Auto-generated method stub
					D.sql("delete from T_P_USER_GRP_ROLE where grp_id = ?").update(grpId);
					for(Integer roleId : roleIds){
						SysUserGroupRole tp = new SysUserGroupRole();
						tp.setGrp_id(grpId);
						tp.setRole_id(roleId);
						D.insert(tp);
					}
					return null;
				}
			});
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
