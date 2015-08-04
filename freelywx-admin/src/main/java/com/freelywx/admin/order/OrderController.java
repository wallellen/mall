package com.freelywx.admin.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.cache.DictCache;
import com.freelywx.common.config.Config;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.member.MemberRule;
import com.freelywx.common.model.order.Order;
import com.freelywx.common.model.order.OrderDetail;
import com.freelywx.common.model.order.OrderDetailAttr;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

/**
 * 订单管理
 * 
 * @author alex
 */
@Controller
@RequestMapping(value = "/order")
public class OrderController {
	@Autowired
	private DictCache dictCache;
	
	@RequestMapping("")
	public String init()   {
		return "order/order";
	}

	@ResponseBody
	@RequestMapping("/list")
	public PageModel list(HttpServletRequest request, HttpServletResponse response)  {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		Map<String,Object> map = new HashMap<>();
		map.put("site_id", user.getSite_id());
		map.put("order_status", 0);
		PageModel page = PageUtil.getPageModel(Order.class, "sql.order/getOrderlist", request,map);
		return page;
	}

	@RequestMapping("/detail/{order_id}")
	public String detail(@PathVariable("order_id") String order_id, Model model)  {
		Order order = D.selectById(Order.class, order_id);
		List<OrderDetail> details = D.sqlAt("sql.order/getOrderDetail").many(OrderDetail.class, order_id);
		order.setOrder_status(dictCache.getChTextByVal(order.getOrder_status(), "ORDER_STATUS") );
		order.setPayment_type(dictCache.getChTextByVal(order.getPayment_type(), "PAYMENT_TYPE"));
		order.setPayment_channel(dictCache.getChTextByVal(order.getPayment_channel(),"PAYMENT_CHANNEL"));
		model.addAttribute("order", order);

		for (OrderDetail orderDetail : details) {
			List<OrderDetailAttr> odaList=D.sql("select * from T_O_ORDER_DETAIL_ATTR where detail_id=?").many(OrderDetailAttr.class, orderDetail.getDetail_id());
			if(odaList != null && odaList.size()>0){
				List<Map<String,String>> attrList = new ArrayList<>();
				for(OrderDetailAttr oda : odaList){
					Map<String,String> map = new HashMap<>();
					map.put(oda.getProd_attr(), oda.getProd_attr_value());
					attrList.add(map);
				}
				orderDetail.setAttrList(attrList);
			} 
		}
		model.addAttribute("details", details);
		model.addAttribute("serverUrl", Config.SERVER_BASE);
		return "order/detail";
	}

	@RequestMapping("/send/{order_id}")
	@ResponseBody
	public boolean send(@PathVariable("order_id") Long order_id, Model model)   {
		String updateSql = "update T_O_ORDER set ORDER_STATUS = ? ,SENDER_TIME = now() where ORDER_ID = ?";
		return D.sql(updateSql).update(SystemConstant.OrderStatus.DELIVER, order_id) >0;
	}

	@ResponseBody
	@RequestMapping("/receive/{order_id}")
	public boolean receive(@PathVariable("order_id") Long order_id, Model model)  {
		String updateSql = "update T_O_ORDER set ORDER_STATUS = ? ,SENDER_TIME = now() where ORDER_ID = ?";
		return D.sql(updateSql).update(SystemConstant.OrderStatus.RECEIVED, order_id) >0;
	}

	
	private static int getLevel( int oraderAmount) {
		Integer[] levelArr  = null;
		int length = 0;
		List<MemberRule> ruleList = D.sql("select * from T_M_RULE order by  rule_id").many(MemberRule.class);
		if(ruleList != null && ruleList.size() >0){
			length = ruleList.size();
			levelArr = new Integer[length];
			for (int i = 0; i <length; i++) {
				levelArr[i] = ruleList.get(i).getSale_more_than();
			}
		}
		int result = length;
		for (int i = 0; i < length - 1 ; i++) {
			if(oraderAmount < levelArr[i]){
				result = i;
				break;
			}else if(oraderAmount >= levelArr[i] && oraderAmount < levelArr[i+1]){
				result = i+1;
				break;
			} 
		}	
		return result;
	}
}
