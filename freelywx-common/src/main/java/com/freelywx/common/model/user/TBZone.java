package com.freelywx.common.model.user;

import java.io.Serializable;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_B_ZONE")
public class TBZone implements  Serializable{
	private static final long serialVersionUID = 1191157140145825097L;

	@GenerateByDb
	@Id
	private Integer zone_code;

	private String zone_name;

	private Integer parent_code;

	private Integer node_class;

	private Integer zone_order;

	public Integer getZone_code() {
		return zone_code;
	}

	public void setZone_code(Integer zone_code) {
		this.zone_code = zone_code;
	}

	public String getZone_name() {
		return zone_name;
	}

	public void setZone_name(String zone_name) {
		this.zone_name = zone_name;
	}

	public Integer getParent_code() {
		return parent_code;
	}

	public void setParent_code(Integer parent_code) {
		this.parent_code = parent_code;
	}

	public Integer getNode_class() {
		return node_class;
	}

	public void setNode_class(Integer node_class) {
		this.node_class = node_class;
	}

	public Integer getZone_order() {
		return zone_order;
	}

	public void setZone_order(Integer zone_order) {
		this.zone_order = zone_order;
	}
	
}