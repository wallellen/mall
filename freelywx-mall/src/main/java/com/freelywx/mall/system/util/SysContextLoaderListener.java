package com.freelywx.mall.system.util;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletException;
import javax.sql.DataSource;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoaderListener;

import com.rps.util.D;
import com.rps.util.SpringContextUtil;
import com.rps.util.dao.dialet.MySqlDialet;

public class SysContextLoaderListener extends ContextLoaderListener implements
		ServletContextListener {

	public void contextDestroyed(ServletContextEvent event) {
		super.contextDestroyed(event);
	}

	public void contextInitialized(ServletContextEvent event) {
		super.contextInitialized(event);
		ServletContext servletContext = event.getServletContext();

		if (servletContext != null) {
			ObjectFactory.getInstance(servletContext);
		}

		try {
			init();
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void init() throws ServletException, IOException {

		ApplicationContext ctx = getCurrentWebApplicationContext();
		
		 SpringContextUtil.setApplicationContext(ctx);
		 DataSource dataSource = SpringContextUtil.getBean("dataSource");
		 D.setDataSourceAndDialet(dataSource, new MySqlDialet());
	}
}
