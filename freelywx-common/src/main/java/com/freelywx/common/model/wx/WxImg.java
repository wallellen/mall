package com.freelywx.common.model.wx;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_wx_img")
public class WxImg {
	/** 编号 */
	@Id
	@GenerateByDb
	private Integer id;

	/** 标题 */
	private String title;

	/** 图文标题 */
	private String content;

	/** 图片地址 */
	private String pic_url;

	/** 图文详情 */
	private String text_content;

	/** 链接地址 */
	private String link_url;

	/** 匹配类型 1、完全匹配 2、模糊匹配 */
	private String match_type;

	private String writer;

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

	public String getPic_url() {
		return pic_url;
	}

	public void setPic_url(String pic_url) {
		this.pic_url = pic_url;
	}

	public String getText_content() {
		return text_content;
	}

	public void setText_content(String text_content) {
		this.text_content = text_content;
	}

	public String getLink_url() {
		return link_url;
	}

	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}

	public String getMatch_type() {
		return match_type;
	}

	public void setMatch_type(String match_type) {
		this.match_type = match_type;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}
}
