package com.freelywx.common.model.product;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_P_PROD_CATEGORY")
public class TpProdCategory {
	@GenerateByDb
	@Id
	private Integer prod_catagory_id;
	private Integer category_id;
	private Integer prod_id;

	public Integer getProd_catagory_id() {
		return prod_catagory_id;
	}

	public void setProd_catagory_id(Integer prod_catagory_id) {
		this.prod_catagory_id = prod_catagory_id;
	}

	public Integer getCategory_id() {
		return category_id;
	}

	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
	}

	public Integer getProd_id() {
		return prod_id;
	}

	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}
}