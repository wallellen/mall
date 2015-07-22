package com.freelywx.common.util;

import java.security.MessageDigest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MD5Encoder {
	private static Logger logger = LoggerFactory.getLogger(MD5Encoder.class);

	private static String byte2hex(byte[] b) {
		StringBuffer hs = new StringBuffer();
		String stmp = "";
		for (int n = 0; n < b.length; n++) {
			stmp = (Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1) {
				hs = hs.append("0").append(stmp);
			} else {
				hs = hs.append(stmp);
			}
		}
		return hs.toString().toUpperCase();
	}

	public static String encode(String input) {
		try {
			MessageDigest alga = MessageDigest.getInstance("MD5");
			alga.update(input.getBytes());
			return byte2hex(alga.digest());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";

	}

}