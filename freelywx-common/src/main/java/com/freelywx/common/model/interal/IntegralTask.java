package com.freelywx.common.model.interal;

import java.util.Date;

import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_integral_task")
public class IntegralTask {
	@Id
	private Integer id;

	private Integer member_id;

	private Integer order_id;

	private Integer integral_num;

	/** 结算时间 */
	private Date integral_time;

	/** 状态 */
	private String status;

	/** 更新时间 */
	private Date update_time;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}

	public Integer getOrder_id() {
		return order_id;
	}

	public void setOrder_id(Integer order_id) {
		this.order_id = order_id;
	}

	public Integer getIntegral_num() {
		return integral_num;
	}

	public void setIntegral_num(Integer integral_num) {
		this.integral_num = integral_num;
	}

	public Date getIntegral_time() {
		return integral_time;
	}

	public void setIntegral_time(Date integral_time) {
		this.integral_time = integral_time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
}
