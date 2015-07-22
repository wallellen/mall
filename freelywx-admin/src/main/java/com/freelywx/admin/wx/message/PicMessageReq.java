package com.freelywx.admin.wx.message;

import java.util.HashMap;

/**
 * 图片消息
	{
	    "touser":"OPENID",
	    "msgtype":"image",
	    "image":
	    {
	      "media_id":"MEDIA_ID"
	    }
	}
 */
public class PicMessageReq extends MessageReq{

	private HashMap<String,String> image;

	public HashMap<String,String> getImage() {
		return image;
	}

	public void setImage(HashMap<String,String> image) {
		this.image = image;
	}

	
	
}
