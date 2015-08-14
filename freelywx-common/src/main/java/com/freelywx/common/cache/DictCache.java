package com.freelywx.common.cache;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.sys.SysDict;
import com.freelywx.common.model.sys.SysDictDetail;
import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import com.rps.util.D;

public class DictCache extends AbstractCache<String, List<SysDictDetail>> {

	/**
	 * 缓存初始化方法
	 */
	@Override
	public void loadCache() {
		List<SysDict> dictList = D.selectAll(SysDict.class);
		Cache<String,List<SysDictDetail>> c = CacheBuilder.newBuilder().initialCapacity(dictList.size()).build();
		for(SysDict dict : dictList){
			//查询对应的奖品信息
			List<SysDictDetail> detailList = D.sql("select * from t_sys_dict_detail where dict_param_status = ? and dict_id = ?").many(SysDictDetail.class,SystemConstant.State.STATE_ENABLE,dict.getDict_id());
			c.put(dict.getDict_id(), detailList);
		}
		this.cache = c;
	}
	
	public void reload(){
		this.cache.cleanUp();
		loadCache();
	}
	
	public String  getEnTextByVal(String value,String key){
		List<SysDictDetail> detailList  = this.get(key);
		String result = "" ;
		if(detailList != null && detailList.size() > 0){
			for(SysDictDetail detail : detailList){
				if(StringUtils.equals(detail.getDict_param_value(), value)){
					result = detail.getDict_param_name_en();
					break;
				}
			}
		}
		return result;
	}
	public String  getChTextByVal(String value,String key){
		List<SysDictDetail> detailList  = this.get(key);
		String result = "" ;
		if(detailList != null && detailList.size() > 0){
			for(SysDictDetail detail : detailList){
				if(StringUtils.equals(detail.getDict_param_value(), value)){
					result = detail.getDict_param_name();
					break;
				}
			}
		}
		return result;
	}
}
