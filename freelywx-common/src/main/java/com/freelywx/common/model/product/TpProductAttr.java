package com.freelywx.common.model.product;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_P_PRODUCT_ATTR")
public class TpProductAttr {
	@GenerateByDb
	@Id
	private Integer id;
	private Integer prod_id;
	private Integer attr_id;
	private String attr_value;
	private String res_id;
	private String res_value;
	private String attr_type;// 属性类型
	private Integer display_order;

	public String getAttr_type() {
		return attr_type;
	}

	public void setAttr_type(String attr_type) {
		this.attr_type = attr_type;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getProd_id() {
		return prod_id;
	}

	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}

	public Integer getAttr_id() {
		return attr_id;
	}

	public void setAttr_id(Integer attr_id) {
		this.attr_id = attr_id;
	}

	public String getAttr_value() {
		return attr_value;
	}

	public void setAttr_value(String attr_value) {
		this.attr_value = attr_value;
	}

	public String getRes_id() {
		return res_id;
	}

	public void setRes_id(String res_id) {
		this.res_id = res_id;
	}

	public String getRes_value() {
		return res_value;
	}

	public void setRes_value(String res_value) {
		this.res_value = res_value;
	}

	public Integer getDisplay_order() {
		return display_order;
	}

	public void setDisplay_order(Integer display_order) {
		this.display_order = display_order;
	}
}