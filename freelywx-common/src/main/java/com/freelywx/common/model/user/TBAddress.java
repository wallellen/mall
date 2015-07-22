package com.freelywx.common.model.user;

import org.apache.commons.lang.StringUtils;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_B_ADDRESS")
public class TBAddress {
	@GenerateByDb
	@Id
	private Long address_id;
	private Integer state_id;
	private String state_name;
	private String city_name;
	private Integer city_id;
	private Integer region_id;
	private String region_name;
	private String detail;

	public Long getAddress_id() {
		return address_id;
	}

	public void setAddress_id(Long address_id) {
		this.address_id = address_id;
	}

	public Integer getState_id() {
		return state_id;
	}

	public void setState_id(Integer state_id) {
		this.state_id = state_id;
	}

	public String getState_name() {
		return state_name;
	}

	public void setState_name(String state_name) {
		this.state_name = state_name;
	}

	public String getCity_name() {
		return city_name;
	}

	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}

	public Integer getCity_id() {
		return city_id;
	}

	public void setCity_id(Integer city_id) {
		this.city_id = city_id;
	}

	public Integer getRegion_id() {
		return region_id;
	}

	public void setRegion_id(Integer region_id) {
		this.region_id = region_id;
	}

	public String getRegion_name() {
		return region_name;
	}

	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append(this.state_name).append("-");
		sb.append(this.city_name).append("-");
		if (!StringUtils.isEmpty(this.region_name)) {
			sb.append(this.region_name).append("-");
		}
		sb.append(this.detail);
		return sb.toString();
	}

	public String toLoanString() {
		StringBuffer sb = new StringBuffer();
		sb.append(this.state_name).append("-");
		sb.append(this.city_name);
		// sb.append(this.region_name).append("-");
		// sb.append(this.detail);
		return sb.toString();
	}

}