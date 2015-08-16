package com.freelywx.common.wx.message;

/**
 * 发货通知
 */
public class DeliverMessageReq {
	// 消息内容
	private String appid;
	private String openid;
	private String transid;
	private String out_trade_no;
	private String deliver_timestamp;
	private String deliver_status;
	private String deliver_msg;
	private String app_signature;
	private String app_method;
	public String getAppid() {
		return appid;
	}
	public void setAppid(String appid) {
		this.appid = appid;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public String getTransid() {
		return transid;
	}
	public void setTransid(String transid) {
		this.transid = transid;
	}
	public String getOut_trade_no() {
		return out_trade_no;
	}
	public void setOut_trade_no(String out_trade_no) {
		this.out_trade_no = out_trade_no;
	}
	public String getDeliver_timestamp() {
		return deliver_timestamp;
	}
	public void setDeliver_timestamp(String deliver_timestamp) {
		this.deliver_timestamp = deliver_timestamp;
	}
	public String getDeliver_status() {
		return deliver_status;
	}
	public void setDeliver_status(String deliver_status) {
		this.deliver_status = deliver_status;
	}
	public String getDeliver_msg() {
		return deliver_msg;
	}
	public void setDeliver_msg(String deliver_msg) {
		this.deliver_msg = deliver_msg;
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
