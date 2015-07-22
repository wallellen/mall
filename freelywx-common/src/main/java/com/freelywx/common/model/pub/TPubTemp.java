package com.freelywx.common.model.pub;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_pub_temp")
public class TPubTemp {
	@Id
	@GenerateByDb
	private Integer id;

	private String tempkey;

	/** 模板名称 */
	private String tempname;

	/** 内容 */
	private String content;

	/** 头部颜色 */
	private String topcolor;

	/** 文字颜色 */
	private String textcolor;

	/** 微信后台模板ID */
	private String tempid;

	/** 状态 */
	private String status;

	/** 微信号标示 */
	private Integer wx_id;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTempkey() {
		return tempkey;
	}

	public void setTempkey(String tempkey) {
		this.tempkey = tempkey;
	}

	public String getTempname() {
		return tempname;
	}

	public void setTempname(String tempname) {
		this.tempname = tempname;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTopcolor() {
		return topcolor;
	}

	public void setTopcolor(String topcolor) {
		this.topcolor = topcolor;
	}

	public String getTextcolor() {
		return textcolor;
	}

	public void setTextcolor(String textcolor) {
		this.textcolor = textcolor;
	}

	public String getTempid() {
		return tempid;
	}

	public void setTempid(String tempid) {
		this.tempid = tempid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getWx_id() {
		return wx_id;
	}

	public void setWx_id(Integer wx_id) {
		this.wx_id = wx_id;
	}
}
