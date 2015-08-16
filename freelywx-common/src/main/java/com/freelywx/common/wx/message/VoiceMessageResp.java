package com.freelywx.common.wx.message;

/** 
 * 语音消息 
	<xml>
	<ToUserName><![CDATA[toUser]]></ToUserName>
	<FromUserName><![CDATA[fromUser]]></FromUserName>
	<CreateTime>12345678</CreateTime>
	<MsgType><![CDATA[voice]]></MsgType>
	<Voice>
	<MediaId><![CDATA[media_id]]></MediaId>
	</Voice>
	</xml>
 * @author dll 
 * @date 2014-03-20 
 */  
public class VoiceMessageResp extends MessageResp {  
    //语音  
    private Voice Voice;

	public Voice getVoice() {
		return Voice;
	}

	public void setVoice(Voice voice) {
		Voice = voice;
	}  
  
   
}  