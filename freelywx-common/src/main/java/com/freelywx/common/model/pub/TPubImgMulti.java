package com.freelywx.common.model.pub;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_pub_img_multi")
public class TPubImgMulti {
	@Id
	@GenerateByDb
	private Integer id;

	private Integer uid;
	
	/** 微信号标示 */
	private Integer wx_id;

	private String keyword;

	private String imgids;

	
	/**微信用户的用户名**/
	@ColumnIgnore
	private String public_name;
	
	public String getPublic_name() {
		return public_name;
	}

	public void setPublic_name(String public_name) {
		this.public_name = public_name;
	}

	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getImgids() {
		return imgids;
	}

	public void setImgids(String imgids) {
		this.imgids = imgids;
	}

	public Integer getWx_id() {
		return wx_id;
	}

	public void setWx_id(Integer wx_id) {
		this.wx_id = wx_id;
	}
}
