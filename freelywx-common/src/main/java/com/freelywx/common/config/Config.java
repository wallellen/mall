package com.freelywx.common.config;

import com.rps.util.ClojureUtil;

public class Config {
	public static String SERVER_BASE =   ClojureUtil.getString("config/serPath");
	public static String UPLOAD_PATH =   ClojureUtil.getString("config/uploaderPath");
}
