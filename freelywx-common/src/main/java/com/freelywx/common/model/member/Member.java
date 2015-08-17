package com.freelywx.common.model.member;

import java.util.Date;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_m_member")
public class Member {
	@Id
	@GenerateByDb
	private Integer member_id;

	/** 商户编号 */
	private Integer wx_id;

	private String openid;

	private String nickname;

	private String sex;

	private String province;

	private String city;

	private String country;

	private String img;

	private int member_level;

	private Date create_time;

	/** 1、关注；2、未关注 */
	private String status;

	private Date update_time;

	@ColumnIgnore
	private String user_name;

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}


	public Integer getWx_id() {
		return wx_id;
	}

	public void setWx_id(Integer wx_id) {
		this.wx_id = wx_id;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public int getMember_level() {
		return member_level;
	}

	public void setMember_level(int member_level) {
		this.member_level = member_level;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}


}
