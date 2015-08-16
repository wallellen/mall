package com.freelywx.common.wx.menu;

/** 
 * 复杂按钮（父按钮） 
 *  
 * @author liufeng 
 * @date 2013-08-08 
 */  
public class ComplexButton extends Button {  
    private Button[] sub_button;  

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	private String name;
  
    public Button[] getSub_button() {  
        return sub_button;  
    }  
  
    public void setSub_button(Button[] sub_button) {  
        this.sub_button = sub_button;  
    }  
} 