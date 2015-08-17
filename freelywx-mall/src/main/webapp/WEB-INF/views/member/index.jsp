<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport">
<meta content="telephone=no" name="format-detection">
<title>个人中心</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css">
<script type="text/javascript">
$(function() {
	
	$('.sign').click(function() {
		$.post("${ctx}/member/sign", {}, function(text) {
			if (text == 1) {
				alert("签到成功");
				location.href = "${ctx}/member"
			} else if (text == 2) {
				alert("已经签到");
			} else {
				alert("签到失败");
			}
		})
	})
	
})
</script>
<script type="text/javascript">
	function onBridgeReady() {
		WeixinJSBridge.call('hideOptionMenu');
		WeixinJSBridge.call('hideToolbar');
	}

	if (typeof WeixinJSBridge == "undefined") {
		if (document.addEventListener) {
			document.addEventListener('WeixinJSBridgeReady', onBridgeReady,
					false);
		} else if (document.attachEvent) {
			document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
			document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
		}
	} else {
		onBridgeReady();
	}
</script>
</head>

<body class="body_bj">
	<%-- <div class="classify_top">个人中心 
		<a href="${ctx}/" class="clasify_img"><img src="${img}/classify_img.png" width="30" height="30" /></a>
	</div> --%>

	<div class="new">
		<div class="new_bj">
			<a href="javascript:void(0)" class="indiv_a">
				<c:if test="${empty member.member_img}"><img src="${img}/grzx2.png"/></c:if>
				<c:if test="${not empty member.member_img}"><img src="${member.member_img}"/></c:if>
			</a>
			
			<div class="new_img">
				<div class="new_info">
					<span class="new_txt">
					
						<span class="ds" style="margin-top: 5px;">
							<font style="color: #000;">等级：</font>
							<span class="cw"><c:forEach items="${level}"><img src="${img}/xing.png" width="20" height="20"/></c:forEach></span>
						</span>
						
						<span class="ds" style="margin-top: 8px;">
							<font style="color: #000;">积分：</font> 
							<span class="cw" style="color: #ffff00"><font class="number_family">${interal}</font>分</span>
							<a href="${ctx}/member/convert">兑换</a>
						</span>
						
						<span class="admin">
							<c:if test="${not empty fn:trim(member.member_name)}">${member.member_name}</c:if>
							<c:if test="${empty fn:trim(member.member_name)}">匿名</c:if>
							, 您已连续签到<font class="number_family"><c:if test="${empty sign}">0</c:if><c:if test="${not empty sign}">${sign.sign_in_num}</c:if></font>天
						</span>
						
						<span class="qdjf">签到赢积分，免费换商品！
							<c:if test="${status == 0}"><a href="javascript:void(0)" class="sign">每日签到</a></c:if>
							<c:if test="${status == 1}"><a href="javascript:void(0)">已签到</a></c:if>
			          	</span>
			          	
					</span> 
				</div>
			</div>
			
		</div>
	</div>
	
	<div class="home_list list">
		<ul class="list_ul">
	    	<li><a href="${ctx}/order/list"><span class="title_number_a"></span><span class="left_title dd_ico">我的订单</span></a></li>
	    	<li><a href="${ctx}/member/favor"><span class="title_number_a"></span><span class="left_title sc_ico">我的收藏</span></a></li>
	    	<li><a href="${ctx}/member/coupon?type=2"><span class="title_number_a"></span><span class="left_title yh_ico">我的优惠券</span></a></li>
	    	<li style="border: none;"><a href="${ctx}/member/coupon?type=1"><span class="title_number_a"></span><span class="left_title xj_ico">我的现金券</span></a></li>
	    </ul>
	</div>
	
	<div class="home_list list">
		<ul class="list_ul">
	    	<li><a href="${ctx}/tribe/list?type=fb"><span class="title_number_a">${list1}</span><span class="left_title talk_ico">发表的话题</span></a></li>
	    	<li><a href="${ctx}/tribe/list?type=hf"><span class="title_number_a">${list2}</span><span class="left_title assist_ico">回复的话题</span></a></li>
	    	<li style="border: none;"><a href="${ctx}/tribe/list?type=zg"><span class="title_number_a">${list3}</span><span class="left_title reply_ico">赞过的话题</span></a></li>
	    </ul>
	</div>

<jsp:include page="/foot.jsp" />
</body>
</html>