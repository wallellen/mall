package com.freelywx.mall.cache;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CacheThread implements Runnable {
	private static Logger logger = LoggerFactory.getLogger(CacheThread.class);
	public void run() {
		logger.info("cache刷新线程");
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 while (true) {
			 OrderCache.cache.cleanUp();
			 CrowdOrderCache.cache.cleanUp();
	         try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	     }
	}
}