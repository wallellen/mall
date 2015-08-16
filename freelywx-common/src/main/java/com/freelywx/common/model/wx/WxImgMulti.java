package com.freelywx.common.model.wx;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_wx_img_multi")
public class WxImgMulti {
	@Id
	@GenerateByDb
	private Integer id;

	private String title;

	private String imgids;

	/** 匹配类型 1、完全匹配 2、模糊匹配 */
	private String match_type;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getImgids() {
		return imgids;
	}

	public void setImgids(String imgids) {
		this.imgids = imgids;
	}

	public String getMatch_type() {
		return match_type;
	}

	public void setMatch_type(String match_type) {
		this.match_type = match_type;
	}
}
