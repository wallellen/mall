package com.freelywx.common.model.wx;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_wx_keyword")
public class WxKeyword {
	/** 编号 */
	@Id
	@GenerateByDb
	private Integer keyword_id;

	/** 关键字 */
	private String keyword;

	/** 匹配类型 1、完全匹配 2、模糊匹配 */
	private String match_type;

	/** 回复编号 */
	private Integer reply_id;

	/** 内容类型.1、文本；2、图文；3、多图文 */
	private String reply_type;

	/** 备注 */
	private String remarks;

	/** 状态.根据需求可以增加审核状态 */
	private String status;

	public Integer getKeyword_id() {
		return keyword_id;
	}

	public void setKeyword_id(Integer keyword_id) {
		this.keyword_id = keyword_id;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getMatch_type() {
		return match_type;
	}

	public void setMatch_type(String match_type) {
		this.match_type = match_type;
	}

	public Integer getReply_id() {
		return reply_id;
	}

	public void setReply_id(Integer reply_id) {
		this.reply_id = reply_id;
	}

	public String getReply_type() {
		return reply_type;
	}

	public void setReply_type(String reply_type) {
		this.reply_type = reply_type;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
