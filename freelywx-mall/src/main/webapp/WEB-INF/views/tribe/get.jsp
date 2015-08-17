<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport">
<meta content="telephone=no" name="format-detection">
<title>${topic.topic_title}</title>
<link type="text/css" href="${css}/public.css" rel="stylesheet">
<link type="text/css" href="${css}/layout.css" rel="stylesheet">
<script type="text/javascript" src="${js}/ender.js"></script>
<script type="text/javascript" src="${js}/zepto.js"></script>
<script type="text/javascript">
	if (navigator.geolocation) {
		navigator.geolocation.watchPosition(success, error);
	}

	function success(position) {
		var latitude = position.coords.latitude;//纬度
		var longitude = position.coords.longitude;//经度
		
		$("#xx").val(longitude);
		$("#yy").val(latitude);
	}

	function error(error) {
		switch (error.code) {
		case 0:
			break;
		case 1:
			break;
		case 2:
			break;
		case 3:
			break;
		}
	}
</script>
<script type="text/javascript">
	$(function() {

		var lock = false;
		window.scrollTo(0, 0);
		pageTTT();
		function pageTTT() {
			$.post("${ctx}/tribe/pageTTR", {
				"pageIndex" : $('#pageIndex').val() * 1 + 1,
				"topic_id" : $('#tid').val(),
				"type" : "pt"
			}, function(text) {
				$('#content').append(text);
				lock = true;
			});
		}

		new NeuF.ScrollPage(window, function(offset) {
			if (offset > 0) {
				if(lock){
					lock = false;
					setTimeout(function() {
						var pageIndex = $('#pageIndex').val() * 1 + 1;
						var pageTotal = $('#pageTotal').val() * 1 + 1;
						if (pageIndex < pageTotal) {
							pageTTT();
						}
					}, 1000);
				}
			}
		});
		
		$(".times").each(function(){
			$(this).text(getTime($(this).text()));
		});
		
		var tid = $("#tid").val();
		var xx = $("#xx").val();
		var yy = $("#yy").val();
		$("#comment").click(function(){
			var reply_cont = $('#reply_cont').text().trim();
			if (reply_cont == ""){
				alert("内容不可为空");
				return;
			}
			
			$.post("${ctx}/tribe/reply", {
				"topic_id" : tid,
				"reply_cont" : reply_cont,
				"xx" : xx,
				"yy" : yy
			}, function(text) {
				if(text ==1 ){
					//alert("评论成功");
					$('#reply_cont').text("");
					
					$('#content').text("");
					$('#pageIndex').val("-1");
					pageTTT();
					$(".liuyanT").text($(".liuyanT").text()*1+1);
				}else if(text == -1){
					alert("请先关注");
				}else{
					alert("评论失败");
				}
			});
			
		});

		$(".zan").click(function(){
			$.post("${ctx}/tribe/praise", {
				"topic_id" : tid,
				"xx" : xx,
				"yy" : yy
			}, function(text) {
				if(text == 0){
					alert("已点过赞");
				}else if(text == 1){
					$(".zanT").text($(".zanT").text()*1+1);
				}else if(text == -1){
					alert("请先关注");
				}else{
					alert("点赞失败");
				}
			});
		});
		
		$('.emoji').hide();
		$(".biaoqing").click(function(){
			if($('.emoji').attr("on-off")=="off"){
				$('.emoji').show();
				$('.emoji').attr("on-off","on")
				checkscope();
			}else if($('.emoji').attr("on-off")=="on"){
				$('.emoji').hide();
				$('.emoji').attr("on-off","off")
			}
		});
		
		$(".emoji img").click(function(){
			var cont = $('#reply_cont').text();
			$('#reply_cont').text(cont + $(this).attr("title"));
		});
		
		$(".buy_number").click(function(){
			var id = $(this).children("input").val();
			location.href = "${ctx}/getProd?prod_id="+id;
		});
		
		$(".product_img img").click(function(){
			var imgArr = new Array();
			var i = 0;
			$(".product_img img").each(function(){
				imgArr[i] = $(this).attr("src");
				i++;
			})
			WeixinJSBridge.invoke("imagePreview",{
				"urls":imgArr,
				"current":$(this).attr("src")
			})
		});
	});
