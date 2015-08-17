<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
<meta content="telephone=no" name="format-detection"/>
<title>交易成功</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript">
$(function(){
	$('.jxgg').click(function(){
		location.href="${ctx}/";
	})
	$('.fr').click(function(){
		location.href="${ctx}/order/finish?order_id=${order.order_id}&type=2";
	})
})
</script>
</head>

<body>
<div class="ds_list succress_top">${tip.text}</div>

<div class="pag_success">
	<img src="${img}/success.jpg" width="30" height="30" />购买成功！
	<c:if test="${order.order_type==1}">已支付</c:if>
	<c:if test="${order.order_type==2}">货到付款</c:if>
	<fmt:formatNumber value="${order.payment_price/100}" type="currency" pattern="0.00"/>元
</div>

<div class="go clearfix">
	<a href="javascript:void(0)" class="fl jxgg">继续逛逛</a>
	<a href="javascript:void(0)" class="fr">查看订单</a>
</div>

<div class="info">订单信息</div>

<!--list 商品-->
<div class="success_shoop clearfix">
	<a href="${ctx}/getProd?prod_id=${prod.prod_id}"><img src="${prodPic.pic_url}" width="98" height="110" class="fl" /></a>
	<div class="shoop_abstract">
		<div class="shoop_title">${prod.prod_name}</div>
		<p>酷魔方价：<fmt:formatNumber value="${prod.sale_price/100}" type="currency" pattern="￥ 0.00"/></p>
		<c:if test="${not empty orderDetailAttr}">
			<p>颜色：<c:if test="${not empty orderDetailAttr.prod_attr_value}">${orderDetailAttr.prod_attr_value}</c:if><c:if test="${empty orderDetailAttr.prod_attr_value}">无</c:if></p>
		</c:if>
		<p>数量：${orderDetail.prod_amount}</p>
		<p>总价：<fmt:formatNumber value="${order.payment_price/100}" type="currency" pattern="￥ 0.00"/></p>
	</div>
</div>
<!--list 商品-->

<jsp:include page="/foot.jsp" />
</body>
</html>