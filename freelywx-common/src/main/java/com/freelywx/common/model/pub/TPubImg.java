package com.freelywx.common.model.pub;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_pub_img")
public class TPubImg {
	@Id
	@GenerateByDb
	private Integer id;

	private Integer uid;

	/** 微信号标示 */
	private Integer wx_id;

	private String keyword;

	/** 内容简介 */
	private String remark;

	/** 分类ID */
	private Integer classid;

	private Integer csort;

	private String classname;

	private String pic;

	/** 详细页是否显示封面 */
	private String show_pic;

	/** 图文详细内容 */
	private String content;

	/** 图文外链地址 */
	private String url;

	/** 标题 */
	private String title;

	/** 图文在本微信号排序 */
	private Integer sort;

	/** 作者 */
	private String writer;

	private String longitude;

	private String latitude;

	private Integer click;

	private Integer texttype;

	/** 匹配类型 */
	private String type;

	private Integer usorts;

	private Integer precisions;
	
	

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

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getClassid() {
		return classid;
	}

	public void setClassid(Integer classid) {
		this.classid = classid;
	}

	public Integer getCsort() {
		return csort;
	}

	public void setCsort(Integer csort) {
		this.csort = csort;
	}

	public String getClassname() {
		return classname;
	}

	public void setClassname(String classname) {
		this.classname = classname;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public String getShow_pic() {
		return show_pic;
	}

	public void setShow_pic(String show_pic) {
		this.show_pic = show_pic;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public Integer getClick() {
		return click;
	}

	public void setClick(Integer click) {
		this.click = click;
	}

	public Integer getTexttype() {
		return texttype;
	}

	public void setTexttype(Integer texttype) {
		this.texttype = texttype;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getUsorts() {
		return usorts;
	}

	public void setUsorts(Integer usorts) {
		this.usorts = usorts;
	}

	public Integer getPrecisions() {
		return precisions;
	}

	public void setPrecisions(Integer precisions) {
		this.precisions = precisions;
	}
}
