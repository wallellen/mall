package com.freelywx.common.cache;

import java.util.List;

import com.freelywx.common.model.sys.TPMerchantWx;
import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import com.rps.util.D;
/**
 * 缓存微信的相关信息，key为公众号原始ID,对应的appid  appsecret
 * @author eric
 *
 */
public class WxCache extends AbstractCache<String, TPMerchantWx> {
 
	@Override
	public void loadCache() {
		List<TPMerchantWx> wxList = D.selectAll(TPMerchantWx.class);
		Cache<String,TPMerchantWx> c = CacheBuilder.newBuilder().initialCapacity(wxList.size()).build();
		if(wxList != null && wxList.size() > 0 ){
			for(TPMerchantWx merchantWx : wxList){
				//查询对应的奖品信息
				c.put(merchantWx.getOriginal_id(), merchantWx);
			}
		}
		this.cache = c;
	}
	public void reload(){
		this.cache.cleanUp();
		loadCache();
	}
}
