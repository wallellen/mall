<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!DOCTYPE html>
<html class="ui-mobile">
<head>
<!-- base href="http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/home.html&token=gh_afd96c055327&getOpenId=1" -->
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta name="HandheldFriendly" content="true">
<meta name="viewport"	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta name="description" content="">
<title>8hcoffee</title>

<script type="text/javascript" src="${js}/jquery-2.0.3.js"></script>
<script type="text/javascript" src="${js}/spin.js"></script>
<script type="text/javascript" src="${js}/jquery.spin.js"></script>
<script type="text/javascript" src="${js}/myloading.js"></script>
<script type="text/javascript" src="${js}/common.js"></script>
<script type="text/javascript">
	/*  var userInfo = sessionStorage.userInfo;
	 var url = window.location.href;
	 if (userInfo == undefined && window.location.href.indexOf("refresh_session") <= 0) {
	   window.location.href = (url + "&refresh_session=true");
	 } else if (userInfo != undefined && url.indexOf('refresh_session') > 0) {
	   url = url.replace('&refresh_session=true', '');
	   if (url.indexOf("orderform") <= 0 && url.indexOf("goingpayform") <= 0 && url.indexOf("myaccount") <= 0) {
	     if (url.indexOf("showwxpaytitle") > 0) {
	       url = url.replace("&showwxpaytitle=1", "");
	     }
	   }
	   window.location.href = url;
	 } else if (url.indexOf("orderform") <= 0 && url.indexOf("goingpayform") <= 0 && url.indexOf("myaccount") <= 0) {
	   if (url.indexOf("showwxpaytitle") > 0) {
	     url = url.replace("&showwxpaytitle=1", "");
	     window.location.href = url;
	   }
	 } */
</script>
<title>8hcoffee</title>
<link href="${css }/jquery.mobile-1.4.5.min.css" rel="stylesheet"	type="text/css">
<link href="${css }/myorder.css" rel="stylesheet" type="text/css">
<link href="${css }/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${js}/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="${js}/fastclick.min.js"></script>
</head>
<body style="background: rgb(255, 255, 255);"
	class="ui-mobile-viewport ui-overlay-a">
	<div data-role="page"	data-url="${ctx }/index"	tabindex="0"
		class="ui-page ui-page-theme-a ui-page-footer-fixed ui-page-active"
		style="padding-bottom: 61px; min-height: 579px;">
		<img alt="" id="homebgtop" src="${img }/pic_home_top.png"> 
		<img alt="" id="homebgbottom" src="${img }/pic_home_footer.png">
		<div id="homepage" style="width: 360px; height: 579px;">
			<button id="orderBtn" class=" ui-btn ui-shadow ui-corner-all"
				style="top: 272px;">立即点单</button>
		</div>
		<div data-role="footer" data-position="fixed" data-tap-toggle="false"
			id="nav_bar" role="contentinfo"
			class="ui-footer ui-bar-inherit ui-footer-fixed slideup">
			<div data-role="navbar" class="ui-navbar" role="navigation">
				<ul class="ui-grid-b">
					<li class="ui-block-a">
						<a href="${ctx}/index" data-icon="home" id="home" rel="external" class="ui-btn-active ui-link ui-btn ui-icon-home ui-btn-icon-top">首页</a>
					</li>
					<li class="ui-block-b">
						<a href="${ctx}/order" data-icon="grid" id="orderlist" rel="external" class="ui-link ui-btn ui-icon-grid ui-btn-icon-top">订单</a>
					</li>
					<li class="ui-block-c">
						<a href="${ctx}/center" data-icon="star" id="mypage" class="ui-link ui-btn ui-icon-star ui-btn-icon-top" rel="external">我的</a>
					</li>
				</ul>
			</div>
		</div>

		<script>
			$(document).ready(
					function() {
						FastClick.attach(document.body);

						var topVal = $(window).width() - 88;
						if (topVal > $(window).height()) {
							topVal = $(window).height() / 2;
						}
						$('#homepage').width($(window).width()).height($(window).height()- $('#nav_bar').height() - 2);
						$('#orderBtn').css('top', topVal);
						/* $("#nav_bar ul li a").click(
								function() {
									//获取跳转地址 - 临时
									var url = window.location.href.replace("home", $(this).attr("id"));
									$(this).attr("href", url);
								}); */
						$("#orderBtn").click(
								function() {
									//获取跳转地址 - 临时
									var url = window.location.href.replace("home", "productlist");
									window.location.href = url;
								});
					});
		</script>

	</div>
	<div class="ui-loader ui-corner-all ui-body-a ui-loader-default">
		<span class="ui-icon-loading"></span>
		<h1>loading</h1>
	</div>
</body>
</html>