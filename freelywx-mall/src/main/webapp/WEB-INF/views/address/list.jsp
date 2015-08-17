<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport"/>
<meta content="telephone=no" name="format-detection"/>
<title>收货地址</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript">
$(function(){
	var prod_id = $('#prod_id').val();
	var count = $('#count').val();
	var color = $('#color').val();
	var coupon = $('#coupon').val();
	
	//后退到订单确认页
	$('.back_page').click(function(){
		location.href="${ctx}/order/confirm?prod_id="+prod_id+"&count="+count+"&color="+color+"&coupon="+coupon;
	})
	
	//选择
	$('.a_l').click(function(){
		var address_id = $(this).parent().parent().parent().parent().parent().next().children("input").val();
		location.href="${ctx}/order/confirm?prod_id="+prod_id+"&count="+count+"&color="+color+"&coupon="+coupon+"&address_id="+address_id;
	})
	
	//新增
	$('.add_address').click(function(){
		location.href="${ctx}/addr/getAddress?prod_id="+prod_id+"&count="+count+"&color="+color+"&coupon="+coupon;
	})
	
	//修改
	$('.a_r').click(function(){
		var id = $(this).next().val();
		location.href="${ctx}/addr/getAddress?prod_id="+prod_id+"&count="+count+"&color="+color+"&coupon="+coupon+"&id="+id;
	})
	
	//删除
	$('.del').click(function(){
		var id = $(this).prev().val();
		$.post("${ctx}/addr/delAddress", {
			"id" : id
		}, function(result) {
			if (result == 1) {
				alert("删除成功");
				location.href="${ctx}/addr/address?prod_id="+prod_id+"&count="+count+"&color="+color+"&coupon="+coupon;
			} else {
				alert("删除失败");
			}
		});
	})
})
</script>
</head>

<body>
<input type="hidden" id="prod_id" value="${prod_id}" />
<input type="hidden" id="count" value="${count}" />
<input type="hidden" id="color" value="${color}" />
<input type="hidden" id="coupon" value="${coupon}" />

<div class="tab_ul ds_list">收货地址
  <a href="javascript:void(0)" class="back_page"><img src="${img}/back.png" width="16" height="25"/></a>
  <a href="javascript:void(0)" class="add_address"><img src="${img}/add_address.png" width="30" height="30" /></a> 
</div>

<c:forEach items="${addressList}" var="addressList">
<div class="address_list">
	<table cellpadding="0" cellspacing="0" border="0" class="address_table" width="100%">
    	<tr>
	        <td  class="checked_img">
	        	<table cellpadding="0" cellspacing="0" border="0" width="100%">
	            	<tr>
	                	<td width="25%" align="center"><a href="javascript:void(0)" class="a_l"></a></td>
	        			<td><p class="pag_address">${addressList.address}</p><p class="touch">${addressList.consignee_name}<span>${addressList.phone}</span></p></td>
	                </tr>
	            </table>
	        </td>
	        <td width="17%" align="center">
	        	<a href="javascript:void(0)" class="a_r"></a>
				<input type="hidden" value="${addressList.address_id}" />
				<input type="hidden" value="删除" class="del" />
	        </td>
        </tr>
    </table>
</div>
</c:forEach>

<jsp:include page="/foot.jsp" />
</body>
</html>