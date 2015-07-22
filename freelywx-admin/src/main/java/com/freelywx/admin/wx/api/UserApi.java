/**
 * Copyright (c) 2011-2014, James Zhan 詹波 (jfinal@126.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */

package com.freelywx.admin.wx.api;

import com.freelywx.admin.wx.utils.HttpUtil;
import com.freelywx.admin.wx.utils.ParaMap;
 

/**
 * 用户管理 API
 * https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN
 */
public class UserApi {
	private static String getUserInfo = "https://api.weixin.qq.com/cgi-bin/user/info";
	private static String getFollowers = "https://api.weixin.qq.com/cgi-bin/user/get";
	public static ApiResult getUserInfo(String appid, String appsecret,String openId) {
		ParaMap pm = ParaMap.create("access_token", AccessTokenApi.getAccessToken(appid, appsecret).getAccessToken()).put("openid", openId).put("lang", "zh_CN");
		return new ApiResult(HttpUtil.get(getUserInfo, pm.getData()));
	}
	public static ApiResult getFollowers(String appid, String appsecret,String nextOpenid) {
		ParaMap pm = ParaMap.create("access_token",AccessTokenApi.getAccessToken(appid, appsecret).getAccessToken());
		if (nextOpenid != null)
			pm.put("next_openid", nextOpenid);
		return new ApiResult(HttpUtil.get(getFollowers, pm.getData()));
	}
}
