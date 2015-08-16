package com.freelywx.common.wx.message;

import java.util.HashMap;

/**
 * 音乐消息
	{
	    "touser":"OPENID",
	    "msgtype":"music",
	    "music":
	    {
	      "title":"MUSIC_TITLE",
	      "description":"MUSIC_DESCRIPTION",
	      "musicurl":"MUSIC_URL",
	      "hqmusicurl":"HQ_MUSIC_URL",
	      "thumb_media_id":"THUMB_MEDIA_ID" 
	    }
	}
 */
public class MumicMessageReq extends MessageReq{

	private HashMap<String,String> music;

	public HashMap<String,String> getMusic() {
		return music;
	}

	public void setMusic(HashMap<String,String> music) {
		this.music = music;
	}

	

	
	
}
