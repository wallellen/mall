package com.freelywx.mall.cache;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.RemovalListener;
import com.google.common.cache.RemovalNotification;
import com.mowei.model.order.TOOrderPay;
import com.rps.util.ClojureUtil;
import com.rps.util.D;

public class CrowdOrderCache {
	private static Logger logger=LoggerFactory.getLogger(CrowdOrderCache.class);
	public static int TIME_OUT =   ClojureUtil.getInt("config/crowd_time_out");
	public static Cache<Long, TOOrderPay> cache = CacheBuilder
			.newBuilder().expireAfterAccess(TIME_OUT, TimeUnit.HOURS)
			.maximumSize(10)
			.removalListener(new RemovalListener<Long, TOOrderPay>() {
				public void onRemoval(
					RemovalNotification<Long, TOOrderPay> notification) {
					TOOrderPay order = notification.getValue();
					TOOrderPay order1 = D.selectById(TOOrderPay.class, order.getId());
					if(order1.getStatus().equals("") && order1.getPay_amount() >0 ){
						//操作订单信息
					}
				}
			}).build();
	
	
	
	public static TOOrderPay getBykey(final Long key) {
		try {
			return CrowdOrderCache.cache.get(key, new Callable<TOOrderPay>() {
				public TOOrderPay call() {
					return null;
				}
			});
		} catch (ExecutionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
}