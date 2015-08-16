package com.freelywx.common.model.wx;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_wx_attention")
public class WxAttention {
	/** 主键 */
	@Id
	@GenerateByDb
	private Integer attention_id;
	private String title;

	/** 回复ID.根据类型对应文本回复或者图文回复 */
	private Integer keyword_id;

	/** 开始时间 */
	private Date start_time;

	/** 结束时间 */
	private Date end_time;

	/** 是否为默认推送消息。在未找到关键的时候，推送此消息。 */
	private String is_default;

	/** 状态1、有效；2、无效 */
	private String status;

	public Integer getAttention_id() {
		return attention_id;
	}

	public void setAttention_id(Integer attention_id) {
		this.attention_id = attention_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getKeyword_id() {
		return keyword_id;
	}

	public void setKeyword_id(Integer keyword_id) {
		this.keyword_id = keyword_id;
	}

	public Date getStart_time() {
		return start_time;
	}

	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}

	public Date getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}

	public String getIs_default() {
		return is_default;
	}

	public void setIs_default(String is_default) {
		this.is_default = is_default;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
