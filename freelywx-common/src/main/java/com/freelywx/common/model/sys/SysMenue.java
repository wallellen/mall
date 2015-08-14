package com.freelywx.common.model.sys;

import java.util.List;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_P_MENUE")
public class SysMenue {
	@Id
	@GenerateByDb
	private int menue_id;

	private String menue_nm;

	private int par_menue_id;

	private String remarks;

	private String state;

	private int sort;

	private int fun_opt_id;
	
	private String user_type;
	
	@ColumnIgnore
	private String url;

	@ColumnIgnore
	private List<SysMenue> children;

	public int getMenue_id() {
		return menue_id;
	}

	public void setMenue_id(int menue_id) {
		this.menue_id = menue_id;
	}

	public String getMenue_nm() {
		return menue_nm;
	}

	public void setMenue_nm(String menue_nm) {
		this.menue_nm = menue_nm;
	}


	public int getPar_menue_id() {
		return par_menue_id;
	}

	public void setPar_menue_id(int par_menue_id) {
		this.par_menue_id = par_menue_id;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public int getFun_opt_id() {
		return fun_opt_id;
	}

	public void setFun_opt_id(int fun_opt_id) {
		this.fun_opt_id = fun_opt_id;
	}

	public List<SysMenue> getChildren() {
		return children;
	}

	public void setChildren(List<SysMenue> children) {
		this.children = children;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	

}