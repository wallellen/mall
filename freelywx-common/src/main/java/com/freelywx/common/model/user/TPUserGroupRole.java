package com.freelywx.common.model.user;

import com.rps.util.dao.annotation.Pk;
import com.rps.util.dao.annotation.Table;

@Table("T_P_USER_GRP_ROLE")
public class TPUserGroupRole {

	@Pk
	private Integer grp_id;
	@Pk
	private Integer role_id;

	public Integer getGrp_id() {
		return grp_id;
	}

	public void setGrp_id(Integer grp_id) {
		this.grp_id = grp_id;
	}

	public Integer getRole_id() {
		return role_id;
	}

	public void setRole_id(Integer role_id) {
		this.role_id = role_id;
	}

}