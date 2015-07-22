package com.freelywx.common.model.member;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_M_SIGN_IN")
public class TMSignIn {
	@Id
	@GenerateByDb
	private Integer sign_in_id;

	private Integer user_id;

	/** 1.线上；2、现场签到 */
	private String sign_in_type;

	private Date create_time;

	private Integer sign_in_num;

	public Integer getSign_in_id() {
		return sign_in_id;
	}

	public void setSign_in_id(Integer sign_in_id) {
		this.sign_in_id = sign_in_id;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getSign_in_type() {
		return sign_in_type;
	}

	public void setSign_in_type(String sign_in_type) {
		this.sign_in_type = sign_in_type;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getSign_in_num() {
		return sign_in_num;
	}

	public void setSign_in_num(Integer sign_in_num) {
		this.sign_in_num = sign_in_num;
	}
}
