package com.freelywx.common.model.user;

import com.rps.util.dao.annotation.Pk;
import com.rps.util.dao.annotation.Table;

@Table("T_P_USER_ROLE")
public class TpUserRole {
	@Pk
	private Integer user_id;
	@Pk
	private Integer role_id;

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public Integer getRole_id() {
		return role_id;
	}

	public void setRole_id(Integer role_id) {
		this.role_id = role_id;
	}

}