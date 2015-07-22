package com.freelywx.common.model.coupon;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_C_CASH_COUPON")
public class CashCoupon {
	@GenerateByDb
	@Id
	private Integer cash_coupon_id;
	private String cash_coupon_name;
	private Integer cash_coupon_value;
	private Date cash_coupon_start_time;
	private Date cash_coupon_end_time;
	private Integer cash_coupon_sum;
	private String cash_coupon_desc;
	private Integer more_than;
	private Integer less_than;
	private String type;
	private String combination;
	private Date create_time;
	private Integer created_by;
	private Date last_update_time;
	private Integer last_updated_by;

	public Integer getCash_coupon_id() {
		return cash_coupon_id;
	}

	public void setCash_coupon_id(Integer cash_coupon_id) {
		this.cash_coupon_id = cash_coupon_id;
	}

	public String getCash_coupon_name() {
		return cash_coupon_name;
	}

	public void setCash_coupon_name(String cash_coupon_name) {
		this.cash_coupon_name = cash_coupon_name;
	}

	public Integer getCash_coupon_value() {
		return cash_coupon_value;
	}

	public void setCash_coupon_value(Integer cash_coupon_value) {
		this.cash_coupon_value = cash_coupon_value;
	}

	public Date getCash_coupon_start_time() {
		return cash_coupon_start_time;
	}

	public void setCash_coupon_start_time(Date cash_coupon_start_time) {
		this.cash_coupon_start_time = cash_coupon_start_time;
	}

	public Date getCash_coupon_end_time() {
		return cash_coupon_end_time;
	}

	public void setCash_coupon_end_time(Date cash_coupon_end_time) {
		this.cash_coupon_end_time = cash_coupon_end_time;
	}

	public Integer getCash_coupon_sum() {
		return cash_coupon_sum;
	}

	public void setCash_coupon_sum(Integer cash_coupon_sum) {
		this.cash_coupon_sum = cash_coupon_sum;
	}

	public String getCash_coupon_desc() {
		return cash_coupon_desc;
	}

	public void setCash_coupon_desc(String cash_coupon_desc) {
		this.cash_coupon_desc = cash_coupon_desc;
	}

	public Integer getMore_than() {
		return more_than;
	}

	public void setMore_than(Integer more_than) {
		this.more_than = more_than;
	}

	public Integer getLess_than() {
		return less_than;
	}

	public void setLess_than(Integer less_than) {
		this.less_than = less_than;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCombination() {
		return combination;
	}

	public void setCombination(String combination) {
		this.combination = combination;
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