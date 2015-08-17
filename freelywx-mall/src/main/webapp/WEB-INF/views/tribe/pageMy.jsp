<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<c:if test="${empty list}"></c:if>
<c:if test="${not empty list}">
	<c:forEach items="${list}" var="topic" varStatus="vs">
			<div class="talk_content">
				<div class="list listMy">
					<input type="hidden" value="${topic.topic_id}">
					<div class="toux_left fl">
						<c:if test="${empty topic.member.member_img}"><img src="${img}/grzx2.png" width="80" height="80" /></c:if>
	            		<c:if test="${not empty topic.member.member_img}"><img src="${topic.member.member_img}" width="80" height="80" /></c:if>
						${topic.member.member_name}
					</div>
					<div class="toux_right fr">
					
						<c:if test="${topic.topic_type == 1}">
							<div class="have have_bj">管理员</div>
						</c:if>
						<c:if test="${topic.topic_type == 2}">
							<c:if test="${topic.is_band == 1}">
								<c:if test="${topic.sNum != 0}"><div class="have have_bj">已购</div></c:if>
								<c:if test="${topic.sNum == 0}"><div class="have have_bj_yk">游客</div></c:if>
							</c:if>
						</c:if>
						
						<p>
							<span class="time" type="true">${topic.create_time}</span>
						</p>
						<p>
							<span>
								<c:if test="${topic.is_show == 1}">
									<c:if test="${empty topic.address}">未知地理位置</c:if>
									<c:if test="${not empty topic.address}">${topic.address}</c:if>
								</c:if>
								<c:if test="${topic.is_show == 2}">未知地理位置</c:if>
							</span>
						</p>
					</div>
					<div class="clear"></div>

					<c:if test="${topic.is_band == 1 && not empty topic.product}">
					<div class="buy_number">
						<div class="list">
							<div class="shoop_xq clearfix">
								<img src="${topic.prod_img_url}" width="85" height="85" class="fl" />
								<div class="shoop_model">
									<p class="title_number" style="margin-top: 0px;">${topic.product.prod_name}</p>
                					<p>原价：<fmt:formatNumber value="${topic.product.retail_price/100}" type="currency" pattern="￥ 0.00"/></p>
									<p>酷魔方价：<span class="color"><fmt:formatNumber value="${topic.product.sale_price/100}" type="currency" pattern="￥ 0.00"/></span></p>
                					<p>颜色：<c:if test="${empty topic.colorArray}">无</c:if><c:if test="${not empty topic.colorArray}"><c:forEach items="${topic.colorArray}" var="color">${color}&nbsp;&nbsp;</c:forEach></c:if></p>
									<p>月销量：${topic.sCount}</p>
									<p>评论：${topic.tCount}</p>
								</div>
							</div>
						</div>
					</div>
					</c:if>
					
					<p class="product">${topic.topic_cont}</p>
					
					<c:if test="${not empty topic.topicImgList}">
					<div class="product_img">
						<c:forEach items="${topic.topicImgList}" var="tImg">
							<img src="${tImg.img_url}" />
						</c:forEach>
		            </div>
		            </c:if>
		            
					<div class="shoop_zan">
						<span><img src="${img}/zan.jpg" class="zan" />(<span class="zanT"><c:if test="${empty topic.praiseList}">0</c:if><c:forEach items="${topic.praiseList}" var="report" varStatus="vs"><c:if test="${vs.last}">${vs.index+1}</c:if></c:forEach></span>)</span>
						<img src="${img}/liuyan.jpg" class="liuyan" />(<span class="liuyanT"><c:if test="${empty topic.replyList}">0</c:if><c:forEach items="${topic.replyList}" var="report" varStatus="vs"><c:if test="${vs.last}">${vs.index+1}</c:if></c:forEach></span>)
					</div>

		            <div id="content"></div>
		            
				</div>
			</div>
		</c:forEach>
</c:if>

<script type="text/javascript">
	$('#pageIndex').val("${pageIndex}");
	$('#pageTotal').val("${pageTotal}");
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
		$('.listMy').click(function() {
			var id = $(this).children("input").val();
			location.href = "${ctx}/tribe/get?id=" + id;
		});
	})
</script>