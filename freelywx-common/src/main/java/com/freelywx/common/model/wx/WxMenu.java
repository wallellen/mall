package com.freelywx.common.model.wx;

import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_wx_menu")
public class WxMenu {
	@Id
	private Integer menu_id;

	private String menu_name;

	private String type;

	private Integer sort;

	private String url;

	private Integer keyword_id;

	private Integer pid;

	public Integer getMenu_id() {
		return menu_id;
	}

	public void setMenu_id(Integer menu_id) {
		this.menu_id = menu_id;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getKeyword_id() {
		return keyword_id;
	}

	public void setKeyword_id(Integer keyword_id) {
		this.keyword_id = keyword_id;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

}
