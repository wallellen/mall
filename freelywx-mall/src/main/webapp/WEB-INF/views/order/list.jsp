<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
<meta content="telephone=no" name="format-detection"/>
<title>全部订单</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript">
$(function(){
	$('.order_list').click(function(){
		var order_id = $(this).children("input[name='order_id']").val();
		var order_type = $(this).children("input[name='order_type']").val();
		var prod_id = $(this).children("input[name='prod_id']").val();
		
		if(order_type == 2){
			location.href="${ctx}/raise/detail?order_id="+order_id;
		}else{
			location.href="${ctx}/order/finish?order_id="+order_id+"&type=2";
		}
	})
	
	var oldLink = document.referrer;
	if (oldLink == "" || oldLink.search("member") != -1) {
		$('.back_page').attr("href", "${ctx}/member");
	} else {
		$('.back_page').attr("href", "javascript:history.go(-1)");
	}
})
</script>
</head>

<body>
<div class="tab_ul ds_list">全部订单
	<a href="${ctx}/member" class="back_page"><img src="${img}/back.png" width="16" height="25"/></a> 
</div>

<div class="total_order">
	<div class="list" style="padding-top:5px;">
		<c:if test="${empty orderList}">
			<div class="dl_center">
				<img src="${img}/gt.png" width="38" height="38" />暂无订单
			</div>
		</c:if>
    	
    	<c:if test="${not empty orderList}">
    	<c:forEach items="${orderList}" var="order">
        <div class="order_list">
           	<input type="hidden" name="order_type" value="${order.type}" />
           	<input type="hidden" name="order_id" value="${order.order_id}" />
           	
        	<div class="order_status">
       	    	<p>订&nbsp;&nbsp;单&nbsp;&nbsp;号：<span class="number_family">${order.order_id}</span></p>
        		<p>下单时间：<fmt:formatDate value="${order.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></p>
    		</div>
    		
         	<c:forEach items="${map}" var="map">
            <c:if test="${map.key==order.order_id}">
            <input type="hidden" name="prod_id" value="${map.value.prod_id}" />
            <div class="order_shoop clearfix">
            	<img src="${map.value.prod_img_url}" width="62" height="62" class="fl" />
                <div class="order_shoop_status">
                	<p class="name">${map.value.prod_name}</p>
                    <p class="mondy">订单金额：<span class="number_family"><fmt:formatNumber value="${order.payment_price/100}" type="currency" pattern="￥ 0.00"/></span></p>
                </div>
            </div>
            </c:if>
            </c:forEach>
            
            <p class="orderstatus">订单状态:<span>
            	<c:if test="${order.order_status==1}">已收单</c:if>
				<c:if test="${order.order_status==2}">已支付</c:if>
				<c:if test="${order.order_status==3}">已发货</c:if>
				<c:if test="${order.order_status==4}">已收货</c:if>
				<c:if test="${order.order_status==5}">已过期</c:if>
				<c:if test="${order.order_status==6}">已删除</c:if>
			</span></p>
        </div>
        </c:forEach>
        </c:if>
        
    </div>
</div>

<jsp:include page="/foot.jsp" />
</body>
</html>