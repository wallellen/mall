<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport">
<meta content="telephone=no" name="format-detection">
<title><c:if test="${type == 1}">现金券</c:if><c:if test="${type == 2}">优惠券</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/public.css">
</head>

<body>
	<div class="tab_ul ds_list"><c:if test="${type == 1}">现金券</c:if><c:if test="${type == 2}">优惠券</c:if>
		<a href="${ctx}/member" class="back_page"><img src="${img}/back.png" width="16" height="25"/></a> 
	</div>

	<div class="main">
		<c:if test="${empty coupon}">
			<div class="dl_center">
				<img src="${img}/gt.png" width="38" height="38" />暂无<c:if test="${type == 1}">现金券</c:if><c:if test="${type == 2}">优惠券</c:if>
			</div>
		</c:if>

		<c:if test="${not empty coupon}">
		<c:forEach items="${coupon}" var="coupon">
			<div class="dl_cneter">
				<div class="dl_now">
					<div class="pref_left left">
						<span><fmt:formatNumber value="${coupon.value/100}" type="currency" pattern="￥0.00" /></span>
						<c:if test="${type == 1}">现金券</c:if>
						<c:if test="${type == 2}">优惠券</c:if>
					</div>
					<div class="pref_right left">
						<p>使用说明</p>
						<p>1.仅限个人使用</p>
						<p>2.该券为一次性</p>
						<p>3.限时过期作废</p>
					</div>
				</div>
			</div>
		</c:forEach>
		</c:if>
		
	</div>

<jsp:include page="/foot.jsp" />
</body>
</html>