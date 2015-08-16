package com.freelywx.common.model.wx;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_wx_info")
public class WxInfo  { 

	@Id
	@GenerateByDb
private Integer wx_id;

	/**公众号名称*/
	private String public_name;

	/**公众原始号ID*/
	private String original_id;

	/**微信号*/
	private String wx_number;

	private String token;

	private String app_id;

	private String app_secrect;

	private String encodekey;

	private String encodetype;

	/**默认无匹配回复关键词*/
	private String matching;

	/**图像地址*/
	private String img_url;

	/**接口地址*/
	private String port_url;

	/**公众号类型.1、订阅号；2、服务号*/
	private String public_type;

	private String qr_url;

	/**公众号详情说明.图文详情最下面的二维码及对应的文字说明*/
	private String wx_text;

	public Integer getWx_id() {
		return wx_id;
	}

	public void setWx_id(Integer wx_id) {
		this.wx_id = wx_id;
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

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getApp_id() {
		return app_id;
	}

	public void setApp_id(String app_id) {
		this.app_id = app_id;
	}

	public String getApp_secrect() {
		return app_secrect;
	}

	public void setApp_secrect(String app_secrect) {
		this.app_secrect = app_secrect;
	}

	public String getEncodekey() {
		return encodekey;
	}

	public void setEncodekey(String encodekey) {
		this.encodekey = encodekey;
	}

	public String getEncodetype() {
		return encodetype;
	}

	public void setEncodetype(String encodetype) {
		this.encodetype = encodetype;
	}

	public String getMatching() {
		return matching;
	}

	public void setMatching(String matching) {
		this.matching = matching;
	}

	public String getImg_url() {
		return img_url;
	}

	public void setImg_url(String img_url) {
		this.img_url = img_url;
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

	public String getWx_text() {
		return wx_text;
	}

	public void setWx_text(String wx_text) {
		this.wx_text = wx_text;
	}


}
