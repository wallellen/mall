<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
<meta content="telephone=no" name="format-detection" />
<title>微商加盟</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript">
	$(function() {
		$(".wx").click(
				function() {
					var name = $("#name").val().trim();
					var phone = $("#phone").val().trim();
					var email = $("#email").val().trim();
					if (null != name && "" != name && null != phone
							&& "" != phone && null != email && "" != email) {
						$.post('${ctx}/raise/addMerchant', {
							"name" : name,
							"phone" : phone,
							"email" : email
						}, function(result) {
							if (result.result == 0) {
								alert("申请成功");
								setTimeout("window.history.go(-2)", 1000)
								$("#name").val("");
								$("#phone").val("");
								$("#email").val("");
							} else {
								alert("申请失败");
							}
						});
					} else {
						alert("姓名、电话、邮箱不能为空！");
					}
				});
	});
</script>
</head>

<body>
	<div class="my_wechat_shoop">简单的几步就可以拥有自己的商城！</div>

	<div class="list">
		<div class="touch_we">
			<div class="touch_name">姓名</div>
			<div class="touch_input">
				<input type="text" id="name" name="name" />
			</div>
		</div>

		<div class="touch_we">
			<div class="touch_name">电话</div>
			<div class="touch_input">
				<input type="text" id="phone" name="phone" />
			</div>
		</div>


		<div class="touch_we">
			<div class="touch_name">邮箱</div>
			<div class="touch_input">
				<input type="text" id="email" name="email" />
			</div>
		</div>


		<div class="pay new_pay">
			<a href="javascript:void(0)" class="wx">提交申请</a>
		</div>

	</div>


	<jsp:include page="/foot.jsp" />
</body>
</html>