package com.freelywx.common.model.product;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_P_BRAND")
public class TpBrand {
	@GenerateByDb
	@Id
	private Integer brand_id;
	private String brand_code;
	private String brand_name;
	private String brand_name_en;
	private String brand_url;
	private String description;
	private String brand_status;
	private Date active_start_date;
	private Date active_end_date;
	private Date create_time;
	private Integer created_by;
	private Date last_update_time;
	private Integer last_updated_by;
	private Integer display_order;

	public Integer getDisplay_order() {
		return display_order;
	}

	public void setDisplay_order(Integer display_order) {
		this.display_order = display_order;
	}

	public Integer getBrand_id() {
		return brand_id;
	}

	public void setBrand_id(Integer brand_id) {
		this.brand_id = brand_id;
	}

	public String getBrand_code() {
		return brand_code;
	}

	public void setBrand_code(String brand_code) {
		this.brand_code = brand_code;
	}

	public String getBrand_name() {
		return brand_name;
	}

	public String getBrand_name_en() {
		return brand_name_en;
	}

	public void setBrand_name_en(String brand_name_en) {
		this.brand_name_en = brand_name_en;
	}

	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getBrand_status() {
		return brand_status;
	}

	public void setBrand_status(String brand_status) {
		this.brand_status = brand_status;
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

	public String getBrand_url() {
		return brand_url;
	}

	public void setBrand_url(String brand_url) {
		this.brand_url = brand_url;
	}
	
}