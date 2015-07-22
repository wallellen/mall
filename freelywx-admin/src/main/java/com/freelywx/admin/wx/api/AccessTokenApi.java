/**
 * Copyright (c) 2011-2014, James Zhan 詹波 (jfinal@126.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */

package com.freelywx.admin.wx.api;

import java.io.IOException;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.freelywx.admin.cache.TokenCache;
import com.freelywx.admin.wx.token.AccessToken;
import com.freelywx.admin.wx.utils.HttpUtil;
import com.freelywx.admin.wx.utils.ParaMap;
import com.rps.util.SpringContextUtil;

public class AccessTokenApi {
	private static final Logger logger = LoggerFactory.getLogger(AccessTokenApi.class);
	 
	// "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
	private static String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential";
	private static TokenCache tokenCache = SpringContextUtil.getBean("tokenCache");
	
	public static AccessToken getAccessToken(String appid, String appsecret) {
		AccessToken token =  null;
		try{ 
			token = tokenCache.get(appid); 
		}catch (Exception e) {
			logger.error("tokenCache 查询失效，",e);
		}
		
		if (token != null && token.isAvailable()){
			return token;
		} 
		token =refreshAccessToken(appid, appsecret);
		tokenCache.putValue(appid, token);	
		 
		return token;
	}
	 
	public static AccessToken refreshAccessToken(String appid, String appsecret) {
		return  requestAccessToken(appid, appsecret);
	}
	
	private static synchronized AccessToken requestAccessToken(String appid, String appsecret) {
		AccessToken result = null;
		for (int i=0; i<3; i++) {
			Map<String, String> queryParas = ParaMap.create("appid", appid).put("secret", appsecret).getData();
			String json = HttpUtil.get(url, queryParas);
			result = new AccessToken(json);
			
			if (result.isAvailable())
				break;
		}
		logger.info("get token from wx ,"+result.getAccessToken());
		return result;
	}
	
	public static void main(String[] args) throws JsonParseException, JsonMappingException, IOException {
		AccessToken at = requestAccessToken("wx39e9743be9d5e2c7","e674c2388661c989d140ac1634b491ba");
 
		if (at.isAvailable())
			System.out.println("access_token : " + at.getAccessToken());
		else
			System.out.println(at.getErrorCode() + " : " + at.getErrorMsg());
	}
}
