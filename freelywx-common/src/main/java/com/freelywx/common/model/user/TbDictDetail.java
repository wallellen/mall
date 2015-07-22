package com.freelywx.common.model.user;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_B_DICT_DETAIL")
public class TbDictDetail {
	@Id
	@GenerateByDb
	private String dict_detail_id;
	private String dict_id;
	private String dict_param_value;
	private String dict_param_name;
	private String dict_param_name_en;
	private String dict_param_status;

	public String getDict_detail_id() {
		return dict_detail_id;
	}

	public void setDict_detail_id(String dict_detail_id) {
		this.dict_detail_id = dict_detail_id;
	}

	public String getDict_id() {
		return dict_id;
	}

	public void setDict_id(String dict_id) {
		this.dict_id = dict_id;
	}

	public String getDict_param_value() {
		return dict_param_value;
	}

	public void setDict_param_value(String dict_param_value) {
		this.dict_param_value = dict_param_value;
	}

	public String getDict_param_name() {
		return dict_param_name;
	}

	public void setDict_param_name(String dict_param_name) {
		this.dict_param_name = dict_param_name;
	}

	public String getDict_param_status() {
		return dict_param_status;
	}

	public void setDict_param_status(String dict_param_status) {
		this.dict_param_status = dict_param_status;
	}

	public String getDict_param_name_en() {
		return dict_param_name_en;
	}

	public void setDict_param_name_en(String dict_param_name_en) {
		this.dict_param_name_en = dict_param_name_en;
	}
	
	
}
