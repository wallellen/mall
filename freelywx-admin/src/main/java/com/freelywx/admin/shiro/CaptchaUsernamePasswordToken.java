package com.freelywx.admin.shiro;

import org.apache.shiro.authc.UsernamePasswordToken;


public class CaptchaUsernamePasswordToken  extends UsernamePasswordToken {
	private static final long serialVersionUID = 6958299177899521941L;
	private String captcha;

	public String getCaptcha() {
		return captcha;
	}

	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}

	public CaptchaUsernamePasswordToken(String username, char[] password,
			boolean rememberMe, String host, String captcha) {
		super(username, password, rememberMe, host);
		this.captcha = captcha;
	}

}
