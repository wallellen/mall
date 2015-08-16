package com.freelywx.common.model.product;

import java.util.Date;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_p_attr")
public class TpAttr {
	/** 属性ID */
	@Id
	@GenerateByDb
	private Integer attr_id;

	private String attr_name;

	private String status;

	/** 显示顺序 */
	private Integer sort;

	/** 1静态属性；2动态属性 */
	private String attr_type;

	/** 属性类型为单位属性的时候，对应的单位资源的ID.在也页面以下拉选择框供选择。 */
	private String res_id;

	/** 说明 */
	private String remark;

	private Date create_time;

	private Integer create_by;

	/** 最后修改时间 */
	private Date update_time;

	/** 最后一次编辑人 */
	private Integer update_by;

	@ColumnIgnore
	private String resName; // 资源单位名称。从dict中取值

	@ColumnIgnore
	private String attrValue;// 属性值

	public Integer getAttr_id() {
		return attr_id;
	}

	public void setAttr_id(Integer attr_id) {
		this.attr_id = attr_id;
	}

	public String getAttr_name() {
		return attr_name;
	}

	public void setAttr_name(String attr_name) {
		this.attr_name = attr_name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getAttr_type() {
		return attr_type;
	}

	public void setAttr_type(String attr_type) {
		this.attr_type = attr_type;
	}

	public String getRes_id() {
		return res_id;
	}

	public void setRes_id(String res_id) {
		this.res_id = res_id;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	public String getResName() {
		return resName;
	}

	public void setResName(String resName) {
		this.resName = resName;
	}

	public String getAttrValue() {
		return attrValue;
	}

	public void setAttrValue(String attrValue) {
		this.attrValue = attrValue;
	}

}
