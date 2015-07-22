package com.freelywx.common.model.product;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_P_CATEGORY_ATTR")
public class TpCategoryAttr {
	@GenerateByDb
	@Id
	private Integer category_attr_id;
	private Integer attr_id;
	private Integer category_id;
	private Integer display_order;

	public Integer getCategory_attr_id() {
		return category_attr_id;
	}

	public void setCategory_attr_id(Integer category_attr_id) {
		this.category_attr_id = category_attr_id;
	}

	public Integer getAttr_id() {
		return attr_id;
	}

	public void setAttr_id(Integer attr_id) {
		this.attr_id = attr_id;
	}

	public Integer getCategory_id() {
		return category_id;
	}

	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
	}

	public Integer getDisplay_order() {
		return display_order;
	}

	public void setDisplay_order(Integer display_order) {
		this.display_order = display_order;
	}
}