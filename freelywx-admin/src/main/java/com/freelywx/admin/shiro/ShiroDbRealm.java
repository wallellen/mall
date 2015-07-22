package com.freelywx.admin.shiro;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import com.freelywx.common.common.JsonMapper;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.store.TmSite;
import com.freelywx.common.model.user.TPMerchantWx;
import com.freelywx.common.model.user.TPUser;
import com.freelywx.common.model.user.TpMenue;
import com.freelywx.common.util.Encodes;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.rps.util.D;

public class ShiroDbRealm extends AuthorizingRealm {

	private static final String HASH_ALGORITHM = "SHA-1";

	private static final int HASH_INTERATIONS = 1024;

	/**
	 * 认证回调函数,登录时调用.
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		CaptchaUsernamePasswordToken token = (CaptchaUsernamePasswordToken) authcToken;
		TPUser user = getUserByLoginId(token.getUsername());
		if (user != null) {
			// 增加判断验证码逻辑
			/*String captcha = token.getCaptcha();
			String exitCode = (String) SecurityUtils.getSubject().getSession().getAttribute(CaptchaServlet.KEY_CAPTCHA);
			if (null == captcha || !captcha.equalsIgnoreCase(exitCode)) {
				throw new CaptchaException("验证码错误");
			}*/
			ShiroUser shiroUser = new ShiroUser(user.getUser_id(),
					user.getLogin_id(), user.getUser_name(),user.getUser_type(),user.getSite_id());
			shiroUser.setMenuData(JsonMapper.nonEmptyMapper().toJson(getMenuList(user.getUser_id(),user.getUser_type())));
			
			//如果为商户类型，则插入商户信息
			if(StringUtils.equals( shiroUser.getUser_type(),SystemConstant.UserType.MERCHANT_USER)){
				TmSite site = D.sql("select * from t_m_site where site_id = ? ").oneOrNull(TmSite.class, shiroUser.getSite_id());
				shiroUser.setSite(site);
			}else{
				TPMerchantWx merchantWx = D.sql("select * from  t_p_merchant_wx where user_id = ? ").oneOrNull(TPMerchantWx.class, shiroUser.getUser_id());
				shiroUser.setMerchantWx(merchantWx);
			}
			byte[] salt = Encodes.decodeHex(user.getSalt());
			return new SimpleAuthenticationInfo(shiroUser, user.getPwd(),
					ByteSource.Util.bytes(salt), getName());
		} else {
			throw new AccountException(
					"Null usernames are not allowed by this realm.");
		}
	}

	/**
	 * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用.
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		System.out.println("鉴权");
		ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		List roleNameList = D.sqlAt("sql.tprole/getRoleName").many(String.class, shiroUser.getUser_id(),shiroUser.getUser_id());
		List funOptUrlList = D.sqlAt("sql.tprole/getOptUrl").many(String.class, shiroUser.getUser_id(),shiroUser.getUser_id());;
		info.setRoles(Sets.newLinkedHashSet(roleNameList));
		 info.setStringPermissions(Sets.newLinkedHashSet(funOptUrlList));
		return info;
	}

	/**
	 * 设定Password校验的Hash算法与迭代次数.
	 */
	@PostConstruct
	public void initCredentialsMatcher() {
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher(
				HASH_ALGORITHM);
		matcher.setHashIterations(HASH_INTERATIONS);
		setCredentialsMatcher(matcher);
	}

	private TPUser getUserByLoginId(String loginId) {
		return D.sql("select * from  T_P_USER where login_id = ? ").oneOrNull(TPUser.class, loginId);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	private Collection getMenuList(Integer userId,String userType) {
		// 查询根节点
		List<TpMenue> rootMenuList = D.sql("select * from T_P_MENUE where par_menue_id = 1 and user_type = ?  order by MENUE_ORDER").many(TpMenue.class,userType);
		Map<Integer, String> rootMenuMap = Maps.newLinkedHashMap();
		for (TpMenue root : rootMenuList) {
			rootMenuMap.put(root.getMenue_id(), root.getMenue_nm());
		}
		// 查询该用户可访问的菜单
		Map result = Maps.newLinkedHashMap();
		try {
			List<Map> menuMap = D.sqlAt("sql.tprole/getMenueByUserId").many(Map.class, userId,userId);
			for (Map<String, Object> map : menuMap) {
				// Integer parMenueId =	// ((BigDecimal)map.get("PAR_MENUE_ID")).toBigInteger().intValue();
				Integer parMenueId = ((Integer) map.get("PAR_MENUE_ID"));
				Map parMenue = (Map) result.get(parMenueId);
				if (parMenue == null) {
					String menueName = rootMenuMap.get(parMenueId);
					if (menueName == null) {
						continue;
					}
					parMenue = ImmutableMap.of("text", menueName, "isexpand",
							false, "children", Lists.newArrayList());
					result.put(parMenueId, parMenue);
				}
				((List) parMenue.get("children")).add(ImmutableMap.of("id",
						map.get("MENUE_ID"), "url", map.get("URL"), "text",
						map.get("MENUE_NM")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.values();
	}

}
