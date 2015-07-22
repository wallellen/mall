package com.freelywx.common.model.pub;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_pub_attention")
public class TPubAttention {
	@Id
	@GenerateByDb
	private Integer id;

	private Integer uid;

	/** 微信号标示 */
	private Integer wx_id;

	private Integer keyword_id;

	private String keyword;

	private String content;

	/** 是否使用关键字关联 */
	private String is_key;

	/** 开始时间 */
	private Date start_time;

	/** 结束时间 */
	private Date end_time;

	/** 状态 */
	private String status;

	/** 1、关注回复；2、找不到对应关键字的时候回复消息 */
	private String type;

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

	public Integer getWx_id() {
		return wx_id;
	}

	public void setWx_id(Integer wx_id) {
		this.wx_id = wx_id;
	}

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIs_key() {
		return is_key;
	}

	public void setIs_key(String is_key) {
		this.is_key = is_key;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
