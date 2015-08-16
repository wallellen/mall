package com.freelywx.common.model.product;

import java.util.Date;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_p_category")
public class TpCategory {
	/** 目录ID。主键 */
	@Id
	@GenerateByDb
	private Integer category_id;

	private Integer par_category_id;

	/** 目录名称 */
	private String category_name;

	/** 目录状态 */
	private String status;

	/** 目录对应链接 */
	private String category_url;

	/** 目录显示顺序 */
	private Integer sort;

	private Date active_start_date;

	private Date active_end_date;

	/** 说明 */
	private String remark;

	/** 显示模板。可以控制在页面上面显示的样式 */
	private String display_template;

	/** 图片URL.图片目录的URL */
	private String img_url;

	private Date create_time;

	private Integer create_by;

	/** 最后修改时间 */
	private Date update_time;

	/** 最后一次编辑人 */
	private Integer update_by;
	@ColumnIgnore
	private String pName;

	public Integer getCategory_id() {
		return category_id;
	}

	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
	}

	public Integer getPar_category_id() {
		return par_category_id;
	}

	public void setPar_category_id(Integer par_category_id) {
		this.par_category_id = par_category_id;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCategory_url() {
		return category_url;
	}

	public void setCategory_url(String category_url) {
		this.category_url = category_url;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getDisplay_template() {
		return display_template;
	}

	public void setDisplay_template(String display_template) {
		this.display_template = display_template;
	}

	public String getImg_url() {
		return img_url;
	}

	public void setImg_url(String img_url) {
		this.img_url = img_url;
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

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

}