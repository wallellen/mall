<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta content="telephone=no" name="format-detection" />
<title>收到的礼品订单</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript">
	$(function() {
		
		$('#pSel').change(function(){
			var pid = $(this).val();
			var nid = 2;
			$.post("${ctx}/order/zone",{
				"pid" : pid,
				"nid" : nid
			},function(text){
				$('#cSel').html("");
				$('#cSel').html(text);
			})
		})
		
		$('.tj').click(function() {
			var n = $('#n').val().trim();
			var p = $('#p').val().trim();
			var a = $('#a').val().trim();
			var pv = $("#pSel option:selected").val();
			var pt = $("#pSel option:selected").text();
			var cv = $("#cSel option:selected").val();
			var ct = $("#cSel option:selected").text();
			
			if(n == "" || p == "" || a == "" || pv == 0 || cv == 0){
				alert("以上选项必填")
			}else{
				$.post("${ctx}/order/updAddrOrder",{
					"order_id" : "${order.order_id}",
					"n" : n,
					"p" : p,
					"a" : pt + ct + a
				},function(text){
					if(text == 1){
						location.href = "${ctx}/";
					}else if(text == -1){
						alert("地址已填写")
					}else{
						alert("提交失败")
					}
				})
			}
			
		})
		
	});
</script>
</head>
<body>
	<c:if test="${addressS==1}"><input type="hidden" class="addr_id" value="0" /></c:if>
	<c:if test="${addressS==0}"><input type="hidden" class="addr_id" value="${address.address_id}" /></c:if>

	<div class="tab_ul ds_list">收到的礼品订单</div>
	<div class="ds_list succress_top">${tip.text}</div>

	<div class="confirm_info">订单信息</div>
	<div class="list">

		<div class="buy_number">
			<div class="list">
				<div class="shoop_xq clearfix">
					<img src="${prodPic.pic_url}" width="85" height="85" class="fl" />
					<div class="shoop_model">
						<p class="title_number" style="margin-top: 0px;">${prod.prod_name}</p>
						<p>酷魔方价：<span class="number_family"><fmt:formatNumber value="${prod.sale_price/100}" type="currency" pattern="￥ 0.00" /></span></p>
						<p>颜色：<c:if test="${not empty color}">${color}</c:if><c:if test="${empty color}">无</c:if></p>
						<p>数量： <span>${order.prod_amount}</span></p>
					</div>
				</div>
			</div>
		</div>
		
		<div class="address">
			<span class="dispatching">配送方式：</span>普通快递
		</div>
		<%-- <div class="address">
			<span class="dispatching">优&nbsp; 惠&nbsp; 券：</span>
			<c:if test="${not empty cc.cash_coupon_name}">${cc.cash_coupon_name}</c:if>
			<c:if test="${empty cc.cash_coupon_name}">无</c:if>
		</div> --%>

	</div>
	
	<div class="confirm_info"><div class="boder_p">收货地址</div></div>

	<div class="list list_last">
		<div class="add_address_public">
			<p>
				<font>收&nbsp;货&nbsp;人</font><span><input type="text" placeholder="姓名" id="n" /></span>
			</p>
		</div>
		<div class="add_address_public">
			<p>
				<font>手机号码</font><span><input type="text" placeholder="手机号码" id="p" /></span>
			</p>
		</div>
		<div class="add_address_public">
			<p>
				<font style="height: 34px; line-height: 34px">省&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份</font>
				<span class="select"><select id="pSel">
						<option value="0">--选择省份--</option>
					<c:forEach items="${zone}" var="zone">
						<option value="${zone.zone_code}">${zone.zone_name}</option>
					</c:forEach>
				</select></span>
			</p>
		</div>
		<div class="add_address_public">
			<p>
				<font style="height: 34px; line-height: 34px">市&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区</font>
				<span class="select"><select id="cSel">
						<option value="0">--选择市区--</option>
				</select></span>
			</p>
		</div>
		<div class="add_address_public">
			<p>
				<font>详细地址</font><span><input type="text" placeholder="详细地址" id="a" /></span>
			</p>
		</div>
	</div>

	<div class="total tatal_no">总价：<span class="countPrice"><fmt:formatNumber value="${order.payment_price/100}" type="currency" pattern="￥ 0.00" /></span></div>

	<div class="list">
		<div class="pay">
			<a href="javascript:void(0)" class="wx tj">提交</a>
		</div>
	</div>

	<jsp:include page="/foot.jsp" />
</body>
</html>