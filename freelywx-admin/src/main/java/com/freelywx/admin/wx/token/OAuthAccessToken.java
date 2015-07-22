package com.freelywx.admin.wx.token;

import java.util.Date;

import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.freelywx.admin.wx.utils.WeixinUtil;

 
public class OAuthAccessToken {
	private static final Logger logger = LoggerFactory
			.getLogger(OAuthAccessToken.class);
	// 获取到的凭证
	private String access_token;
	// 凭证有效时间，单位：秒
	private int expires_in;
	private String refresh_token;
	private String openid;
	private String scope;

	// 获取凭证的时间
	private Date createTime;
	// 获取凭证时的code
	private String code;
	private static Object lock = new Object();
	private static OAuthAccessToken instance = null;

	public OAuthAccessToken() {

	}

	/**
	 * @param code
	 * @param appid
	 * @param appsecret
	 * @return
	 */
	public static OAuthAccessToken getInstance(String code, String appid,
			String appsecret) {
		synchronized (lock) {
			try {
				if (instance == null) {
					instance = WeixinUtil.getOpenId(code, appid, appsecret);
				} else {
					// 判断code是否一样
					String oldCode = instance.getCode();
					// 刷新页面时code不变
					if (oldCode.equals(code)) {
						// 如果已过期重新获取实例
						logger.info("refresh get OAuthAccessToken ");
						Date date = instance.getCreateTime();
						int expiresIn = instance.getExpires_in();
						Date now = new Date();
						if (DateUtils.addSeconds(date, expiresIn).before(now)) {
							instance = WeixinUtil.getOpenId(code, appid,
									appsecret);
						}
					} else {
						// 不相等时才重新调用
						logger.info(" OAuthAccessToken still has");
						instance = WeixinUtil.getOpenId(code, appid, appsecret);
					}
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				logger.error("get OAuthAccessToken error");
			}

		}
		logger.info("=======================================get OAuthAccessToken11 end-------------------------");
		return instance;
	}

	public String getAccess_token() {
		return access_token;
	}

	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}

	public int getExpires_in() {
		return expires_in;
	}

	public void setExpires_in(int expires_in) {
		this.expires_in = expires_in;
	}

	public String getRefresh_token() {
		return refresh_token;
	}

	public void setRefresh_token(String refresh_token) {
		this.refresh_token = refresh_token;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getScope() {
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public String toString() {
		return "OAuthAccessToken [access_token=" + access_token
				+ ", expires_in=" + expires_in + ", refresh_token="
				+ refresh_token + ", openid=" + openid + ", scope=" + scope
				+ ", createTime=" + createTime + ", code=" + code + "]";
	}

}