package com.freelywx.common.model.interal;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_I_INTERAL_EXCHANGE")
public class InteralExchange {
	@GenerateByDb
	@Id
	private Integer interal_exchange_id;
	private Integer interal_rule_value;
	private Integer interal_exchange_value;
	private Date create_time;
	public Integer getInteral_exchange_id() {
		return interal_exchange_id;
	}

	public void setInteral_exchange_id(Integer interal_exchange_id) {
		this.interal_exchange_id = interal_exchange_id;
	}
	public Integer getInteral_rule_value() {
		return interal_rule_value;
	}
	public void setInteral_rule_value(Integer interal_rule_value) {
		this.interal_rule_value = interal_rule_value;
	}
	public Integer getInteral_exchange_value() {
		return interal_exchange_value;
	}
	public void setInteral_exchange_value(Integer interal_exchange_value) {
		this.interal_exchange_value = interal_exchange_value;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

}