<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="telephone=no" name="format-detection">
<title>商品介绍 - ${prod.prod_name}</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<link type="text/css" rel="stylesheet" href="${css}/idangerous.swiper.css" />
<script type="text/javascript" src="${js}/idangerous.swiper-2.1.min.js"></script>
<script type="text/javascript" src="${js}/visit.js"></script>
<script type="text/javascript">
	$(function() {
		dataForWeixin.TLImg = "${prod.picList[0].pic_url}";
		dataForWeixin.MsgImg = "${prod.picList[0].pic_url}";
		dataForWeixin.title = "锋付智能-${prod.prod_name}   ";
		dataForWeixin.desc = "${prod.prod_name}";
		$(".color a").click(function() {
			var length = $(".color a").length;
			for (var i = 0; i < length; i++) {
				$(".color a").removeClass("check");
			}
			$(this).addClass("check");
		});
		
		$(".ul_tab li").click(function(){
			if($(this).attr("class")!="tab_on"){
				$('#pageIndex').val("-1");
				$('#pageTotal').val("0");
				$('#pageIndex1').val("-1");
				$('#pageTotal1').val("0");
				$('#div2').text("");
				$('#div3').text("");
			}
			$(".ul_tab li").removeClass("tab_on");
			$(this).addClass("tab_on");
		});
		
		$('#div2').hide();
		$('#div3').hide();
		$("#li1").click(function(){
			$('#div1').show();
			$('#div2').hide();
			$('#div3').hide();
		})
		
		var lock = false;
		var lock1 = false;
		
		$("#li2").click(function(){
			$('#div1').hide();
			$('#div2').show();
			$('#div3').hide();

			lock =  true;
			if(lock){
				lock = false;
				var pageIndex = $('#pageIndex').val() * 1 + 1;
				var pageTotal = $('#pageTotal').val() * 1 + 1;
				if (pageIndex < pageTotal) {
					pageTTT();
				}
			}
		})
		
		$("#li3").click(function(){
			$('#div1').hide();
			$('#div2').hide();
			$('#div3').show();
			
			lock1 = true;
			if(lock1){
				lock1 = false;
				var pageIndex1 = $('#pageIndex1').val() * 1 + 1;
				var pageTotal1 = $('#pageTotal1').val() * 1 + 1;
				if (pageIndex1 < pageTotal1) {
					pageTTT1();
				}
			}
		})
		
		function pageTTT() {
			$.post("${ctx}/tribe/pageMy", {
				"pageIndex" : $('#pageIndex').val() * 1 + 1,
				"prod_id" : ${prod.prod_id},
				"type" : "tz"
			}, function(text) {
				$('#div2').append(text);
				lock = true;
				if($('#pageTotal').val() == 0)
					$('#div2').html('<p class="zwgd">暂无更多</p>');
			});
		}

		function pageTTT1() {
			$.post("${ctx}/tribe/pageTTR", {
				"pageIndex" : $('#pageIndex1').val() * 1 + 1,
				"prod_id" : ${prod.prod_id},
				"type" : "pj"
			}, function(text) {
				$('#div3').append(text);
				lock1 = true;
				if($('#pageIndex1').val() == -1)
					$('#div3').html('<p class="zwgd">暂无更多</p>');
			});
		}
		
		window.scrollTo(0, 0);
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
				if(lock1){
					lock1 = false;
					setTimeout(function() {
						var pageIndex1 = $('#pageIndex1').val() * 1 + 1;
						var pageTotal1 = $('#pageTotal1').val() * 1 + 1;
						if (pageIndex1 < pageTotal1) {
							pageTTT1();
						}
					}, 1000);
				}
			}
		});
		
		//数字减
		$('.number_min').click(function(){
			var num = $('.shuzi').text()*1-1;
			if(num==0){ num=1; }
			$('.shuzi').text(num)
		})
		//数字加
		$('.number_add').click(function(){
			var num = $('.shuzi').text()*1+1;
			$('.shuzi').text(num)
		})
		//收藏
		$('.favorImg').click(function(){
			var text = $('.favorP').text();
			var id = "${prod.prod_id}";
			if(text=='未收藏'){
				$.post("${ctx}/setFavor",{
					"prod_id":id
				},function(result){
					if(result==1){
						$('.favorP').text('已收藏');
						$('.favorImg').attr("src","${img}/star.jpg")
					}else{
						alert("收藏失败");
					}
				});
			}else{
				$.post("${ctx}/delFavor",{
					"prod_id":id
				},function(result){
					if(result==1){
						$('.favorP').text('未收藏');
						$('.favorImg').attr("src","${img}/star2.jpg")
					}else{
						alert("取消收藏失败");
					}
				});
			}
		})
		
		if($(".color a").length > 0){
			$(".color a:first").addClass("check");
		}
		
		function booColor(){
			var len1 = $(".color a").length;
			var len2 = $(".check").length;
			var boo = false;
			if(len1>0){	//判断有无颜色属性
				if(len2>0){	//判断有无选择颜色
					boo = true;
				}
			}else{
				boo = true;
			}
			return boo;
		}
		
		//var httpsUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf06e6587146f9056&redirect_uri=URL&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
		
		//购买
		$('.buy_a').click(function(){
			if(booColor()){
				var count = $('.shuzi').text();
				var color = $('.check').text();
				var coupon = $('.select').val();
				var url = "http://"+serverurl+"/wxmall/order/confirm?prod_id=${prod.prod_id}&count=" + count + "&color=" + color + "&coupon=" + coupon + "&type=1";
				url = encodeURIComponent(url);
				location.href= httpsUrl.replace("URL",url);
			}else{
				alert("请选择颜色");
			}
		});
		
		//送礼
		$('.gift').click(function(){
			if(booColor()){
				var count = $('.shuzi').text();
				var color = $('.check').text();
				var coupon = $('.select').val();
				var url = "http://"+serverurl+"/wxmall/order/confirm?prod_id=${prod.prod_id}&count=" + count + "&color=" + color + "&coupon=" + coupon + "&type=2";
				url = encodeURIComponent(url);
				location.href= httpsUrl.replace("URL",url);
			}else{
				alert("请选择颜色");
			}
		})
		
		$('.fr').click(function(){
			var id = "${prod.prod_id}";
			location.href = "${ctx}/tribe/add?is_band=1&prod_id=" + id;
		});
		
		var mySwiper = new Swiper('.swiper-container', {
			centeredSlides : true,
			slidesPerView : 2
		})
		
	});
