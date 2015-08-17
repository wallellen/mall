<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<c:if test="${empty list}"></c:if>
<c:if test="${not empty list}">
	<c:forEach items="${list}" var="prod">
	
		<div class="shoop clearfix">
			<a href="${ctx}/getProd?prod_id=${prod.prod_id}"><img src="${prod.picList[0].pic_url}" width="98" height="110" class="fl" /></a>
			<div class="shoop_abstract">
				<div class="shoop_title"><a href="${ctx}/getProd?prod_id=${prod.prod_id}">${prod.prod_name}</a></div>
				<p class="shoop_nn"><a href="${ctx}/getProd?prod_id=${prod.prod_id}">${prod.description}</a></p>
				<p>
					酷魔方价：<span class="price"><fmt:formatNumber value="${prod.sale_price/100}" type="currency" pattern="￥ 0.00"/></span>
				</p>
				<p class="love">
					<span class="isLove <c:if test="${prod.love == 0}">love_span</c:if>" is="${prod.love}"></span>
					<font class="<c:if test="${prod.love == 0}">love_number</c:if>">${prod.loveCount}人喜欢</font>
				</p>
			</div>
			<input type="hidden" value="${prod.prod_id}" />
		</div>
		
	</c:forEach>
</c:if>

<script type="text/javascript">
	$('#pageIndex').val("${pageIndex}");
	$('#pageTotal').val("${pageTotal}");

	$('.isLove').click(function() {
		var obj = $(this);
		var id = obj.parent().parent().next().val();
		var objN = obj.next();
		var count = objN.text().substring(0, objN.text().length - 3) * 1;
		if (obj.attr("is") == 1) {
			$.post("${ctx}/setLove", {
				"id" : id
			}, function(result) {
				if (result == 1) {
					obj.addClass("love_span");
					obj.next().addClass("love_number");
					obj.attr("is", "0");
					objN.text((count + 1) + "人喜欢");
				} else {
					alert("设置失败");
				}
			});
		} else {
			$.post("${ctx}/delLove", {
				"id" : id
			}, function(result) {
				if (result == 1) {
					obj.removeClass("love_span");
					obj.next().removeClass("love_number");
					obj.attr("is", "1");
					objN.text((count - 1) + "人喜欢");
				} else {
					alert("设置失败");
				}
			});
		}
	});
</script>