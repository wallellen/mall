package com.freelywx.common.util;

import java.util.UUID;

import org.joda.time.DateTime;

public class UUIDs {
	
	public static String getRandomUUID() {
		return UUID.randomUUID().toString().replace("-", "");
	}
	
	public static String getTimestamp() {
		return new DateTime().toString("yyyyMMddHHmmss");
	}
	
}
