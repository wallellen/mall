package com.freelywx.admin.wx.message;

import java.util.HashMap;

/**
 * 视频消息
	{
	    "touser":"OPENID",
	    "msgtype":"video",
	    "video":
	    {
	      "media_id":"MEDIA_ID",
	      "title":"TITLE",
	      "description":"DESCRIPTION"
	    }
	}
 */
public class VideoMessageReq extends MessageReq{

	private HashMap<String,String> video;

	public HashMap<String,String> getVideo() {
		return video;
	}

	public void setVideo(HashMap<String,String> video) {
		this.video = video;
	}

	
	
}
