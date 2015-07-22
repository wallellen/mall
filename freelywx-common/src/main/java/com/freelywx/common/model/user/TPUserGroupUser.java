package com.freelywx.common.model.user;

import com.rps.util.dao.annotation.Pk;
import com.rps.util.dao.annotation.Table;

@Table("T_P_USER_GRP_USER")
public class TPUserGroupUser {

	@Pk
	private Integer grp_id;
	@Pk
	private Integer user_id;

	public Integer getGrp_id() {
		return grp_id;
	}

	public void setGrp_id(Integer grp_id) {
		this.grp_id = grp_id;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
}