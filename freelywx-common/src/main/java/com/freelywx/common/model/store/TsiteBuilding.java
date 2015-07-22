package com.freelywx.common.model.store;

import java.util.Date;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_m_building")
public class TsiteBuilding {
	@Id
	@GenerateByDb
	private Integer build_id;

	private Integer site_id;

	private String build_name;

	private Integer sort;

	private String latitude;

	private String longitude;

	private String status;

	private String description;

	private String has_site;
	private Integer distance;

	private Integer creator;

	private Date create_time;

	private Integer modify;

	private Date modify_time;

	@ColumnIgnore
	private String site_name;

	public Integer getBuild_id() {
		return build_id;
	}

	public void setBuild_id(Integer build_id) {
		this.build_id = build_id;
	}

	public Integer getSite_id() {
		return site_id;
	}

	public void setSite_id(Integer site_id) {
		this.site_id = site_id;
	}

	public String getBuild_name() {
		return build_name;
	}

	public void setBuild_name(String build_name) {
		this.build_name = build_name;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getHas_site() {
		return has_site;
	}

	public void setHas_site(String has_site) {
		this.has_site = has_site;
	}

	public Integer getDistance() {
		return distance;
	}

	public void setDistance(Integer distance) {
		this.distance = distance;
	}

	public Integer getCreator() {
		return creator;
	}

	public void setCreator(Integer creator) {
		this.creator = creator;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getModify() {
		return modify;
	}

	public void setModify(Integer modify) {
		this.modify = modify;
	}

	public Date getModify_time() {
		return modify_time;
	}

	public void setModify_time(Date modify_time) {
		this.modify_time = modify_time;
	}

	public String getSite_name() {
		return site_name;
	}

	public void setSite_name(String site_name) {
		this.site_name = site_name;
	}

}
