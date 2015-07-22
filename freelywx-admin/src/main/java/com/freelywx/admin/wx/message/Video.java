package com.freelywx.admin.wx.message;

/** 
 * 音乐model 
 *  
 * @author liufeng 
 * @date 2013-05-19 
 */  
public class Video {  
    private String Title;  
    private String Description;  
    //上传后获取的ID
    private String MediaId;  
  
    public String getTitle() {  
        return Title;  
    }  
  
    public void setTitle(String title) {  
        Title = title;  
    }  
  
    public String getDescription() {  
        return Description;  
    }  
  
    public void setDescription(String description) {  
        Description = description;  
    }

	public String getMediaId() {
		return MediaId;
	}

	public void setMediaId(String mediaId) {
		MediaId = mediaId;
	}  
}  