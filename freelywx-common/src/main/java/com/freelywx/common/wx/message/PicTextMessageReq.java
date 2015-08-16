package com.freelywx.common.wx.message;

import java.util.HashMap;

/**
 * 图文消息
{
    "touser":"OPENID",
    "msgtype":"news",
    "news":{
        "articles": [
         {
             "title":"Happy Day",
             "description":"Is Really A Happy Day",
             "url":"URL",
             "picurl":"PIC_URL"
         },
         {
             "title":"Happy Day",
             "description":"Is Really A Happy Day",
             "url":"URL",
             "picurl":"PIC_URL"
         }
         ]
    }
}
 */
public class PicTextMessageReq extends MessageReq{

	private HashMap<String,Object> news;

	public HashMap<String,Object> getNews() {
		return news;
	}

	public void setNews(HashMap<String,Object> news) {
		this.news = news;
	}
	
}
