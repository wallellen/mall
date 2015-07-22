<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!DOCTYPE html>
<html class="ui-mobile">
<head>
<!-- base href="http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/orderlist.html&token=gh_afd96c055327&getOpenId=1" -->
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
	sessionStorage.userInfo = JSON
			.stringify({
				"id" : "3340",
				"account" : "18271812185",
				"social_account" : "\u4e00\u6487\u9633\u5149",
				"social_account_type" : "1",
				"name" : "\u4e00\u6487\u9633\u5149",
				"age" : null,
				"gender" : null,
				"qq" : null,
				"email" : null,
				"remain_amount" : "0",
				"status" : 1,
				"created" : "2015-07-08 22:32:58",
				"mytoken" : "enySJtjgb6G%lKl,bqno000oQvi9IDogIjE4MjcxODEyMTg1IiwgImlzc3VlZF9hdCIgOiAiMjAxNS0wNy0wOSAyMToxMzo0NyJ9",
				"user_id" : "3340"
			});
</script>
<script type="text/javascript">
	/* var userInfo = sessionStorage.userInfo;
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
<script type="text/javascript" src="${js}/layer.js"></script>
<script type="text/javascript" src="${js}/fastclick.min.js"></script>
<script type="text/javascript" src="${js}/orderlist.js"></script>
<style>
.addContact span p strong {
	font-weight: normal;
	color: #444;
}

.layermbox1 .layermchild {
	border-radius: 15px;
	background-color: #fffde4;
}
</style>
</head>
<body style="font-size: 12px;" class="ui-mobile-viewport ui-overlay-a">
	<div data-role="page" data-url="${ctx }/order" tabindex="0"
		class="ui-page ui-page-theme-a ui-page-footer-fixed ui-page-active"
		style="padding-bottom: 61px; min-height: 579px;">
		<input type="hidden" id="addonpath" value="/wx/Addons/CoffeeStore/View/default/Public"> 
		<input type="hidden" id="uiIconPath" value="/wx/Addons/CoffeeStore/View/default/Public/icons/ui">
		<!-- 订单列表 -->
		<!-- 订单列表 -->
		<div id="order_list">

			<div class="p_mod">
				<div>
					<ul>
						<li><span style="line-height: 18px">2015-07-11	11:01:48</span> <span style="float: right; color: #F18F28"
							id="status_150711100040011">等待自取</span></li>
						<li class="addContact"><a
							href="http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/orderlist.html#"
							style="display: block; margin-left: 0px;" rel="external"
							id="c_150711100040011" name="orderitem"> <span
								style="margin-left: 0px; margin-right: 20px; float: left; width: 100%;">
									<div class="prod-list">
										<img alt="VC多橙汁" src="${img }/prod/summer_orange.jpg"><label>VC多橙汁</label>
									</div>
							</span>
								<div class="clearFix"></div>
						</a></li>
						<li
							style="padding: 0 17px; line-height: 44px; font-size: 14px; color: #353535"
							id="btnli_150711100040011"><span
							style="color: #888888; float: left; font-size: 12px;">共计:</span><span
							style="float: left">1杯</span><span
							style="color: #888888; margin-left: 6px; float: left; font-size: 12px">合计:</span><span
							style="float: left">￥10.00</span>
							<div class="o_btn"
								style="margin: 0px; float: right; position: relative"></div>
							<div class="clearFix"></div></li>
					</ul>
				</div>
			</div>
		</div>
		<div id="loadMore">
			<a href="javascript:void(0)" id="btnLoadMore" class="ui-link">点击加载更多</a>
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
						<a href="${ctx}/order" data-icon="grid" id="orderlist" class="ui-btn-active ui-link ui-btn ui-icon-grid ui-btn-icon-top" rel="external">订单</a>
					</li>
					<li class="ui-block-c">
						<a href="${ctx }/center" data-icon="star" id="mypage" rel="external" class="ui-link ui-btn ui-icon-star ui-btn-icon-top">我的</a>
					</li>
				</ul>
			</div>
		</div>


	</div>
	<div class="ui-loader ui-corner-all ui-body-a ui-loader-verbose">
		<span class="ui-icon-loading"></span>
		<h1>加载中...</h1>
	</div>
</body>
</html>