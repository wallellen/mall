package com.freelywx.admin.wx.message;

import java.util.HashMap;

/**
 * 文本消息
	{
	    "touser":"OPENID",
	    "msgtype":"text",
	    "text":
	    {
	        "content":"Hello World"
	    }
	}
 */
public class TextMessageReq extends MessageReq{

	private HashMap<String,String> text;

	public HashMap<String, String> getText() {
		return text;
	}

	public void setText(HashMap<String, String> text) {
		this.text = text;
	}
	
}
