package com.freelywx.common.model.order;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_O_ORDER_DETAIL_ATTR")
public class OrderDetailAttr {
	@Id
	@GenerateByDb
	private Integer id;
	private Integer detail_id;
	private Integer prod_id;
	private String prod_attr;
	private String prod_attr_value;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getDetail_id() {
		return detail_id;
	}

	public void setDetail_id(Integer detail_id) {
		this.detail_id = detail_id;
	}

	public Integer getProd_id() {
		return prod_id;
	}

	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}

	public String getProd_attr() {
		return prod_attr;
	}

	public void setProd_attr(String prod_attr) {
		this.prod_attr = prod_attr;
	}

	public String getProd_attr_value() {
		return prod_attr_value;
	}

	public void setProd_attr_value(String prod_attr_value) {
		this.prod_attr_value = prod_attr_value;
	}

}
