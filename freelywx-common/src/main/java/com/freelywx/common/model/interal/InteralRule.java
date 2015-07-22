package com.freelywx.common.model.interal;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_I_INTERAL_RULE")
public class InteralRule {
	@GenerateByDb
	@Id
	private Integer interal_rule_id;
	private String interal_rule_code;
	private String interal_rule_name;
	private String interal_rule_desc;
	private String interal_rule_unit;
	private Integer interal_rule_value;
	private Date rule_start_time;
	private Date rule_end_time;
	private Date use_start_time;
	private Date use_end_time;
	private Date create_time;
	private Integer created_by;
	private Date last_update_time;
	private Integer last_updated_by;

	public Integer getInteral_rule_id() {
		return interal_rule_id;
	}

	public void setInteral_rule_id(Integer interal_rule_id) {
		this.interal_rule_id = interal_rule_id;
	}

	public String getInteral_rule_code() {
		return interal_rule_code;
	}

	public void setInteral_rule_code(String interal_rule_code) {
		this.interal_rule_code = interal_rule_code;
	}

	public String getInteral_rule_name() {
		return interal_rule_name;
	}

	public void setInteral_rule_name(String interal_rule_name) {
		this.interal_rule_name = interal_rule_name;
	}

	public String getInteral_rule_desc() {
		return interal_rule_desc;
	}

	public void setInteral_rule_desc(String interal_rule_desc) {
		this.interal_rule_desc = interal_rule_desc;
	}

	public String getInteral_rule_unit() {
		return interal_rule_unit;
	}

	public void setInteral_rule_unit(String interal_rule_unit) {
		this.interal_rule_unit = interal_rule_unit;
	}

	public Integer getInteral_rule_value() {
		return interal_rule_value;
	}

	public void setInteral_rule_value(Integer interal_rule_value) {
		this.interal_rule_value = interal_rule_value;
	}

	public Date getRule_start_time() {
		return rule_start_time;
	}

	public void setRule_start_time(Date rule_start_time) {
		this.rule_start_time = rule_start_time;
	}

	public Date getRule_end_time() {
		return rule_end_time;
	}

	public void setRule_end_time(Date rule_end_time) {
		this.rule_end_time = rule_end_time;
	}

	public Date getUse_start_time() {
		return use_start_time;
	}

	public void setUse_start_time(Date use_start_time) {
		this.use_start_time = use_start_time;
	}

	public Date getUse_end_time() {
		return use_end_time;
	}

	public void setUse_end_time(Date use_end_time) {
		this.use_end_time = use_end_time;
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