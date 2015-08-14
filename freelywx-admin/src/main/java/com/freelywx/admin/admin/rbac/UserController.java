package com.freelywx.admin.admin.rbac;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.sys.SysRole;
import com.freelywx.common.model.sys.SysUser;
import com.freelywx.common.model.sys.SysUserGroup;
import com.freelywx.common.model.sys.SysUserGroupUser;
import com.freelywx.common.model.sys.SysUserRole;
import com.freelywx.common.util.Digests;
import com.freelywx.common.util.Encodes;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.freelywx.common.util.Securities;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.rps.util.D;

/**
 * 用户控制器类
 * 方法上的注释为页面中Button的标题
 */
@Controller
@RequestMapping("/admin/user")
public class UserController {
	@RequestMapping()
	public String init() {
		return "admin/rbac/user";
	}
	
	@RequestMapping(value="toUpdateJsp")
	public String toUpdateJsp(){
		return "login";
	}
	@RequestMapping(value="add")
	public String toAdd(){
		return "admin/rbac/user_edit";
	}
	
	/*
	 * 显示-用户列表
	 */
	@ResponseBody
	@RequestMapping(value = "list")
	public PageModel list(HttpServletRequest request) {
		HashMap<String,Object> map = new  HashMap<String,Object>();
		map.put("user_type", SystemConstant.UserType.SYSTEM_USER);
		return PageUtil.getPageModel(SysUser.class, "sql.sysuser/getPageUser",request,map);
	}
	/*
	 * 检查-用户信息是否合法
	 */
	@ResponseBody
	@RequestMapping(value = "check")
	public boolean check(HttpServletRequest request) {
		String user_name = request.getParameter("user_name");
		String login_id = request.getParameter("login_id");
		SysUser user;
		if(!"".equals(user_name)){
			user = D.sql("select * from T_P_USER where LOGIN_ID = ? and user_name != ?").oneOrNull(SysUser.class, login_id,user_name);
		}else{
			user = D.sql("select * from T_P_USER where LOGIN_ID = ?").oneOrNull(SysUser.class, login_id);
		}
		if(user == null){
			return true;
		}else{
			return false;
		}
	}
	/*
	 * 添加用户.后台只能创建系统用户。
	 */
	@ResponseBody
	@RequestMapping(value = "save")
	public boolean save(@RequestBody final SysUser user){
		try{
			if(null != user.getUser_id() && user.getUser_id() > 0 ){
				user.setPwd(null);
				D.updateWithoutNull(user);
			}else{
				entryptPassword(user);
				user.setUser_type( SystemConstant.UserType.SYSTEM_USER);
				D.insert(user);
				/*D.startTranSaction(new Callable() {
					@Override
					public Object call() {
						int id = D.insertAndReturnInteger(user);
						if(StringUtils.equals(user.getUser_type(), SystemConstant.UserType.MERCHANT_USER)){
							//添加appcode 和appsecret
							WxMMerchant merchant = new WxMMerchant();
							merchant.setUser_id(id);
							merchant.setM_code(MerchantUtil.geneCode());
							merchant.setM_secret(MerchantUtil.geneSecret());
							D.insert(merchant);
						}
						return true;
					}
				});*/
			}
			
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	/*
	 * 修改用户（之前）-查询用户信息
	 */
	@ResponseBody
	@RequestMapping(value = "{userId}")
	public SysUser get(@PathVariable("userId") Long user_id) {
		SysUser u = D.selectById(SysUser.class, user_id);
		return u;
	}
	@ResponseBody
	@RequestMapping(value = "/delete/{userId}")
	public boolean delete(@PathVariable("userId") Long user_id) {
		SysUser u = D.selectById(SysUser.class, user_id);
		u.setUser_status(SystemConstant.UserStatus.DELETE);
		return D.updateWithoutNull(u) > 0;
	}
	
	/*
	 * 修改用户密码
	 * @param user
	 * @return
	 * zhangxiaomei
	 * 2013-10-18
	 */
	@ResponseBody
	@RequestMapping(value="updatePwd")
	public boolean updatePwd(SysUser user){
		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		try {
			user.setUser_id(loginUser.getUser_id());
			entryptPassword(user);
			//userService.updateByPrimaryKeySelective(user);
			D.updateWithoutNull(user);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	
	/*
	 * 绑定用户组（之前）-查出所有的用户组并将该用户组已有的用户默认选中n
	 */
	@ResponseBody
	@RequestMapping(value = "getAllUserGroup/{userId}")
	public List<Map<String, Object>> getAllUserGroup(@PathVariable("userId") Integer userId){
		// 1、查询出所有用户组
//		List<UserGroup> userGroupList = userGroupService.selectByExample(null);
		List<SysUserGroup> userGroupList = D.sql("select * from   T_P_USER_GRP  ").many(SysUserGroup.class);
		// 2、找出与用户组关联的信息
		List<SysUserGroupUser> keyList = D.sql("select * from   T_P_USER_GRP_USER where user_id = ?  ").many(SysUserGroupUser.class,userId);
		// 3、将与用户关联的用户组信息保存到Set中
		Set<Integer> userGroupUserSet = Sets.newHashSet();
		for (SysUserGroupUser key : keyList) {
			userGroupUserSet.add(key.getGrp_id());
		}
		// 4、初始化treeList
		List<Map<String, Object>> treeList = Lists.newArrayList();
		// 5、将与用户关联的用户组默认选中并添加到treeList中
		for (SysUserGroup userGroup : userGroupList) {
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", userGroup.getGrp_id());
			map.put("text", userGroup.getGrp_nm());
			if(userGroupUserSet.contains(userGroup.getGrp_id())){
				map.put("ischecked", true);
			}
			treeList.add(map);
		}
		return treeList;
	}
	/*
	 * 绑定用户组
	 */
	@ResponseBody
	@RequestMapping(value = "insertUesrGroupUser/{userId}")
	public boolean insertUesrGroupUser(@PathVariable("userId") final Integer userId, final Integer[] boundInfos){
		try{
			D.startTranSaction(new Callable() {
				@Override
				public Object call() {
					// TODO Auto-generated method stub
					// 1、删除已绑定的用户组信息
					D.sql("delete from  T_P_USER_GRP_USER where user_id = ?").update(userId);
					// 2、添加用户组用户
					if(boundInfos!=null){
						for(Integer grpId : boundInfos){
							SysUserGroupUser tp = new SysUserGroupUser();
							tp.setGrp_id(grpId);
							tp.setUser_id(userId);
							D.insert(tp);
						}
					}
					return true;
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
	@RequestMapping(value = "getAllRole/{uesrId}")
	public List<Map<String, Object>> getAllRole(
			@PathVariable("uesrId") Long uesrId) {
		// 1、查询出所有角色
		List<SysRole> roleList = D.sql("select * from T_P_ROLE where user_type = ? ").many(SysRole.class,SystemConstant.UserType.SYSTEM_USER);
		// 2、找出与用户角色关联的信息
		List<SysUserRole> keyList = D.sql("select * from T_P_USER_ROLE where user_id = ?").many(SysUserRole.class,uesrId);
		
		// 3、将与用户关联的角色编号保存到Set集合中
		Set<Integer> roleIdSet = Sets.newHashSet();
		for (SysUserRole key : keyList) {
			roleIdSet.add(key.getRole_id());
		}
		// 4、初始化treeList
		List<Map<String, Object>> treeList = Lists.newArrayList();
		
		// 5、将与用户角色关联的角色默认选中并添加到treeList中
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
	@RequestMapping(value = "insertUesrRole/{userId}")
	public boolean insertUesrGroupRole(@PathVariable("userId") final Integer userId,
			final Integer[] boundInfos) {
		try{
			D.startTranSaction(new Callable() {
				@Override
				public Object call() {
					// TODO Auto-generated method stub
					// 1、删除已绑定的用户组信息
					D.sql("delete from  T_P_USER_ROLE where user_id = ?").update(userId);
					// 2、添加用户组用户
					if(boundInfos!=null){
						for(Integer roleId : boundInfos){
							SysUserRole tp = new SysUserRole();
							tp.setRole_id(roleId);
							tp.setUser_id(userId);
							D.insert(tp);
						}
					}
					return true;
				}
			});
			return true;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
	 */
	private void entryptPassword(SysUser user) {
		byte[] salt = Digests.generateSalt(Securities.SALT_SIZE);
		user.setSalt(Encodes.encodeHex(salt));

		byte[] hashPassword = Digests.sha1(user.getPwd().getBytes(), salt, Securities.HASH_INTERATIONS);
		user.setPwd(Encodes.encodeHex(hashPassword));
	}
	
}
