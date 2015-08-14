package com.freelywx.admin.admin.rbac;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.cache.ZoneCache;
import com.freelywx.common.model.sys.SysZone;

/**
 * 首页控制类
 * 
 * @author Administrator
 * 
 */
@Controller
@RequestMapping("/zone")
public class ZoneController {
	@Autowired
	private ZoneCache zoneCache;
	
	@ResponseBody
	@RequestMapping(value = "/province")
	public List<SysZone> province() {
		return zoneCache.getProvince();
	}
	
	@ResponseBody
	@RequestMapping(value = "/city/{parId}")
	public List<SysZone> city(@PathVariable int parId) {
	 
		return  zoneCache.getCity(parId);
	}
	
	@ResponseBody
	@RequestMapping(value = "/district/{parId}")
	public List<SysZone> dictrict(@PathVariable int parId) {
		return zoneCache.getDistrict(parId);
	}

}
