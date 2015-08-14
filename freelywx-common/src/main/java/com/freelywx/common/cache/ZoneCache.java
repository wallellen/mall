package com.freelywx.common.cache;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.freelywx.common.common.JsonMapper;
import com.freelywx.common.model.sys.SysZone;
import com.freelywx.common.redis.JedisTemplate;
import com.rps.util.D;

public class ZoneCache {
	private static JedisTemplate jedisTemplate;
	public final static String PROVINCE_KEY = "PROVINCE_KEY"; // 省信息缓存
	public final static String CITY_KEY = "CITY_KEY"; // 城市信息缓存
	public final static String DISTRICT_KEY = "DISTRICT_KEY"; // 区信息缓存
	public ZoneCache(JedisTemplate jedisTemplate) {
		ZoneCache.jedisTemplate = jedisTemplate;
	}

	public List<SysZone> getProvince() {
		List<SysZone> list = new ArrayList<SysZone>();
		String key = PROVINCE_KEY ;
		String str = jedisTemplate.get(key);
		if(StringUtils.isEmpty(str)){
			list = D.sql(
					"select * from t_sys_zone where node_class = 1   ")
					.list(SysZone.class );
			jedisTemplate.set(key, JsonMapper.alwaysMapper().toJson(list));
		}else {
			list = JsonMapper.alwaysMapper().fromJson(str,  JsonMapper.alwaysMapper().createCollectionType(ArrayList.class, SysZone.class));
		}
		return list;
	}
	public List<SysZone> getCity(int parId) {
		List<SysZone> list = new ArrayList<SysZone>();
		String key = CITY_KEY +":"+ String.valueOf(parId);
		String str = jedisTemplate.get(key);
		if(StringUtils.isEmpty(str)){
			list = D.sql(
					"select * from t_sys_zone where node_class = 2 and parent_code = ? ")
					.list(SysZone.class, parId);
			jedisTemplate.set(key, JsonMapper.alwaysMapper().toJson(list));
		}else {
			list = JsonMapper.alwaysMapper().fromJson(str,  JsonMapper.alwaysMapper().createCollectionType(ArrayList.class, SysZone.class));
		}
		return list;
	}
	
	public List<SysZone> getDistrict(int parId) {
		List<SysZone> list = new ArrayList<SysZone>();
		String key = DISTRICT_KEY +":"+ String.valueOf(parId);
		String str = jedisTemplate.get(key);
		if(StringUtils.isEmpty(str)){
			list = D.sql(
					"select * from t_sys_zone where node_class = 3 and parent_code = ? ")
					.list(SysZone.class, parId);
			jedisTemplate.set(key, JsonMapper.alwaysMapper().toJson(list));
		}else {
			list = JsonMapper.alwaysMapper().fromJson(str,  JsonMapper.alwaysMapper().createCollectionType(ArrayList.class, SysZone.class));
		}
		return list;
	}
}
