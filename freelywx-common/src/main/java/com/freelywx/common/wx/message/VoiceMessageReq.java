package com.freelywx.common.wx.message;

import java.util.HashMap;

/**
 * 语音消息
	{
	    "touser":"OPENID",
	    "msgtype":"voice",
	    "voice":
	    {
	      "media_id":"MEDIA_ID"
	    }
	}
 */
public class VoiceMessageReq extends MessageReq{

	private HashMap<String,String> voice;

	public HashMap<String, String> getVoice() {
		return voice;
	}

	public void setVoice(HashMap<String, String> voice) {
		this.voice = voice;
	}
	
}
