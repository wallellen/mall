package com.freelywx.common.cache;

import java.util.concurrent.TimeUnit;

import com.freelywx.common.wx.token.AccessToken;
import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;

/**
 * 缓存微信的相关信息，key appid
 * 
 * @author eric
 * 
 */
public class TokenCache extends AbstractCache<String, AccessToken> {
	@Override
	public void loadCache() {
		Cache<String, AccessToken> c = CacheBuilder.newBuilder()
				.expireAfterWrite(700, TimeUnit.SECONDS)
				.initialCapacity(10000).build();
		this.cache = c;
	}

	public void putValue(String key, AccessToken token) {
		this.cache.put(key, token);
	}
}
