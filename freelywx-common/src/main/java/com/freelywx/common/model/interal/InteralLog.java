package com.freelywx.common.model.interal;

import java.util.Date;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_I_INTERAL_LOG")
public class InteralLog {

	@Id
	@GenerateByDb
	private Integer interal_log_id;

	private Integer member_id;

	private Integer interal_rule_id;

	/** 增加、减少 */
	private String interal_change_type;

	private String interal_rule_name;

	private String interal_rule_desc;

	private String interal_rule_unit;

	private Integer interal_rule_value;

	/** 已经使用的积分 */
	private Integer used_valur;

	/** 失效的积分 */
	private Integer expiry_value;

	private Date rule_start_time;

	private Date rule_end_time;

	private Date use_start_time;

	private Date use_end_time;

	private Date create_time;

	private Integer created_by;

	private String ext1;

	private String ext2;

	private String ext3;

	private String ext4;

	private String ext5;

	@ColumnIgnore
	private String member_name;

	public Integer getInteral_log_id() {
		return interal_log_id;
	}

	public void setInteral_log_id(Integer interal_log_id) {
		this.interal_log_id = interal_log_id;
	}

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}

	public Integer getInteral_rule_id() {
		return interal_rule_id;
	}

	public void setInteral_rule_id(Integer interal_rule_id) {
		this.interal_rule_id = interal_rule_id;
	}

	public String getInteral_change_type() {
		return interal_change_type;
	}

	public void setInteral_change_type(String interal_change_type) {
		this.interal_change_type = interal_change_type;
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

	public Integer getUsed_valur() {
		return used_valur;
	}

	public void setUsed_valur(Integer used_valur) {
		this.used_valur = used_valur;
	}

	public Integer getExpiry_value() {
		return expiry_value;
	}

	public void setExpiry_value(Integer expiry_value) {
		this.expiry_value = expiry_value;
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

	public String getExt1() {
		return ext1;
	}

	public void setExt1(String ext1) {
		this.ext1 = ext1;
	}

	public String getExt2() {
		return ext2;
	}

	public void setExt2(String ext2) {
		this.ext2 = ext2;
	}

	public String getExt3() {
		return ext3;
	}

	public void setExt3(String ext3) {
		this.ext3 = ext3;
	}

	public String getExt4() {
		return ext4;
	}

	public void setExt4(String ext4) {
		this.ext4 = ext4;
	}

	public String getExt5() {
		return ext5;
	}

	public void setExt5(String ext5) {
		this.ext5 = ext5;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

}