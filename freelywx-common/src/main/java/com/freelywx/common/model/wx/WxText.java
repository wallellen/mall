package com.freelywx.common.model.wx;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_wx_text")
public class WxText {
	/** 主键 */
	@Id
	@GenerateByDb
	private Integer id;

	/** 标题 */
	private String title;

	/** 回复内容 */
	private String content;

	/** 匹配类型 1、完全匹配 2、模糊匹配 */
	private String match_type;

	/** 状态 */
	private String status;

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMatch_type() {
		return match_type;
	}

	public void setMatch_type(String match_type) {
		this.match_type = match_type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
