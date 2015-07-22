package com.freelywx.common.model.product;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_P_RECOMMEND")
public class TpRecommend {
	@GenerateByDb
	@Id
	private Integer recommend_id;
	private Integer prod_type_id;
	private Integer prod_id;
	private Integer sort;
	private String description;

	public Integer getRecommend_id() {
		return recommend_id;
	}

	public void setRecommend_id(Integer recommend_id) {
		this.recommend_id = recommend_id;
	}

	public Integer getProd_type_id() {
		return prod_type_id;
	}

	public void setProd_type_id(Integer prod_type_id) {
		this.prod_type_id = prod_type_id;
	}

	public Integer getProd_id() {
		return prod_id;
	}

	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}