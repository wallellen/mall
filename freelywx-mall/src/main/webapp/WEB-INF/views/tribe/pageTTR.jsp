<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<c:if test="${empty replyList}"></c:if>
<c:if test="${not empty replyList}">
	<c:forEach items="${replyList}" var="reply" varStatus="vs">

		<div class="talk_content <c:if test="${topic.create_user == reply.member.member_id}">new_bj_color</c:if>">
			<div class="list">
				<div class="toux_left fl">
					<c:if test="${empty reply.member.member_img}"><img src="${img}/grzx2.png" width="80" height="80" /></c:if>
           			<c:if test="${not empty reply.member.member_img}"><img src="${reply.member.member_img}" width="80" height="80" /></c:if>
					${reply.member.member_name}
				</div>
				<div class="toux_right  fr">
					<c:if test="${not empty reply.reply_user_type}">
						<c:if test="${reply.reply_user_type == 1}"><div class="have have_bj">管理员</div></c:if>
						<c:if test="${reply.reply_user_type == 2}"><div class="have have_bj">已购</div></c:if>
						<c:if test="${reply.reply_user_type == 3}"><div class="have have_bj_yk">游客</div></c:if>
					</c:if>
					<p>
						<span class="time" type="true">${reply.reply_time}</span>
					</p>
					<p>
						<span><c:if test="${empty reply.address}">未知地理位置</c:if><c:if test="${not empty reply.address}">${reply.address}</c:if></span>
					</p>
				</div>
				<div class="clear"></div>
				<p class="product" style="word-break:break-all; overflow:auto;">${reply.reply_cont}</p>
			</div>
		</div>
		
	</c:forEach>
</c:if>

<script type="text/javascript">
	$('#pageIndex').val("${pageIndex}");
	$('#pageTotal').val("${pageTotal}");
	$('#pageIndex1').val("${pageIndex1}");
	$('#pageTotal1').val("${pageTotal1}");
	$(function(){
		$(".time").each(function(){
			if($(this).attr("type")=="true"){
				$(this).text(getTime($(this).text()));
				$(this).attr("type","false")
			}
		});
		
		/* $(".addr").each(function(){
			var xx = $(this).attr("xx");
			var yy = $(this).attr("yy");
			var id = $(this).attr("id");
			var addr = "";
			$.post("${ctx}/tribe/geolocation", {
				"lng" : xx,
				"lat" : yy
			}, function(text) {
				var obj = JSON.parse(text);
				addr = obj.address;
				if(addr == "")
					addr = "未知地理位置";
				$("#"+id).text(addr);
			});
		}); */
	})
</script>