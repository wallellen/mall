<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!doctype html>
<html lang="ch" manifest="/appcache/act/4341?_t=1408499371">
<head>
<title>${crowd.prod_name}</title>
<meta charset="utf-8" />
<meta name="apple-touch-fullscreen" content="YES" />
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="pragram" content="no-cache" />
<link rel="stylesheet" type="text/css" href="${css}/main.css" />
<script type="text/javascript" src="${js}/index/offline.js"></script>
<script type="text/javascript">
	function getUrl(){
		var url  = window.location.href ;
		if(url.indexOf("&code") > -1 ){
			var arr = url.split("&code");
			return arr[0];
		}else if(url.indexOf("?code") > -1){
			var arr = url.split("?code");
			return arr[0];
		}
		return url;
	}
	
	function startCrowd(){
		var href = encodeURIComponent("http://120.24.73.10/wxmall/order/start?crowdId=${crowd.crowd_id}");
		var httpsUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf06e6587146f9056&redirect_uri=URL&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
		var url = httpsUrl.replace("URL",href);
		window.location.href = url;
	}
	
	function shareShow(){
		$('.shoop_share').show();
	}
	
	var jsVer = 24;
	var phoneWidth = parseInt(window.screen.width);
	var phoneScale = phoneWidth / 640;
	var ua = navigator.userAgent;
	if (/Android (\d+\.\d+)/.test(ua)) {
		var version = parseFloat(RegExp.$1);
		if (version > 2.3) {
			document.write('<meta name="viewport" content="width=640, minimum-scale = '+phoneScale+', maximum-scale = '+phoneScale+', target-densitydpi=device-dpi">');
		} else {
			document.write('<meta name="viewport" content="width=640, target-densitydpi=device-dpi">');
		}
	} else {
		document.write('<meta name="viewport" content="width=640, user-scalable=no, target-densitydpi=device-dpi">');
	}
	
	
	var href = encodeURIComponent(getUrl());
	alert(href);
		var appId = "";
	var MsgImg = "${picList[0].url}";
	var TLImg = "${picList[0].url}";
	var httpsUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf2114b6a93f32160&redirect_uri=URL&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
	var url = httpsUrl.replace("URL",href);
	var title = "${crowd.wx_title}";;
	var desc = "${crowd.wx_remark}";
	var fakeid = "";
	var openId = "";
	share(appId, MsgImg, TLImg, url, title, desc, fakeid, openId);
</script>
</head>

