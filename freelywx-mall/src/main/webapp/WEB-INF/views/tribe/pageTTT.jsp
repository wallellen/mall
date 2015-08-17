<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<c:if test="${empty topicList}"></c:if>
<c:if test="${not empty topicList}">
	<c:forEach items="${topicList}" var="topic">

		<div class="s_content clearfix">
		
			<div class="s_left">
				<c:if test="${empty topic.member.member_img}">
					<img src="${img}/grzx2.png" width="47" height="47" />
				</c:if>
				<c:if test="${not empty topic.member.member_img}">
					<img src="${topic.member.member_img}" width="47" height="47" />
				</c:if>
			</div>
			
			<div class="border">
				<div class="s_introduce">
					<input type="hidden" value="${topic.topic_id}">
					<p class="line_height">${topic.topic_cont}</p>
					<p>
						<c:if test="${topic.is_band==1 && not empty topic.prod_img_url}"><img src="${topic.prod_img_url}" width="100%" /></c:if>
						<c:if test="${not empty topic.topicImgList}"><img src="${topic.topicImgList[0].img_url}" alt="" width="100%" /></c:if>
					</p>
					<p class="name_c">
						<span class="fr"><c:forEach items="${dateMap}" var="date"><c:if test="${date.key == topic.topic_id}">${date.value}</c:if></c:forEach></span>
						<c:if test="${not empty fn:trim(topic.member.member_name)}">${topic.member.member_name}</c:if>
						<c:if test="${empty fn:trim(topic.member.member_name)}">匿名</c:if>
					</p>
					<div class="shoop_zan">
						<span><img src="${img}/zan.jpg" class="zan" />(<span class="zanT"><c:if test="${empty topic.praiseList}">0</c:if><c:forEach items="${topic.praiseList}" var="report" varStatus="vs"><c:if test="${vs.last}">${vs.index+1}</c:if></c:forEach></span>)</span>
						<img src="${img}/liuyan.jpg" class="liuyan" />(<span class="liuyanT"><c:if test="${empty topic.replyList}">0</c:if><c:forEach items="${topic.replyList}" var="report" varStatus="vs"><c:if test="${vs.last}">${vs.index+1}</c:if></c:forEach></span>)
					</div>
					<img class="s_sign" src="${img}/sign.jpg" width="12" height="7" />
				</div>
				<img src="${img}/blank.jpg" width="12" height="12" class="radius" />
			</div>
			
		</div>

	</c:forEach>
</c:if>

<script type="text/javascript">
	$('#pageIndex').val("${pageIndex}");
	$('#pageTotal').val("${pageTotal}");
	
	$('.s_introduce').click(function() {
		var id = $(this).children("input").val();
		location.href = "${ctx}/tribe/get?id=" + id;
	});
</script>