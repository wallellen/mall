package com.freelywx.common.model.pub;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_pub_keyword")
public class TPubKeyword {
	@Id
	@GenerateByDb
	private Integer keyword_id;

	/** 微信号标示 */
	private Integer wx_id;
	private Integer uid;

	private String keyword;

	/** 对应文本或者图文信息中的主键信息。 */
	private Integer content_id;

	/** 1、文本；2、单图文；3、多图文 */
	private String module;

	/** 1、完全匹配；2、包含匹配 */
	private String type;

	private Integer precisioninfo;

	public Integer getKeyword_id() {
		return keyword_id;
	}

	public void setKeyword_id(Integer keyword_id) {
		this.keyword_id = keyword_id;
	}

	public Integer getWx_id() {
		return wx_id;
	}

	public void setWx_id(Integer wx_id) {
		this.wx_id = wx_id;
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

	public Integer getContent_id() {
		return content_id;
	}

	public void setContent_id(Integer content_id) {
		this.content_id = content_id;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getPrecisioninfo() {
		return precisioninfo;
	}

	public void setPrecisioninfo(Integer precisioninfo) {
		this.precisioninfo = precisioninfo;
	}

}
