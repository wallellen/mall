package com.freelywx.common.model.interal;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_integral_cycle")
public class IntegralCycle {
	@Id
	@GenerateByDb
	private Integer cycle_id;

	private String cycle_name;

	/** 描述 */
	private String remark;

	public Integer getCycle_id() {
		return cycle_id;
	}

	public void setCycle_id(Integer cycle_id) {
		this.cycle_id = cycle_id;
	}

	public String getCycle_name() {
		return cycle_name;
	}

	public void setCycle_name(String cycle_name) {
		this.cycle_name = cycle_name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String desc) {
		this.remark = desc;
	}
}
