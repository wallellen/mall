package com.freelywx.common.model.coupon;

import java.util.Date;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_C_COUPON_2_MEMBER")
public class Coupon2Member {
	@GenerateByDb
	@Id
	private Integer coupon_2_member;
	private Integer cash_coupon_id;
	private String coupon_type;
	private Integer member_id;
	private Date bind_time;
	private Date use_time;
	private Integer order_id;
	private Date cash_coupon_start_time;
	private Date cash_coupon_end_time;
	private String coupon_desc;
	@ColumnIgnore
	private String coupon_name;
	@ColumnIgnore
	private String member_name;
	private String coupon_state;
	@ColumnIgnore
	private String coupon_value;
	
	@ColumnIgnore
	private String coupon_state_new;

	public String getCoupon_value() {
		return coupon_value;
	}

	public void setCoupon_value(String coupon_value) {
		this.coupon_value = coupon_value;
	}

	public String getCoupon_state() {
		return coupon_state;
	}

	public void setCoupon_state(String coupon_state) {
		this.coupon_state = coupon_state;
	}

	public String getCoupon_name() {
		return coupon_name;
	}

	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}

	public String getMember_name() {
		if(StringUtils.isNotEmpty(member_name)){
			return new String(Base64.decodeBase64(member_name));
		}
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getCoupon_desc() {
		return coupon_desc;
	}

	public void setCoupon_desc(String coupon_desc) {
		this.coupon_desc = coupon_desc;
	}

	public String getCoupon_type() {
		return coupon_type;
	}

	public void setCoupon_type(String coupon_type) {
		this.coupon_type = coupon_type;
	}

	public Integer getCoupon_2_member() {
		return coupon_2_member;
	}

	public void setCoupon_2_member(Integer coupon_2_member) {
		this.coupon_2_member = coupon_2_member;
	}

	public Integer getCash_coupon_id() {
		return cash_coupon_id;
	}

	public void setCash_coupon_id(Integer cash_coupon_id) {
		this.cash_coupon_id = cash_coupon_id;
	}

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}

	public Date getBind_time() {
		return bind_time;
	}

	public void setBind_time(Date bind_time) {
		this.bind_time = bind_time;
	}

	public Date getUse_time() {
		return use_time;
	}

	public void setUse_time(Date use_time) {
		this.use_time = use_time;
	}

	public Integer getOrder_id() {
		return order_id;
	}

	public void setOrder_id(Integer order_id) {
		this.order_id = order_id;
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

	public String getCoupon_state_new() {
		return coupon_state_new;
	}

	public void setCoupon_state_new(String coupon_state_new) {
		this.coupon_state_new = coupon_state_new;
	}
	
	
}