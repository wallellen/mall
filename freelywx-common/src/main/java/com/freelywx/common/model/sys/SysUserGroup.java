package com.freelywx.common.model.sys;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;
@Table("t_sys_user_grp")
public class SysUserGroup {
	@Id
	@GenerateByDb
	private Integer grp_id;
	private String grp_nm;
	private String grp_desc;
	public Integer getGrp_id() {
		return grp_id;
	}

	public void setGrp_id(Integer grp_id) {
		this.grp_id = grp_id;
	}
	public String getGrp_nm() {
		return grp_nm;
	}
	public void setGrp_nm(String grp_nm) {
		this.grp_nm = grp_nm;
	}
	public String getGrp_desc() {
		return grp_desc;
	}
	public void setGrp_desc(String grp_desc) {
		this.grp_desc = grp_desc;
	}
	
}
