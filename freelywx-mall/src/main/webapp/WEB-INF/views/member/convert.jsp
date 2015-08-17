<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport">
<meta content="telephone=no" name="format-detection">
<title>兑换</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css">
<script type="text/javascript">
	$(function() {
		$('.confirm').click(function() {
			var num = $('.xd_aft').val().trim();
			var jf = "${interal}";
			var sl = "${ie.interal_rule_value}";
			var zz = /^[1-9]*$/;
			
			if(num==""){
				alert("兑换数量不能为空");
			}else if (zz.test(num)) {
				var jgs = "" + jf / sl;
				var jgi = jgs * 1;

				if (jgs.indexOf('.') != -1)
					jgi = (jgs.substring(0, jgs.indexOf('.'))) * 1;

				if (num > jgi) {
					alert("积分不足")
				} else {
					$.post("${ctx}/member/addCoupon", {
						"num" : num
					}, function(text) {
						if (text > 0) {
							alert("兑换成功");
							$('.jf').text(($('.jf').text() * 1) - (num * sl));
							var inp = "" + ($('.jf').text() / sl);
							if (inp.indexOf('.') != -1)
								inp = (inp.substring(0, inp.indexOf('.'))) * 1;
							$('.xd_aft').val(inp);
						} else if (text == 0) {
							alert("积分不足")
						} else {
							alert("兑换失败")
						}
					})
				}
			} else {
				alert("兑换数量为正整数");
			}
		})
	})
</script>
</head>

<body>
	<div class="tab_ul ds_list">兑换
		<a href="${ctx}/member" class="back_page"><img src="${img}/back.png" width="16" height="25" /></a>
	</div>

	<div class="main">
		<div class="textct xd_font">
			<p class="kd_jf">当前积分：<span class="jf number_family">${interal}</span>分</p>
			<p class="kd_dh">即将兑换：<input type="text" class="xd_aft" value="${fn:substringBefore(interal/ie.interal_rule_value, '.')}"/>个${ie.interal_exchange_value}元现金券</p>
			<p class="xd_sub"><a href="javascript:void(0)" class="confirm">确认兑换</a></p>
			<p class="xd_xh">*<span> ${ie.interal_rule_value}</span>个积分可兑换<span>${ie.interal_exchange_value}</span>元现金券。</p>
		</div>
	</div>
	
<jsp:include page="/foot.jsp" />
</body>
</html>