<body>
	<section class="u-alert">
		<img style="display: none;" src="${img}/loading_large.gif" />
		<div class='alert-loading z-move'>
            <div class='cycleWrap'>
                <span class='cycle cycle-1'></span>
                <span class='cycle cycle-2'></span>
                <span class='cycle cycle-3'></span>
                <span class='cycle cycle-4'></span>
            </div>
            <div class="lineWrap">
                <span class='line line-1'></span>
                <span class='line line-2'></span>
                <span class='line line-3'></span>
            </div>
        </div>
	</section>
	
	<section class='u-audio f-hide' data-src='${crowd.music_url }'>
		<p id='coffee_flow' class="btn_audio">
            <strong class='txt_audio z-hide'>关闭</strong>
            <span id="imageaudio" class='css_sprite01 audio_open'></span>
        </p>
	</section>
	
	<!-- 箭头指示引导 -->
    <section class='u-arrow f-hide'><p class="css_sprite01"></p></section>
    <!-- 箭头指示引导 end-->
	<!-- page页面内容 -->
    <section class='p-ct'>
        <!-- 旋转正面 -->
        <div id="j-mengban" class='translate-front' data-open="0">
            <div class='mengban-warn'></div>
        </div>
        <!-- 旋转正面 end-->
        <!-- 旋转反面 -->
        <div class='translate-back f-hide'>
            <!-- 封页 1-->
            <!-- 擦一擦 --><!-- <input id="ca-tips" type="hidden" value="擦一擦" /> -->
            <!-- 蒙板背景图 --><!-- <input id="r-cover" type="hidden" value='http://www.yun1688.com.cn/c/TheFuturestore/img/mengban.jpg' /> -->
            
            <c:forEach var="pic" items="${picList }" varStatus="status">
            	<c:choose>
            		<c:when test="${0 == status.index }">
            			 <div class='m-page m-fengye f-hide' data-page-type='info_pic3' data-statics='info_pic3'>
			                <div class="page-con lazy-img" data-src='${pic.url }'></div>
			             </div>
            		</c:when>
            		
            		<c:when test="${fn:length(picList) == status.index + 1 }">
            			 <div class='m-page m-bigTxt f-hide' data-page-type='bigTxt' data-statics='info_list'>
			                 <div class="page-con j-txtWrap lazy-img" data-src='${pic.url }'>
			                 	 <c:if test="${empty type}">
			                 	 	 <div style="text-align:center; width:100% ;  position: absolute;bottom: 230px;  ">
			                 	 	 	<a href="javascript:startCrowd();">
				                         <img src="${img}/zixun_5_${template}.png" style="width: 560px; height: 90px;" />
				                        </a>
				                     </div>
				                     <div style=" text-align:center; width:100% ;  position: absolute;bottom: 120px;  ">
			                 	 	 	<a href="javascript:shareShow();">
				                         <img src="${img}/zixun_7_${template}.png" style="width: 560px; height: 90px;" />
				                        </a>
				                     </div>
								</c:if>
								<c:if test="${not empty type}">
									 <div style=" text-align:center; width:100% ;  position: absolute;bottom: 120px;  ">
									 	<a href="javascript:history.go(-1)">
				                         <img src="${img}/zixun_6_${template}.png" style="width: 560px; height: 90px;" />
				                        </a>
				                     </div>
								</c:if>
			                    <div style="text-align:center; width:100% ; position: absolute; bottom: 5px; ">
			                         <a href="${ctx}/getProd?prod_id=${crowd.prod_id}">
			                         <img src="${img}/zixun_4_${template}.png" style="width: 560px; height: 90px;" />
			                         </a>
			                    </div>
			                </div>
			            </div>
			        </c:when>  
			        <c:otherwise>
			        		<div class='m-page m-bigTxt f-hide' data-page-type='bigTxt' data-statics='info_list'>
				                <div class="page-con j-txtWrap lazy-img" data-src='${pic.url }'>
				                </div>
				            </div>
			        </c:otherwise>     
            	</c:choose>
            </c:forEach>
            
            <!-- 大图文 end-->
        </div>
        <!-- 旋转反面 end-->
    </section>
    <!-- 正文介绍 end-->
	<section class="u-pageLoading">
		<img src="${img}/load.gif" alt="loading" />
	</section>
	
	<!-- <input id="activity_id" type="hidden" value='4341' />
	<input id="r-wx-title" type="hidden" value="以性感之名，发动政变" />
	<input id="r-wx-img" type="hidden" value="http://www.lightapp.cn/userfiles/weixin/tmp/9854/53eefdfd7cd7d.jpg" />
	<input id="r-wx-con" type="hidden" value="属于女性的暴力革命" />
	<input id="r-wx-link" type="hidden" value="http://www.lightapp.cn/auto/index/4341?&amp;weixin.qq.com=#wechat_webview_type=1" />
	<input id="r-wx-callback" type="hidden" value="#" /> -->
	<script src="${js }/index/zepto.js" type="text/javascript" charset="utf-8"></script>
    <script src="${js }/index/coffee.js" type="text/javascript" charset="utf-8"></script>
    <script src="${js }/index/lottery.js" type="text/javascript" charset="utf-8"></script>
    <script src="${js }/index/main.js" type="text/javascript" charset="utf-8" ></script>

	<jsp:include page="/foot.jsp" />
</body>
</html>