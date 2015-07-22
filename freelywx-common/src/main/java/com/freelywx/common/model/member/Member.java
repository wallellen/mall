package com.freelywx.common.model.member;

import java.util.Date;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;

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
	private Integer uid;

	private String open_id;

	private String member_name;

	private String member_sex;

	private String member_province;

	private String member_city;

	private String member_country;

	private String member_img;

	private int member_level;

	private Date create_time;

	/** 1、关注；2、未关注 */
	private String status;

	private Date last_update_time;

	@ColumnIgnore
	private String user_name;

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public String getOpen_id() {
		return open_id;
	}

	public void setOpen_id(String open_id) {
		this.open_id = open_id;
	}

	public String getMember_name() {
		if (StringUtils.isNotEmpty(member_name)) {
			return new String(Base64.decodeBase64(member_name));
		}
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_sex() {
		return member_sex;
	}

	public void setMember_sex(String member_sex) {
		this.member_sex = member_sex;
	}

	public String getMember_province() {
		return member_province;
	}

	public void setMember_province(String member_province) {
		this.member_province = member_province;
	}

	public String getMember_city() {
		return member_city;
	}

	public void setMember_city(String member_city) {
		this.member_city = member_city;
	}

	public String getMember_country() {
		return member_country;
	}

	public void setMember_country(String member_country) {
		this.member_country = member_country;
	}

	public String getMember_img() {
		return member_img;
	}

	public int getMember_level() {
		return member_level;
	}

	public void setMember_level(int member_level) {
		this.member_level = member_level;
	}

	public void setMember_img(String member_img) {
		this.member_img = member_img;
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

	public Date getLast_update_time() {
		return last_update_time;
	}

	public void setLast_update_time(Date last_update_time) {
		this.last_update_time = last_update_time;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

}
