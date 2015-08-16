package com.freelywx.common.wx.message;

/** 
 * 回复图片消息 
 *  
	<xml>
	<ToUserName><![CDATA[toUser]]></ToUserName>
	<FromUserName><![CDATA[fromUser]]></FromUserName>
	<CreateTime>12345678</CreateTime>
	<MsgType><![CDATA[image]]></MsgType>
	<Image>
	<MediaId><![CDATA[media_id]]></MediaId>
	</Image>
	</xml>
 * @author dll 
 * @date 2014-03-20 
 */  
public class ImageMessageResp extends MessageResp {  
    // 图片  
    private Image image;

	public Image getImage() {
		return image;
	}

	public void setImage(Image image) {
		this.image = image;
	}
}  