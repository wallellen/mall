<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;"
	name="viewport" />
<meta content="telephone=no" name="format-detection" />
<title>微商加盟</title>
<link type="text/css" rel="stylesheet" href="${css}/zc2.css" />
<script type="text/javascript">
	$(function() {
		$("#wx1").click(
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
	<div class="my_wechat_shoop"></div>
	<div class="edit">
		<a href="#">简单的几步就可以拥有自己的商城！</a>

	</div>

	<div class="user">
		<p class="user-name">
			<input type="text" value="姓名" />
		</p>

		<p class="user-phone">
			<input type="text" value="电话" />
		</p>

		<p class="user-mail">
			<input type="text" value="邮箱" />
		</p>
	</div>

	<div class="submit-applications">
		<input type="submit" value="提交申请" id="wx1" />
	</div>


	<jsp:include page="/foot.jsp" />
</body>
</html>