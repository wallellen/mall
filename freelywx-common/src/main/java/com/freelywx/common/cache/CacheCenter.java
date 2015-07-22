package com.freelywx.common.cache;

import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

import com.rps.util.D;
import com.rps.util.SpringContextUtil;
import com.rps.util.dao.dialet.MySqlDialet;

public class CacheCenter { 
	
	/**
	 * 日志 logger
	 */
	private static Logger logger = LoggerFactory.getLogger(CacheCenter.class);

	/**
	 * 注入BeanFactory
	 */
	@Autowired
	private BeanFactory beanFactory = null;

	/**
	 * Spring注入所有Cache类字节码
	 */
	private List<AbstractCache<?, ?>> cacheList = null;

	public List<AbstractCache<?, ?>> getCacheList() {
		return cacheList;
	}

	public void setCacheList(List<AbstractCache<?, ?>> cacheList) {
		this.cacheList = cacheList;
	}

	/**
	 * 初始化所有缓存
	 */
	public void loadCache() {
		System.out.println("------------ loadCache ------------");
		// 添加缓存Class
		for (AbstractCache<?, ?> cacheBean : cacheList) {
			cacheBean.loadCache();
		}
		System.out.println("------------ loadCache finish ------------");
		logger.debug("Cache init finish");
	}

}
