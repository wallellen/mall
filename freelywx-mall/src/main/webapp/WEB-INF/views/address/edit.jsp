<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
<meta content="telephone=no" name="format-detection"/>
<title>收货地址</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript">
$(function(){
	var prod_id = $('#prod_id').val();
	var count = $('#count').val();
	var color = $('#color').val();
	var coupon = $('#coupon').val();
	var id = $('#id').val();
	
	$('.wx').click(function(){
		var name = $('#name').val().trim();
		var phone = $('#phone').val().trim();
		var address = $('#address').val().trim();
		if(name==""||phone==""||address==""){
			alert("全部不能为空")
		}else {
			if(id==""||id==null){
				$.post("${ctx}/addr/addAddress", {
					"name" : name,
					"phone" : phone,
					"address" : address
				}, function(result) {
					if (result == 1) {
						alert("新增成功");
						location.href="${ctx}/addr/address?prod_id="+prod_id+"&count="+count+"&color="+color+"&coupon="+coupon;
					} else {
						alert("新增失败");
					}
				});
			}else{
				$.post("${ctx}/addr/updAddress", {
					"id" : id,
					"name" : name,
					"phone" : phone,
					"address" : address
				}, function(result) {
					if (result == 1) {
						alert("修改成功");
						location.href="${ctx}/addr/address?prod_id="+prod_id+"&count="+count+"&color="+color+"&coupon="+coupon;
					} else {
						alert("修改失败");
					}
				});
			}
		}
	})
	
	$('.delivery').click(function(){
		location.href="${ctx}/addr/address?prod_id="+prod_id+"&count="+count+"&color="+color+"&coupon="+coupon;
	})
})
</script>
</head>
<body>
<input type="hidden" id="prod_id" value="${prod_id}" />
<input type="hidden" id="count" value="${count}" />
<input type="hidden" id="color" value="${color}" />
<input type="hidden" id="coupon" value="${coupon}" />
<input type="hidden" id="id" value="${id}" />

<div class="tab_ul ds_list"><c:if test="${not empty id}">修改</c:if><c:if test="${empty id}">新增</c:if>收货地址<a href="javascript:history.go(-1)" class="back_page"><img src="${img}/back.png" width="16" height="25"/></a></div>

<div class="padding_b">
	<div class="add_address_public"><p><font>收货人</font><span><input type="text" placeholder="姓名" id="name" value="${address.consignee_name}"/></span></p></div>
	<div class="add_address_public"><p><font>手机号码</font><span><input type="text" placeholder="手机号码" id="phone" value="${address.phone}" maxlength="11"/></span></p></div>
	<!-- <div class="add_address_public"><p><font style="height:34px; line-height:34px">省份</font><span class="select"><select><option>--选择省份--</option></select></span></p></div>
	<div class="add_address_public"><p><font style="height:34px; line-height:34px">市</font><span class="select"><select><option></option></select></span></p></div> -->
	<div class="add_address_public"><p><font>详细地址</font><span><input type="text" placeholder="详细地址" id="address" value="${address.address}"/></span></p></div>
</div>

<div class="list"><div class="pay"><a href="javascript:void(0)" class="wx">确认</a><a href="javascript:void(0)" class="delivery">历史地址</a></div></div>

<jsp:include page="/foot.jsp" />
</body>
</html>