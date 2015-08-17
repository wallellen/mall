<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
<meta content="telephone=no" name="format-detection"/>
<title>我的收藏</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
</head>

<body>
	<div class="tab_ul ds_list">我的收藏
		<a href="${ctx}/member" class="back_page"><img src="${img}/back.png" width="16" height="25"/></a> 
	</div>
	
	<div class="total_order">
		<div class="list" style="padding-top:5px;">
			<c:if test="${empty favor}">
				<div class="dl_center">
					<img src="${img}/gt.png" width="38" height="38" />暂无收藏
				</div>
			</c:if>
		
			<c:if test="${not empty favor}">
			<c:forEach items="${favor}" var="favor">
		        <div class="order_list" style="padding-top: 5px">
					<div class="buy_number">
						<div class="list">
							<div class="shoop_xq clearfix">
								<a href="${ctx}/getProd?prod_id=${favor.product.prod_id}"><img src="${favor.product.pic_url}" width="100" height="100" class="fl" /></a>
								<a href="${ctx}/member/delFavor?id=${favor.product.prod_id}" style="float: right;"><img src="${img}/del.png" width="20" height="20" /></a>
								<div class="shoop_model">
									<p class="shoop_title">${favor.product.prod_name}</p>
									<p class="shoop_nn">${favor.product.description}</p>
									<p>酷魔方价：<span class="price">￥${favor.product.sale_price/100}</span></p>
								</div>
							</div>
						</div>
					</div>
		        </div>
			</c:forEach>
			</c:if>
			
	    </div>
	</div>
	
<jsp:include page="/foot.jsp" />
</body>
</html>