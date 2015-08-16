package com.freelywx.common.wx.message;

/**
 * 文本消息
 */
public class MessageReq{
	// 消息内容
	private String touser;
	private String msgtype;

	public String getTouser() {
		return touser;
	}

	public void setTouser(String touser) {
		this.touser = touser;
	}

	public String getMsgtype() {
		return msgtype;
	}

	public void setMsgtype(String msgtype) {
		this.msgtype = msgtype;
	}
	
}
