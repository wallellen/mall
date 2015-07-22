package com.freelywx.common.model.product;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_P_PRODUCT_PIC")
public class TpProductPic {
	@GenerateByDb
	@Id
	private Integer prod_pic_id;
	private Integer prod_id;
	private String pic_url;
	private String pic_desc;
	private Integer sort;

	public Integer getProd_pic_id() {
		return prod_pic_id;
	}

	public void setProd_pic_id(Integer prod_pic_id) {
		this.prod_pic_id = prod_pic_id;
	}

	public Integer getProd_id() {
		return prod_id;
	}

	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}

	public String getPic_url() {
		return pic_url;
	}

	public void setPic_url(String pic_url) {
		this.pic_url = pic_url;
	}

	public String getPic_desc() {
		return pic_desc;
	}

	public void setPic_desc(String pic_desc) {
		this.pic_desc = pic_desc;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
}