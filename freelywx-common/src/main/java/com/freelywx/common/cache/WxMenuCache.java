//package com.freelywx.common.cache;
//
//import java.util.List;
//
//import com.freelywx.common.model.pub.TPubMenu;
//import com.freelywx.common.model.sys.TPMerchantWx;
//import com.google.common.cache.Cache;
//import com.google.common.cache.CacheBuilder;
//import com.rps.util.D;
///**
// * 缓存微信的相关信息，key为公众号原始ID
// * @author eric
// *
// */
//public class WxMenuCache extends AbstractCache<Integer, TPubMenu> {
//	@Override
//	public void loadCache() {
//		List<TPubMenu> menuList = D.selectAll(TPubMenu.class);
//		Cache<Integer, TPubMenu> c = CacheBuilder.newBuilder().initialCapacity(menuList.size()).build();
//		if(menuList != null && menuList.size() > 0 ){
//			for(TPubMenu menu : menuList){
//				c.put(menu.getMenu_id(), menu);
//			}
//		}
//		this.cache = c;
//	}
//	public void reload(){
//		this.cache.cleanUp();
//		loadCache();
//	}
//}
