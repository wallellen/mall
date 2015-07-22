package com.freelywx.common.model.member;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_M_RULE")
public class MemberRule {
	@GenerateByDb
	@Id
	private Integer rule_id;
	private Integer sale_more_than;
	private String rule_name;
	private Date create_time;
	private Integer created_by;
	private Date last_update_time;
	private Integer last_updated_by;
	private String rule_desc;

	public String getRule_desc() {
		return rule_desc;
	}

	public void setRule_desc(String rule_desc) {
		this.rule_desc = rule_desc;
	}

	public Integer getRule_id() {
		return rule_id;
	}

	public void setRule_id(Integer rule_id) {
		this.rule_id = rule_id;
	}

	public Integer getSale_more_than() {
		return sale_more_than;
	}

	public void setSale_more_than(Integer sale_more_than) {
		this.sale_more_than = sale_more_than;
	}

	public String getRule_name() {
		return rule_name;
	}

	public void setRule_name(String rule_name) {
		this.rule_name = rule_name;
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