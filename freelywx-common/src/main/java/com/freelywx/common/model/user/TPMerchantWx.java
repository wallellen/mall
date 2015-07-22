package com.freelywx.common.model.user;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_p_merchant_wx")
public class TPMerchantWx  { 

	@Id
	@GenerateByDb
	private Integer wx_id;

	/** 用户ID */
	private Integer user_id;

	/** 公众号名称 */
	private String public_name;

	/** 公众原始号ID */
	private String original_id;

	/** 微信号 */
	private String wx_number;

	private String app_id;

	private String app_secret;

	/** 消息加密模式 */
	private String encodetype;

	private String encodekey;

	private String matchinfo;

	private String lbs;

	private String token;

	/** 图像地址 */
	private String portrait_url;

	/** 接口地址 */
	private String port_url;

	/** 公众号类型.1、订阅号；2、服务号 */
	private String public_type;

	private String qr_url;

	/** 公众号详情说明.图文详情最下面的二维码及对应的文字说明 */
	private String ur_text;

	public Integer getWx_id() {
		return wx_id;
	}

	public void setWx_id(Integer wx_id) {
		this.wx_id = wx_id;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getPublic_name() {
		return public_name;
	}

	public void setPublic_name(String public_name) {
		this.public_name = public_name;
	}

	public String getOriginal_id() {
		return original_id;
	}

	public void setOriginal_id(String original_id) {
		this.original_id = original_id;
	}

	public String getWx_number() {
		return wx_number;
	}

	public void setWx_number(String wx_number) {
		this.wx_number = wx_number;
	}

	public String getApp_id() {
		return app_id;
	}

	public void setApp_id(String app_id) {
		this.app_id = app_id;
	}

	public String getApp_secret() {
		return app_secret;
	}

	public void setApp_secret(String app_secret) {
		this.app_secret = app_secret;
	}

	public String getEncodetype() {
		return encodetype;
	}

	public void setEncodetype(String encodetype) {
		this.encodetype = encodetype;
	}

	public String getEncodekey() {
		return encodekey;
	}

	public void setEncodekey(String encodekey) {
		this.encodekey = encodekey;
	}

	public String getMatchinfo() {
		return matchinfo;
	}

	public void setMatchinfo(String matchinfo) {
		this.matchinfo = matchinfo;
	}

	public String getLbs() {
		return lbs;
	}

	public void setLbs(String lbs) {
		this.lbs = lbs;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getPortrait_url() {
		return portrait_url;
	}

	public void setPortrait_url(String portrait_url) {
		this.portrait_url = portrait_url;
	}

	public String getPort_url() {
		return port_url;
	}

	public void setPort_url(String port_url) {
		this.port_url = port_url;
	}

	public String getPublic_type() {
		return public_type;
	}

	public void setPublic_type(String public_type) {
		this.public_type = public_type;
	}

	public String getQr_url() {
		return qr_url;
	}

	public void setQr_url(String qr_url) {
		this.qr_url = qr_url;
	}

	public String getUr_text() {
		return ur_text;
	}

	public void setUr_text(String ur_text) {
		this.ur_text = ur_text;
	}
}
