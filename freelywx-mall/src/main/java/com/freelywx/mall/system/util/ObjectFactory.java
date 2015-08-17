package com.freelywx.mall.system.util;

import javax.servlet.ServletContext;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class ObjectFactory {
	protected static WebApplicationContext wac = null;
	private static ObjectFactory me = null;

	private ObjectFactory(WebApplicationContext wac) {
		ObjectFactory.wac = wac;
	}

	public static ObjectFactory getInstance(ServletContext servletContext) {
		if (null == me) {
			me = new ObjectFactory(
					WebApplicationContextUtils
							.getRequiredWebApplicationContext(servletContext));
		}
		return me;
	}

	public static ObjectFactory getInstance() {
		return me;
	}

	public static Object getObject(String objname) {
		return wac.getBean(objname);
	}
}
