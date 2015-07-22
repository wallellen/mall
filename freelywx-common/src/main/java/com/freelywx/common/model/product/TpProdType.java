package com.freelywx.common.model.product;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_P_PROD_TYPE")
public class TpProdType{
	@GenerateByDb
	@Id
	private Integer prod_type_id;
	private String type_name;
	private String description;
	private String status;
	private Date active_start_date;
	private Date active_end_date;
	private Date create_time;
	private Integer created_by;
	private Date last_update_time;
	private Integer last_updated_by;

	public Integer getProd_type_id() {
		return prod_type_id;
	}

	public void setProd_type_id(Integer prod_type_id) {
		this.prod_type_id = prod_type_id;
	}

	public String getType_name() {
		return type_name;
	}

	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getActive_start_date() {
		return active_start_date;
	}

	public void setActive_start_date(Date active_start_date) {
		this.active_start_date = active_start_date;
	}

	public Date getActive_end_date() {
		return active_end_date;
	}

	public void setActive_end_date(Date active_end_date) {
		this.active_end_date = active_end_date;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getCreated_by() {
		return created_by;
	}

	public void setCreated_by(Integer created_by) {
		this.created_by = created_by;
	}

	public Date getLast_update_time() {
		return last_update_time;
	}

	public void setLast_update_time(Date last_update_time) {
		this.last_update_time = last_update_time;
	}

	public Integer getLast_updated_by() {
		return last_updated_by;
	}

	public void setLast_updated_by(Integer last_updated_by) {
		this.last_updated_by = last_updated_by;
	}
}