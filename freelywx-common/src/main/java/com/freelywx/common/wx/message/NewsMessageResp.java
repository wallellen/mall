package com.freelywx.common.wx.message;

import java.util.List;  


/** 
 * 图文消息响应 
 *  
	<xml>
	<ToUserName><![CDATA[toUser]]></ToUserName>
	<FromUserName><![CDATA[fromUser]]></FromUserName>
	<CreateTime>12345678</CreateTime>
	<MsgType><![CDATA[news]]></MsgType>
	<ArticleCount>2</ArticleCount>
	<Articles>
	<item>
	<Title><![CDATA[title1]]></Title> 
	<Description><![CDATA[description1]]></Description>
	<PicUrl><![CDATA[picurl]]></PicUrl>
	<Url><![CDATA[url]]></Url>
	</item>
	<item>
	<Title><![CDATA[title]]></Title>
	<Description><![CDATA[description]]></Description>
	<PicUrl><![CDATA[picurl]]></PicUrl>
	<Url><![CDATA[url]]></Url>
	</item>
	</Articles>
	</xml> 
 * @date 2013-09-25
 */  
public class NewsMessageResp extends MessageResp {  
    // 图文消息个数，限制为10条以内  
    private int ArticleCount;  
    // 多条图文消息信息，默认第一个item为大图  
    private List<ArticleResp> Articles;  
  
    public int getArticleCount() {  
        return ArticleCount;  
    }  
  
    public void setArticleCount(int articleCount) {  
        ArticleCount = articleCount;  
    }  
  
    public List<ArticleResp> getArticles() {  
        return Articles;  
    }  
  
    public void setArticles(List<ArticleResp> articles) {  
        Articles = articles;  
    }  
}  