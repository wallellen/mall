package com.freelywx.common.cache;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.freelywx.common.common.JsonMapper;
import com.freelywx.common.model.user.TBZone;
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

	public List<TBZone> getProvince() {
		List<TBZone> list = new ArrayList<TBZone>();
		String key = PROVINCE_KEY ;
		String str = jedisTemplate.get(key);
		if(StringUtils.isEmpty(str)){
			list = D.sql(
					"select * from T_B_ZONE where node_class = 1   ")
					.list(TBZone.class );
			jedisTemplate.set(key, JsonMapper.alwaysMapper().toJson(list));
		}else {
			list = JsonMapper.alwaysMapper().fromJson(str,  JsonMapper.alwaysMapper().createCollectionType(ArrayList.class, TBZone.class));
		}
		return list;
	}
	public List<TBZone> getCity(int parId) {
		List<TBZone> list = new ArrayList<TBZone>();
		String key = CITY_KEY +":"+ String.valueOf(parId);
		String str = jedisTemplate.get(key);
		if(StringUtils.isEmpty(str)){
			list = D.sql(
					"select * from T_B_ZONE where node_class = 2 and parent_code = ? ")
					.list(TBZone.class, parId);
			jedisTemplate.set(key, JsonMapper.alwaysMapper().toJson(list));
		}else {
			list = JsonMapper.alwaysMapper().fromJson(str,  JsonMapper.alwaysMapper().createCollectionType(ArrayList.class, TBZone.class));
		}
		return list;
	}
	
	public List<TBZone> getDistrict(int parId) {
		List<TBZone> list = new ArrayList<TBZone>();
		String key = DISTRICT_KEY +":"+ String.valueOf(parId);
		String str = jedisTemplate.get(key);
		if(StringUtils.isEmpty(str)){
			list = D.sql(
					"select * from T_B_ZONE where node_class = 3 and parent_code = ? ")
					.list(TBZone.class, parId);
			jedisTemplate.set(key, JsonMapper.alwaysMapper().toJson(list));
		}else {
			list = JsonMapper.alwaysMapper().fromJson(str,  JsonMapper.alwaysMapper().createCollectionType(ArrayList.class, TBZone.class));
		}
		return list;
	}
}
