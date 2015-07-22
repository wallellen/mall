package com.freelywx.mall.vo;

import java.util.List;

import com.freelywx.common.model.store.TmSite;

public class CityVo {
	private String city;
	private String cityname;
	private List<TmSite> sites;
	
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCityName() {
		return cityname;
	}
	public void setCityName(String cityname) {
		this.cityname = cityname;
	}
	public List<TmSite> getSites() {
		return sites;
	}
	public void setSites(List<TmSite> sites) {
		this.sites = sites;
	}

	
	
}
