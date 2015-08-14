package com.freelywx.common.model.advertise;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_a_coloum")
public class AdColoum {

	@GenerateByDb
	@Id
	private Integer coloum_id;
	private String coloum_name;
	private String coloum_code;
	private String type;
	private String desc;
	private String status;

	public Integer getColoum_id() {
		return coloum_id;
	}

	public void setColoum_id(Integer coloum_id) {
		this.coloum_id = coloum_id;
	}

	public String getColoum_name() {
		return coloum_name;
	}

	public void setColoum_name(String coloum_name) {
		this.coloum_name = coloum_name;
	}

	public String getColoum_code() {
		return coloum_code;
	}

	public void setColoum_code(String coloum_code) {
		this.coloum_code = coloum_code;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
