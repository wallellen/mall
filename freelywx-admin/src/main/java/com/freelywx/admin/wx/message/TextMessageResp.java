package com.freelywx.admin.wx.message;

/**
 * 回复文本消息
 * <xml>
	<ToUserName><![CDATA[toUser]]></ToUserName>
	<FromUserName><![CDATA[fromUser]]></FromUserName>
	<CreateTime>12345678</CreateTime>
	<MsgType><![CDATA[text]]></MsgType>
	<Content><![CDATA[你好]]></Content>
	</xml>
 */
public class TextMessageResp extends MessageResp {
	// 回复的消息内容
	private String Content;

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}
}
