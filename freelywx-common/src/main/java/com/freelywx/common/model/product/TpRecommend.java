package com.freelywx.common.model.product;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_p_recommend")
public class TpRecommend {
	/** 主键 */
	@Id
	@GenerateByDb
	private Integer recommend_id;

	/** 标签类型 */
	private Integer tag_id;

	private Integer prod_id;

	private Integer sort;

	private String desc;

	public Integer getRecommend_id() {
		return recommend_id;
	}

	public void setRecommend_id(Integer recommend_id) {
		this.recommend_id = recommend_id;
	}

	public Integer getTag_id() {
		return tag_id;
	}

	public void setTag_id(Integer tag_id) {
		this.tag_id = tag_id;
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

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

}