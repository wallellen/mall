package com.freelywx.common.model.coupon;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_C_COUPON")
public class Coupon {
	@GenerateByDb
	@Id
	private Integer coupon_id;
	private String coupon_name;
	private Integer coupon_reach;
	private Integer coupon_value;
	private Date coupon_start_time;
	private Date coupon_end_time;
	private Integer coupon_sum;
	private String coupon_desc;
	private Integer more_than;
	private Integer less_than;
	private String type;
	private String combination;
	private Date create_time;
	private Integer created_by;
	private Date last_update_time;
	private Integer last_updated_by;

	public Integer getCoupon_sum() {
		return coupon_sum;
	}

	public void setCoupon_sum(Integer coupon_sum) {
		this.coupon_sum = coupon_sum;
	}

	public String getCoupon_desc() {
		return coupon_desc;
	}

	public void setCoupon_desc(String coupon_desc) {
		this.coupon_desc = coupon_desc;
	}

	public Integer getCoupon_id() {
		return coupon_id;
	}

	public void setCoupon_id(Integer coupon_id) {
		this.coupon_id = coupon_id;
	}

	public String getCoupon_name() {
		return coupon_name;
	}

	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}

	public Integer getCoupon_reach() {
		return coupon_reach;
	}

	public void setCoupon_reach(Integer coupon_reach) {
		this.coupon_reach = coupon_reach;
	}

	public Integer getCoupon_value() {
		return coupon_value;
	}

	public void setCoupon_value(Integer coupon_value) {
		this.coupon_value = coupon_value;
	}

	public Date getCoupon_start_time() {
		return coupon_start_time;
	}

	public void setCoupon_start_time(Date coupon_start_time) {
		this.coupon_start_time = coupon_start_time;
	}

	public Date getCoupon_end_time() {
		return coupon_end_time;
	}

	public void setCoupon_end_time(Date coupon_end_time) {
		this.coupon_end_time = coupon_end_time;
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