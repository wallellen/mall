package com.freelywx.mall.vo;

import java.util.List;

import com.freelywx.common.model.store.TsiteBuilding;

public class SearchVo {
	private TsiteBuilding building;
	private List<TsiteBuilding> all_buildings;
	public TsiteBuilding getBuilding() {
		return building;
	}
	public void setBuilding(TsiteBuilding building) {
		this.building = building;
	}
	public List<TsiteBuilding> getAll_buildings() {
		return all_buildings;
	}
	public void setAll_buildings(List<TsiteBuilding> all_buildings) {
		this.all_buildings = all_buildings;
	}



}
