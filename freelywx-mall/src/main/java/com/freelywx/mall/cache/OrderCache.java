package com.freelywx.mall.cache;

import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.RemovalListener;
import com.google.common.cache.RemovalNotification;
import com.mowei.model.order.Order;
import com.mowei.model.order.TOOrderPay;
import com.rps.util.D;

public class OrderCache {
	private static Logger logger=LoggerFactory.getLogger(OrderCache.class);
	public static Cache<Long, Order> cache = CacheBuilder
			.newBuilder().expireAfterAccess(24*3600, TimeUnit.SECONDS)
			.maximumSize(10)
			.removalListener(new RemovalListener<Long, Order>() {
				public void onRemoval(
					RemovalNotification<Long, Order> notification) {
					Order order = notification.getValue();
					List<TOOrderPay> orderPaylist = D.sql("select * from  T_O_ORDER_PAY where order_id = ?").list(TOOrderPay.class, order.getOrder_id());
					for(TOOrderPay  pay :orderPaylist){
						if(pay != null && order.getPayment_price() == pay.getPay_amount()){
							order.setOrder_status("5");
							D.updateWithoutNull(order);
							break;
						}
					}
				}
			}).build();
	
	
	
	public static Order getBykey(final Long key) {
		try {
			return OrderCache.cache.get(key, new Callable<Order>() {
				public Order call() {
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