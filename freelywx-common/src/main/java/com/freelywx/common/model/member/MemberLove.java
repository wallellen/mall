package com.freelywx.common.model.member;

import java.util.Date;

import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_M_LOVE")
public class MemberLove {
	@Id
	private Integer member_id;
	private Integer prod_id;
	private String state;
	private Date create_time;
	private String member_name;
	private String prod_name;

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getProd_name() {
		return prod_name;
	}

	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}

	public Integer getProd_id() {
		return prod_id;
	}

	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
}