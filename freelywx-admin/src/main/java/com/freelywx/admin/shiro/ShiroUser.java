package com.freelywx.admin.shiro;

import java.io.Serializable;

import com.freelywx.common.model.store.TmSite;
import com.freelywx.common.model.sys.SysUser;
import com.freelywx.common.model.sys.TPMerchantWx;

/**
 * 自定义Authentication对象，使得Subject除了携带用户的登录名外还可以携带更多信息.
 */
public class ShiroUser extends SysUser implements Serializable {
	private static final long serialVersionUID = 1L;

	private String menuData;
	private TPMerchantWx merchantWx;
	//private TmSite site;

	public ShiroUser(Integer userId, String loginId, String userName,
			String userType ) {
		super.setUser_id(userId);
		super.setLogin_id(loginId);
		super.setUser_name(userName);
		super.setUser_type(userType);
		//super.setSite_id(siteId);
	}

	/**
	 * @return the menuData
	 */
	public String getMenuData() {
		return menuData;
	}

	/**
	 * @param menuData
	 *            the menuData to set
	 */
	public void setMenuData(String menuData) {
		this.menuData = menuData;
	}

	
	public TPMerchantWx getMerchantWx() {
		return merchantWx;
	}

	public void setMerchantWx(TPMerchantWx merchantWx) {
		this.merchantWx = merchantWx;
	}

	/*public TmSite getSite() {
		return site;
	}

	public void setSite(TmSite site) {
		this.site = site;
	}*/

}