</script>
<script type="text/javascript">
	function checkscope() {
		var slider = Swipe(document.getElementById('scroll_img'), {});
	}
	$(function() {
		$('.testarea').one('tap', function() {
			inputTouch()
		}).blur(function() {
			$(document.body).scrollTop(oldScroll);
			$(this).one('tap', function() {
				inputTouch();
			});
		});
	})
	var oldScroll = 0;
	function inputTouch() {
		oldScroll = $(document.body).scrollTop();
		$(document.body).scrollTop(10000000);
	}
</script>
</head>

<body class="body_bj">
	<input type="hidden" value="-1" id="pageIndex" />
	<input type="hidden" value="0" id="pageTotal" />
	
	<input type="hidden" id="xx" value="0">
	<input type="hidden" id="yy" value="0">
	<input type="hidden" id="tid" value="${topic.topic_id}">

	<div class="talk_padding">
		<div class="talk_bj">
		
			<div class="talk_content">
				<div class="list">
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
							<span class="times">${topic.create_time}</span>
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
						<input type="hidden" value="${topic.product.prod_id}">
						<div class="list">
							<div class="shoop_xq clearfix">
								<img src="${topic.prod_img_url}" width="85" height="85" class="fl" />
								<div class="shoop_model">
									<p class="title_number" style="margin-top: 0px;">${topic.product.prod_name}</p>
                					<p>原价：￥${topic.product.retail_price/100}</p>
									<p>酷魔方价：<span class="color">￥${topic.product.sale_price/100}</span></p>
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
							<img src="${tImg.img_url}" alt="" />
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
			
		</div>
	</div>
	
	<div class="discuss">
	
		<div class="list">
			<table width="100%" cellpadding="0" cellspacing="0" style="padding: 5px 0px;">
				<tr>
					<td width="50"><a href="javascript:void(0)" class="biaoqing" style="padding-top:0px;"><img src="${img}/biaoqing.jpg" width="28" height="28" /></a></td>
					<td>
						<div id="reply_cont" class="testarea" contenteditable="true" style="border: 1px solid #ccc; width: 100%; min-height: 33px; max-height: 57px; border-radius: 5px; padding: 5px; box-sizing: border-box; font-size: 14px; overflow: auto;"></div>
					</td>
					<td width="43" style="padding-left: 7px;">
						<p class="discuss_submit" style="position: static">
							<input type="submit" value="评论" id="comment" />
						</p>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="none emoji" on-off="off">
			<div class="scroll relative">
			
				<div class="scroll_box" id="scroll_img">
					<ul class="scroll_wrap">
					
						<li class="a1">
							<ul class="bq_ul">
								<c:forEach items="${emoji}" var="emoji" begin="0" end="6">
									<li><img title="[${emoji.text}]" alt="[${emoji.text}]" src="${emoji.link}"></li>
								</c:forEach>
							</ul>
							
							<ul class="bq_ul">
								<c:forEach items="${emoji}" var="emoji" begin="7" end="13">
									<li><img title="[${emoji.text}]" alt="[${emoji.text}]" src="${emoji.link}"></li>
								</c:forEach>
							</ul>
							
							<ul class="bq_ul">
								<c:forEach items="${emoji}" var="emoji" begin="14" end="20">
									<li><img title="[${emoji.text}]" alt="[${emoji.text}]" src="${emoji.link}"></li>
								</c:forEach>
							</ul>
						</li>
						
						<li class="a1">
							<ul class="bq_ul">
								<c:forEach items="${emoji}" var="emoji" begin="21" end="24">
									<li><img title="[${emoji.text}]" alt="[${emoji.text}]" src="${emoji.link}"></li>
								</c:forEach>
								<li></li>
								<li></li>
								<li></li>
								<li></li>
								<li></li>
								<li></li>
								<li></li>
								<li></li>
							</ul>
						</li>
						
					</ul>
				</div>
				
				<ul class="scroll_position" id='scroll_position'>
					<li class="onn"></li>
					<li></li>
					<li></li>
				</ul>
				
			</div>
		</div>

	</div>

<jsp:include page="/foot.jsp" />
</body>
</html>