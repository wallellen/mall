package com.freelywx.admin.wx.message;

/**
 * 订单查询
 */
public class OrderqueryMessageReq {
	private String appid;
	//json数据必须是package
	private String pack;
	private String timestamp;
	private String app_signature;
	private String app_method;
	public String getAppid() {
		return appid;
	}
	public void setAppid(String appid) {
		this.appid = appid;
	}
	public String getPack() {
		return pack;
	}
	public void setPack(String pack) {
		this.pack = pack;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public String getApp_signature() {
		return app_signature;
	}
	public void setApp_signature(String app_signature) {
		this.app_signature = app_signature;
	}
	public String getApp_method() {
		return app_method;
	}
	public void setApp_method(String app_method) {
		this.app_method = app_method;
	}
	
}
