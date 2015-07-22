package com.freelywx.common.model.product;

import java.util.Date;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_P_ATTR")
public class TpAttr {
	@GenerateByDb
	@Id
	private Integer attr_id;
	private String attr_name;
	private String status;
	private Integer display_order;
	private String attr_type;
	private String res_id;
	private String description;
	private Date create_time;
	private Integer created_by;
	private Date last_update_time;
	private Integer last_updated_by;
	
	@ColumnIgnore
	private String resName; //资源单位名称。从dict中取值
	
	@ColumnIgnore
	private String attrValue;//属性值

	public String getAttrValue() {
		return attrValue;
	}

	public void setAttrValue(String attrValue) {
		this.attrValue = attrValue;
	}

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

	public Integer getDisplay_order() {
		return display_order;
	}

	public void setDisplay_order(Integer display_order) {
		this.display_order = display_order;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getCreated_by() {
		return created_by;
	}

	public void setCreated_by(Integer created_by) {
		this.created_by = created_by;
	}

	public Date getLast_update_time() {
		return last_update_time;
	}

	public void setLast_update_time(Date last_update_time) {
		this.last_update_time = last_update_time;
	}

	public Integer getLast_updated_by() {
		return last_updated_by;
	}

	public void setLast_updated_by(Integer last_updated_by) {
		this.last_updated_by = last_updated_by;
	}

	public String getResName() {
		return resName;
	}

	public void setResName(String resName) {
		this.resName = resName;
	}
	
}
