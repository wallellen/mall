/**
 * Copyright (c) 2011-2014, James Zhan 詹波 (jfinal@126.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */

package com.freelywx.common.wx.api;

import com.freelywx.common.wx.utils.HttpUtil;
 

/**
 * menu api
 */
public class MenuApi {
	
	private static String getMenu = "https://api.weixin.qq.com/cgi-bin/menu/get?access_token=";
	private static String createMenu = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=";
	
	/**
	 * 查询菜单
	 */
	public static ApiResult getMenu(String appid, String appsecret) {
		String jsonResult = HttpUtil.get(getMenu + AccessTokenApi.getAccessToken(appid, appsecret).getAccessToken());
		return new ApiResult(jsonResult);
	}
	
	/**
	 * 创建菜单
	 */
	public ApiResult createMenu(String appid, String appsecret,String jsonStr) {
		String jsonResult = HttpUtil.post(createMenu + AccessTokenApi.getAccessToken(appid, appsecret).getAccessToken(), jsonStr);
		return new ApiResult(jsonResult);
	}
}


