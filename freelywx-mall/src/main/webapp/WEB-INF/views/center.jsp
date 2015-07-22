<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!DOCTYPE html>
<html class="ui-mobile">
<head>
<!-- base href="http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/mypage.html&token=gh_afd96c055327&getOpenId=1" -->
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta name="HandheldFriendly" content="true">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta name="description" content="">
<title>8小时咖啡</title>
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
<title>8hcoffee</title>
<link href="${css }/jquery.mobile-1.4.5.min.css" rel="stylesheet" type="text/css">
<link href="${css }/myorder.css" rel="stylesheet" type="text/css">
<link href="${css }/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${js}/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="${js}/fastclick.min.js"></script>
<script type="text/javascript" src="${js}/mypage.js"></script>
<style>
.linkLi {
	cursor: pointer;
}

.linkLi label {
	float: left;
}

.linkLi img {
	height: 16px;
	width: 16px;
	float: right;
	margin-top: 17px;
}
</style>
</head>
<body class="ui-mobile-viewport ui-overlay-a">
	<div data-role="page"	data-url="${ctx}/center" tabindex="0"
		class="ui-page ui-page-theme-a ui-page-footer-fixed ui-page-active"
		style="padding-bottom: 61px; min-height: 579px;">
		<div id="mypage">
			<input type="hidden" value="/wx/Addons/CoffeeStore/View/default/Public" id="publicPath">
			<div id="myinfo" class="user-info">	<img class="fl user_photo" src="${img }/0" id="headpic">
				<div class="fl">
					<label id="user_name">一撇阳光</label> <label id="phone_number">18271812185</label>
				</div>
				<img src="${img }/ico_arr.png">
			</div>
			<div id="loginSection" class="user-info" style="display: none;">
				<img class="fl user_photo" src=".${img }/pic_body.png"> <label>你还未登录</label>
				<img src="${img }/ico_arr.png"> <span id="login">手机验证登录</span>
			</div>

			<section id="myaccount" style="margin: 20px 0">
				<div class="csBody">
					<ul class="proList nobottom">
						<li id="myaccount" class="linkLi">
							<label>账户余额</label> 
							<img src="${img }/ico_arr.png" style="margin-top: 8px; margin-left: 8px;"> 
							<label id="remain_amount" class="fr">￥0元</label>
						</li>
					</ul>
				</div>
			</section>

			<section style="margin: 20px 0">
				<div class="csBody">
					<ul class="proList">
						<li id="mycoupon" class="linkLi">
							<label>兑换券</label> 
							<img src="${img}/ico_arr.png" style="margin-top: 14px;">
						</li>
					</ul>
				</div>
			</section>

			<section>
				<div class="csBody">
					<ul class="proList">
						<!-- <li id="mysuggestion" class="linkLi">
              <label>意见反馈</label>
              <img src="/wx/Addons/CoffeeStore/View/default/Public/icons/ui/ico_arr.png" style="margin-top:14px;" />
            </li> -->
						<li id="aboutus" class="linkLi">
							<label>关于我们</label> 
							<img src="${img }/ico_arr.png" style="margin-top: 14px;">
						</li>
					</ul>
				</div>
			</section>
		</div>
		<div data-role="footer" data-position="fixed" data-tap-toggle="false"
			id="nav_bar" role="contentinfo"
			class="ui-footer ui-bar-inherit ui-footer-fixed slideup">
			<div data-role="navbar" class="ui-navbar" role="navigation">
				<ul class="ui-grid-b">
					<li class="ui-block-a">
						<a href="${ctx }/index" data-icon="home" id="home" rel="external" class="ui-link ui-btn ui-icon-home ui-btn-icon-top">首页</a>
					</li>
					<li class="ui-block-b">
						<a href="${ctx }/order" data-icon="grid" id="orderlist" rel="external" class="ui-link ui-btn ui-icon-grid ui-btn-icon-top">订单</a>
					</li>
					<li class="ui-block-c">
						<a data-icon="star" id="mypage" class="ui-btn-active ui-link ui-btn ui-icon-star ui-btn-icon-top" rel="external">我的</a>
					</li>
				</ul>
			</div>
		</div>


	</div>
	<div class="ui-loader ui-corner-all ui-body-a ui-loader-default">
		<span class="ui-icon-loading"></span>
		<h1>loading</h1>
	</div>
</body>
</html>