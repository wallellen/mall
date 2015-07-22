package com.freelywx.common.model.user;

import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_B_DICT")
public class TbDict {
	@Id
    private String dict_id;

    private String dict_name;

    private String dict_desc;

    private String dict_type;

    private String dict_status;

	public String getDict_id() {
		return dict_id;
	}

	public void setDict_id(String dict_id) {
		this.dict_id = dict_id;
	}

	public String getDict_name() {
		return dict_name;
	}

	public void setDict_name(String dict_name) {
		this.dict_name = dict_name;
	}

	public String getDict_desc() {
		return dict_desc;
	}

	public void setDict_desc(String dict_desc) {
		this.dict_desc = dict_desc;
	}

	public String getDict_type() {
		return dict_type;
	}

	public void setDict_type(String dict_type) {
		this.dict_type = dict_type;
	}

	public String getDict_status() {
		return dict_status;
	}

	public void setDict_status(String dict_status) {
		this.dict_status = dict_status;
	}
    
    
}