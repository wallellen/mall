package com.freelywx.common.model.advertise;

import java.util.Date;


import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_ad_advertise")
public class Advertisement {

	@GenerateByDb
	@Id
	private Integer ad_id;
	/** 栏目ID */
	private Integer coloum_id;
	/** 广告名称 */
	private String ad_name;
	/** 描述 */
	private String desc;
	/** 图片链接 */
	private String pic_url;
	/** 连接地址 */
	private String link_url;
	/** 开始时间 */
	private Date start_time;
	/** 结束时间 */
	private Date end_time;
	/** 状态 */
	private String status;
	@ColumnIgnore
	/** 栏目名称 */
	private String coloum_name;
	public Integer getAd_id() {
		return ad_id;
	}
	public void setAd_id(Integer ad_id) {
		this.ad_id = ad_id;
	}
	public Integer getColoum_id() {
		return coloum_id;
	}
	public void setColoum_id(Integer coloum_id) {
		this.coloum_id = coloum_id;
	}
	public String getAd_name() {
		return ad_name;
	}
	public void setAd_name(String ad_name) {
		this.ad_name = ad_name;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getPic_url() {
		return pic_url;
	}
	public void setPic_url(String pic_url) {
		this.pic_url = pic_url;
	}
	public String getLink_url() {
		return link_url;
	}
	public void setLink_url(String link_url) {
		this.link_url = link_url;
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
	public String getColoum_name() {
		return coloum_name;
	}
	public void setColoum_name(String coloum_name) {
		this.coloum_name = coloum_name;
	}
}
