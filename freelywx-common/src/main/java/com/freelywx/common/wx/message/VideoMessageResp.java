package com.freelywx.common.wx.message;

/** 
 * 视频消息 
 *  
	<xml>
	<ToUserName><![CDATA[toUser]]></ToUserName>
	<FromUserName><![CDATA[fromUser]]></FromUserName>
	<CreateTime>12345678</CreateTime>
	<MsgType><![CDATA[video]]></MsgType>
	<Video>
	<MediaId><![CDATA[media_id]]></MediaId>
	<Title><![CDATA[title]]></Title>
	<Description><![CDATA[description]]></Description>
	</Video> 
	</xml>
 * @date 2013-05-19 
 */  
public class VideoMessageResp extends MessageResp {  
    // 视频  
    private Video Video;

	public Video getVideo() {
		return Video;
	}

	public void setVideo(Video video) {
		Video = video;
	}

	
  
      
}  