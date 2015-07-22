package com.freelywx.common.model.user;

import com.rps.util.dao.annotation.Pk;
import com.rps.util.dao.annotation.Table;

@Table("T_P_ROLE_FUN_OPT")
public class TpRoleFunOpt {

	@Pk
	private Integer role_id;
	@Pk
	private Integer fun_opt_id;

	

	public Integer getRole_id() {
		return role_id;
	}

	public void setRole_id(Integer role_id) {
		this.role_id = role_id;
	}

	public Integer getFun_opt_id() {
		return fun_opt_id;
	}

	public void setFun_opt_id(Integer fun_opt_id) {
		this.fun_opt_id = fun_opt_id;
	}

}