</script>
</head>
<body>
	<input type="hidden" value="-1" id="pageIndex" />
	<input type="hidden" value="0" id="pageTotal" />
	<input type="hidden" value="-1" id="pageIndex1" />
	<input type="hidden" value="0" id="pageTotal1" />

	<div class="tab_ul ds_list">
		<c:if test="${empty store}"><img src="${img}/kmf_logo.png" style="width: 130px; height: 50px;"></c:if>
		<c:if test="${not empty store}"><img src="${store.mer_path}" style="width: 130px; height: 50px;"></c:if>
		<a href="${ctx}/" class="back_page"><img src="${img}/back.png" width="16" height="25" /></a>
	</div>

	<!---->
	<div class="shoop_head">
		<div class="yh_list">
			<a href="javascript:void(0)">${prod.category.category_name}</a>
		</div>
		<div class="device">
			<div class="swiper-container">
				<div class="swiper-wrapper">
				<c:forEach items="${prod.picList}" var="pic">
					<div class="swiper-slide red-slide">
						<div class="title">
							<img src="${pic.pic_url}" width="150" width="150" />
						</div>
					</div>
				</c:forEach>
				</div>
			</div>
			<div class="pagination"></div>
		</div>
	</div>
	<!---->

	<div class="collect">
		<div class="list">
			<div class="boottom_border">
				<div class="collect_shoop">
					<p class="shoop_n">${prod.prod_name}</p>
					<div class="collect_button">
						<a href="javascript:void(0)">
							<c:if test="${prod.favor==0}"><img src="${img}/star.jpg" width="22" height="22" class="favorImg" /><p class="favorP">已收藏</p></c:if>
							<c:if test="${prod.favor==1}"><img src="${img}/star2.jpg" width="22" height="22" class="favorImg" /><p class="favorP">未收藏</p></c:if>
						</a>
					</div>
				</div>
				<div class="shoop_price">
					酷魔方价：<span><fmt:formatNumber value="${prod.sale_price/100}" type="currency" pattern="￥ 0.00"/></span>
					原价：<del><fmt:formatNumber value="${prod.retail_price/100}" type="currency" pattern="￥ 0.00"/></del>
				</div>

				<div class="proceeds clearfix">
					<span>销量：${prod.salesVolume}件</span><a href="javascript:void(0)" class="fr">发帖&nbsp;&gt;</a>
				</div>
			</div>

			<div class="shoop_change">
				<p class="yhq">
					<font>优惠券</font>
					<c:if test="${not empty cvList}">
						<span><select class="select">
						<option value="0"></option>
						<c:forEach items="${cvList}" var="coupon">
							<option value="${coupon.id}">${coupon.name}</option>
						</c:forEach>
						</select></span>
					</c:if>
					<c:if test="${empty cvList}">
					<input type="hidden" value="0" class="select"/>
						无
					</c:if>
				</p>
				<p class="color">
					<font> 颜&nbsp;&nbsp;&nbsp; 色 </font>
					<c:if test="${not empty prod.colorArray}">
					<c:forEach items="${prod.colorArray}" var="color">
						<a href="javascript:void(0);">${color}</a>
					</c:forEach>
					</c:if>
					<c:if test="${empty prod.colorArray}">
						无
					</c:if>
				</p>
				<p class="buy_n">
					<font>数&nbsp;&nbsp;&nbsp; 量</font>
					<span class="buy_shoop"><span class="number_span number_min"></span><font class="shuzi">1</font><span class="number_span number_add"></span></span>
				</p>
			</div>
		</div>
	</div>

	<div class="buy_s">
		<div class="buy">
			<a href="javascript:void(0)" class="buy_a">立即购买</a>
			<div class="present" style="background: #e7e3e3;">
				<a href="javascript:void(0)" style="color: #a39e9e;"><img src="${img}/present2.jpg" width="30" height="30" />送礼</a>
			</div>
			<div class="present">
				<a href="javascript:void(0)" class="gift"><img src="${img}/present.jpg" width="30" height="30" />送礼</a>
			</div>
		</div>
	</div>
	
	<ul class="ul_tab">
		<li id="li1" class="tab_on">商品介绍</li>
		<li id="li2">拓展阅读</li>
		<li id="li3" class="tab_title">评价（<span>${prod.topicCount}</span>）</li>
	</ul>

	<div class="depict">
		<div id="div1" class="s_depict">
			<c:if test="${empty prod.long_description}"><p class="zwgd">暂无更多</p></c:if>
			<c:if test="${not empty prod.long_description}">${prod.long_description}</c:if>
		</div>
		<div id="div2" class="s_depict"></div>
		<div id="div3" class="s_depict"></div>
	</div>
	
	<script type="text/javascript">
	$(function(){
		$(".title img").click(function(){
			var imgArr = new Array();
			var i = 0;
			$(".title img").each(function(){
				imgArr[i] = $(this).attr("src");
				i++;
			})
			WeixinJSBridge.invoke("imagePreview",{
				"urls":imgArr,
				"current":$(this).attr("src")
			})
		});
	})
	var topL0 = $(".buy_s").offset().top;
	$(window).scroll(function() {
		var window_h = $(window).scrollTop();
		if (window_h >= topL0) {
			$(".buy_s").addClass("test");
			$(".depict").css("padding-bottom", "66px");
		} else {
			$(".buy_s").removeClass("test");
			$(".depict").css("padding-bottom", "0px");
		}
	});
	
	</script>
	
<jsp:include page="/foot.jsp" />
</body>
</html>
