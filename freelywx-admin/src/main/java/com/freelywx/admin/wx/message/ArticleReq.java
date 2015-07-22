package com.freelywx.admin.wx.message;

/** 
 * 图文model 
 *  
 * @date 2013-09-25
 */  
public class ArticleReq {  
    // 图文消息名称  
    private String title;  
    // 图文消息描述  
    private String description;  
    // 图片链接，支持JPG、PNG格式，较好的效果为大图640*320，小图80*80，限制图片链接的域名需要与开发者填写的基本资料中的Url一致  
    private String picurl;  
    // 点击图文消息跳转链接  
    private String url;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}  
  
}  