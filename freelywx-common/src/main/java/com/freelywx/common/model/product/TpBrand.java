package com.freelywx.common.model.product;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_p_brand")
public class TpBrand {
	/** 品牌ID */
	@Id
	@GenerateByDb
	private Integer brand_id;

	/** 品牌编码 */
	private String brand_code;

	/** 品牌英文名称 */
	private String name_en;

	/** 品牌名称 */
	private String name;

	/** 品牌说明 */
	private String remark;

	/** 状态 */
	private String status;

	/** 品牌URL */
	private String brand_url;

	private Date active_start_date;

	private Date active_end_date;

	private Date create_time;

	private Integer create_by;

	/** 最后修改时间 */
	private Date update_time;

	/** 最后一次编辑人 */
	private Integer update_by;

	/** 排序 */
	private Integer sort;

	public Integer getBrand_id() {
		return brand_id;
	}

	public void setBrand_id(Integer brand_id) {
		this.brand_id = brand_id;
	}

	public String getBrand_code() {
		return brand_code;
	}

	public void setBrand_code(String brand_code) {
		this.brand_code = brand_code;
	}

	public String getName_en() {
		return name_en;
	}

	public void setName_en(String name_en) {
		this.name_en = name_en;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getBrand_url() {
		return brand_url;
	}

	public void setBrand_url(String brand_url) {
		this.brand_url = brand_url;
	}

	public Date getActive_start_date() {
		return active_start_date;
	}

	public void setActive_start_date(Date active_start_date) {
		this.active_start_date = active_start_date;
	}

	public Date getActive_end_date() {
		return active_end_date;
	}

	public void setActive_end_date(Date active_end_date) {
		this.active_end_date = active_end_date;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getCreate_by() {
		return create_by;
	}

	public void setCreate_by(Integer create_by) {
		this.create_by = create_by;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public Integer getUpdate_by() {
		return update_by;
	}

	public void setUpdate_by(Integer update_by) {
		this.update_by = update_by;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

}