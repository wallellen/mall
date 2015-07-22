<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp" %>
<!doctype html>
<html>
<head>
<title></title>
<jsp:include page="/meta.jsp" />
<style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%; 
  	}    
	.table td{
	 border: 1px solid #ccc; padding-left: 10px;
	}
	.detail_table th{ border: 1px solid #ccc; }
</style>
</head>
<body>
	<div class="mini-fit">
	<table style="width: 100%;" class="table" cellpadding="0" cellspacing="0">
		<tr>
			<td style="width: 100px;"><b>订单号:</b></td>
			<td><b>${order.order_id}</b></td>
			<td style="width: 100px;"><b>状态：</b></td>
			<td><b id="orderStatus">${order.order_status}</b></td>
		</tr>
		<tr>
			<td colspan="4" style="height: 12px"></td>
		</tr>
		<tr>
			<td colspan="4" style="background:#eee;"><b>付款信息</b></td>
		</tr>
		<tr>
			<td colspan="3" >付款方式：</td>
			<td>${order.payment_type}</td>
		<c:if test="${order.payment_channel != null && order.payment_channel != ''}">
			<td>付款渠道：</td>
			<td>${order.payment_channel}</td>
		</c:if>
		</tr>
		<tr>
			<td>总商品数：</td>
			<td>${order.prod_amount}件</td>
			<td>总商品金额：</td>
			<td class="price">${order.total_prod_price}</td>
		</tr>
		<tr>
			<td>优惠后总金额：</td>
			<td class="price">${order.total_discount_price}</td>
			<td>用卷抵扣总金额：</td>
			<td class="price">${order.total_coupon_price}</td>
		</tr>
		<tr>
			<td>实际运费：</td>
			<td class="price">${order.transit_price}</td>
			<td>实际支付金额：</td>
			<td class="price">${order.payment_price}</td>
		</tr>
		<tr>
			<td colspan="4" style="height: 12px"></td>
		</tr>
		<tr>
			<td colspan="4" style="background:#eee;"><b>收货人信息</b></td>
		</tr>
		<tr>
			<td>收款人：</td>
			<td colspan="3">${order.shipper}</td>
		</tr>
		<tr>
			<td>地址：</td>
			<td colspan="3">${order.address}</td>
		</tr>
		<tr>
			<td>固定电话：</td>
			<td colspan="3">${order.phone}</td>
		</tr>
		<tr>
			<td>手机号：</td>
			<td colspan="3">${order.mobile}</td>
		</tr>
		<tr>
			<td>电子邮箱：</td>
			<td colspan="3">${order.email}</td>
		</tr>
		<tr>
			<td colspan="4" style="height: 12px"></td>
		</tr>
		<tr>
			<td colspan="4" style="background:#eee;"><b>发票信息</b></td>
		</tr>
		<tr>
			<td>发票类型：</td>
			<%--
			<td colspan="3">${order.invoice_type}</td>
			 --%>
			<td colspan="3">普通发票</td>
		</tr>
		<c:if test="${order.invoice_title != null}">
		<tr>
			<td>发票抬头：</td>
			<td>${order.invoice_title}</td>
		</tr>
		</c:if>
		<c:if test="${order.invoice_content != null}">
		<tr>
			<td>发票内容：</td>
			<td>${order.invoice_content}</td>
		</tr>
		</c:if>
		<tr>
			<td colspan="4" style="height: 12px"></td>
		</tr>
		<tr>
			<td colspan="4" style="background:#eee;"><b>订单详情</b></td>
		</tr>
	</table>
	<table style="width: 100%; border:0" class="detail_table" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<th style="width:180px;">商品编号</th>
				<th style="width:180px;">商品名称</th>
				<th>商品图片</th>
				<th>商品颜色</th>
				<th>优惠价格</th>
				<th>商品数量</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${details}" var="detail">
			<tr>
				<th>${detail.prod_code}</th>
				<th>${detail.prod_name}</th>
				<th><img src="${serverUrl }${detail.prod_img_url}" height="60px" /></th>
				<th>
					<c:forEach items="${detail.attrList }" var="attr">
						<c:forEach items="${attr }" var="map">
						<span>${map.key }:${map.value }</span>
						</c:forEach>
					</c:forEach>
				</th>
				<th class="price" style="color:red;">${detail.prod_price}</th>
				<th>${detail.prod_amount}件</th>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	<script type="text/javascript">
	var dictMap = new Map();
		$(function() {
			$('.price').each(function() {
				$(this).text(parsePrice($(this).text() / 100));
			});
			//$("#orderStatus").text(getDictValue("${order.order_status}","order_status","ORDER_STATUS"));
		});
	</script>
</body>
</html>