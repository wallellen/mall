<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport"/>
<meta content="telephone=no" name="format-detection"/>
<title>订单详情</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript">
$(function(){
	$('.shoop_xq').click(function(){
		location.href = "${ctx}/getProd?prod_id=${prod.prod_id}";
	})
})
</script>
</head>
<body>
	<div class="tab_ul ds_list">订单详情 <a href="javascript:history.go(-1)" class="back_page"><img src="${img}/back.png" width="16" height="30" /></a> </div>

	<div class="list">
		<div class="status">
			<p>订单号：<span class="number_family">${order.order_id}</span></p>
			<p>订单状态：<span>
				<c:if test="${order.order_status==1}">已收单</c:if>
				<c:if test="${order.order_status==2}">已支付</c:if>
				<c:if test="${order.order_status==3}">已发货</c:if>
				<c:if test="${order.order_status==4}">已收货</c:if>
				<c:if test="${order.order_status==5}">已过期</c:if>
				<c:if test="${order.order_status==6}">已删除</c:if>
			</span> </p>
		</div>
		<div class="buy_number">
			<div class="list">
				<div class="shoop_xq clearfix">
					<img src="${prodPic.pic_url}" width="100" height="100" class="fl" />
					<div class="shoop_model">
						<p class="title_number" style="margin-top: 0px;">${prod.prod_name}</p>
						<p>酷魔方价：<span><fmt:formatNumber value="${prod.sale_price/100}" type="currency" pattern="￥ 0.00"/></span></p>
						<c:if test="${not empty orderDetailAttr}">
							<p>颜色：<c:if test="${not empty orderDetailAttr.prod_attr_value}">${orderDetailAttr.prod_attr_value}</c:if><c:if test="${empty orderDetailAttr.prod_attr_value}">无</c:if></p>
						</c:if>
						<p> 数量： <span>${orderDetail.prod_amount}</span></p>
					</div>
				</div>
			</div>
		</div>

		<!--收货地址 地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址：-->
		<div class="address">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td class="a_dz">
						<table cellpadding="0" cellspacing="0" border="0" width="100%"
							style="margin-top: 3px;">
							<tr>
								<td>地</td>
								<td align="right">址：</td>
							</tr>
						</table>
					</td>
					<td>
						<p class="pag_address">${order.address}</p>
						<p class="touch">${order.shipper}<span>${order.phone}</span> </p>
					</td>
				</tr>
			</table>
		</div>
		<!--收货地址-->

		<div class="address"> <span class="dispatching">配送方式：</span>普通快递 </div>
		<div class="address"> <span class="dispatching">优&nbsp; 惠&nbsp; 券：</span><c:if test="${not empty cc.cash_coupon_name}">${cc.cash_coupon_name}</c:if><c:if test="${empty cc.cash_coupon_name}">无</c:if></div>
		<div class="address">
			<span class="dispatching" style="vertical-align: middle;">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr> <td>总</td> <td align="right">价：</td> </tr>
				</table>
			</span><span style="vertical-align: middle;"><span class="number_family"><fmt:formatNumber value="${order.payment_price/100}" type="currency" pattern="￥ 0.00"/></span>（<c:if test="${order.order_type==1}">微信支付</c:if><c:if test="${order.order_type==2}">货到付款</c:if>）</span>
		</div>

		<div class="back_prce"> <a href="${ctx}/">返回首页</a> </div>
		<div class="back_prce" style="margin-top: 8px; padding-bottom: 14px;"> <a href="${ctx}/order/list">查看更多订单详情</a> </div>
		
	</div>
	
<jsp:include page="/foot.jsp" />
</body>
</html>