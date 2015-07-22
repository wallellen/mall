package com.freelywx.common.model.visit;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_V_VISIT")
public class TVVisit {
	/** 日志编号 */
	@Id
	@GenerateByDb
	private Integer visit_id;

	/** 用户编号 */
	private Integer member_id;

	/** 用户标识 */
	private String open_id;

	/** 链接标题 */
	private String visit_title;

	/** 访问链接 */
	private String visit_url;

	/** 来源地址 */
	private String visit_url_from;

	/** 进入时间 */
	private Date visit_time_in;

	/** 离开时间 */
	private Date visit_time_out;

	/** 网络地址 */
	private String visit_ip;

	/** 城市地区 */
	private String visit_city;

	/** 操作系统 */
	private String visit_os;

	/** 屏幕分辨率 */
	private String visit_screen;

	/** 浏览器类型 */
	private String visit_browser;

	public Integer getVisit_id() {
		return visit_id;
	}

	public void setVisit_id(Integer visit_id) {
		this.visit_id = visit_id;
	}

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}

	public String getOpen_id() {
		return open_id;
	}

	public void setOpen_id(String open_id) {
		this.open_id = open_id;
	}

	public String getVisit_title() {
		return visit_title;
	}

	public void setVisit_title(String visit_title) {
		this.visit_title = visit_title;
	}

	public String getVisit_url() {
		return visit_url;
	}

	public void setVisit_url(String visit_url) {
		this.visit_url = visit_url;
	}

	public String getVisit_url_from() {
		return visit_url_from;
	}

	public void setVisit_url_from(String visit_url_from) {
		this.visit_url_from = visit_url_from;
	}

	public Date getVisit_time_in() {
		return visit_time_in;
	}

	public void setVisit_time_in(Date visit_time_in) {
		this.visit_time_in = visit_time_in;
	}

	public Date getVisit_time_out() {
		return visit_time_out;
	}

	public void setVisit_time_out(Date visit_time_out) {
		this.visit_time_out = visit_time_out;
	}

	public String getVisit_ip() {
		return visit_ip;
	}

	public void setVisit_ip(String visit_ip) {
		this.visit_ip = visit_ip;
	}

	public String getVisit_city() {
		return visit_city;
	}

	public void setVisit_city(String visit_city) {
		this.visit_city = visit_city;
	}

	public String getVisit_os() {
		return visit_os;
	}

	public void setVisit_os(String visit_os) {
		this.visit_os = visit_os;
	}

	public String getVisit_screen() {
		return visit_screen;
	}

	public void setVisit_screen(String visit_screen) {
		this.visit_screen = visit_screen;
	}

	public String getVisit_browser() {
		return visit_browser;
	}

	public void setVisit_browser(String visit_browser) {
		this.visit_browser = visit_browser;
	}
}
