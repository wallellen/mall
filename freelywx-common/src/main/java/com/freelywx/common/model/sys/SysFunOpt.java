package com.freelywx.common.model.sys;

import java.util.List;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_sys_fun_opt")
public class SysFunOpt {
	@Id
	@GenerateByDb
	private Integer fun_opt_id;

	private String fun_opt_nm;

	private String url;

	private String remarks;

	private Integer parent_fun_opt_id;

	private String user_type;

	@ColumnIgnore
	private List<SysFunOpt> children;

	public Integer getFun_opt_id() {
		return fun_opt_id;
	}

	public void setFun_opt_id(Integer fun_opt_id) {
		this.fun_opt_id = fun_opt_id;
	}

	public String getFun_opt_nm() {
		return fun_opt_nm;
	}

	public void setFun_opt_nm(String fun_opt_nm) {
		this.fun_opt_nm = fun_opt_nm;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Integer getParent_fun_opt_id() {
		return parent_fun_opt_id;
	}

	public void setParent_fun_opt_id(Integer parent_fun_opt_id) {
		this.parent_fun_opt_id = parent_fun_opt_id;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public List<SysFunOpt> getChildren() {
		return children;
	}

	public void setChildren(List<SysFunOpt> children) {
		this.children = children;
	}

}