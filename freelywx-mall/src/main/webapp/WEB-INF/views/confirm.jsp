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
<script type="text/javascript" src="${js}/fastclick.min.js"></script>
<title>选择配送方式</title>
<link href="${css }/common.css" rel="stylesheet" type="text/css">
<style>
.btnDiv {
	margin-top: 21px;
	height: auto;
	color: #723d2d;
}

.btnDiv button {
	width: 259px;
	height: 86px;
	color: #723d2d;
	border: none;
	margin-bottom: 7px;
}

.btnDiv button p.cls1 {
	font-size: 24px;
}

.btnDiv button p.cls2 {
	font-size: 14px;
}
</style>
</head>
<body style="font-size: 14px; background: #FFFFFF">
	<section style="text-align: center">
		<div
			style="width: 100%; height: 200px; background: url(${img}/bg_delivery.png); background-size: auto 100%;">
			<img
				src="${img}/img_deliver_logo.png"
				style="width: auto; height: 100%;" />
		</div>
		<div
			style="text-align: center; color: #353535; font-size: 19px; margin: 20px 0px 16px;">
			<p>您现在...</p>
		</div>

		<div class="btnDiv">
			<button
				style="background: url(${img}/img_btn_delivery.png) no-repeat; background-origin: border-box; background-size: 100% 100%;"
				id="jsps">
				<p class='cls1'>不在门店</p>
				<p class='cls2'>(需要配送)</p>
			</button>
		</div>

		<div class="btnDiv">
			<button
				style="background: url(${img}/img_btn_delivery.png) no-repeat; background-origin: border-box; background-size: 100% 100%;"
				id="mdzq">
				<p class='cls1'>我在门店</p>
				<p class='cls2'>(需要自取)</p>
			</button>
		</div>
	</section>

	<script>
		$(function() {
			if (!sessionStorage.orderinfo) {
				navigateTo("postwayselector", "home");
			}
			FastClick.attach(document.body);
			$("button").click(function() {
				submitPostWay(this.id);
			});
		});

		//根据类型跳转页面
		function submitPostWay(postwayId) {
			if (postwayId == DELIVERY_TYPE_MDZQ) {
				var deliveryInfo = sessionStorage.deliveryInfo;
				deliveryInfo = $.parseJSON(deliveryInfo);
				deliveryInfo.delivery_type = postwayId;
				sessionStorage.deliveryInfo = JSON.stringify(deliveryInfo);
				//自取,直接跳转到订单确认页
				navigateTo("postwayselector", "orderform");
			} else {
				//配送
				//用户在此楼栋是否有配送地址，有则跳到订单确认页，无则跳到地址填写页
				doGetLastDeliveryInfo(postwayId);
			}
		}

		//从服务器获取上次的地址信息
		function doGetLastDeliveryInfo(postwayId) {
			var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/getlastaddrbyuserid.html";
			var params = {};
			var deliveryInfo = sessionStorage.deliveryInfo;
			var userInfo = sessionStorage.userInfo;
			if (userInfo == undefined) {
				//自动登录失败，则需要填写
				navigateTo("postwayselector", "login");
			}

			deliveryInfo = $.parseJSON(deliveryInfo);
			userInfo = $.parseJSON(userInfo);

			params.user_id = userInfo.user_id;
			params.building_id = deliveryInfo.building_id;
			_postAjax(
					url,
					params,
					function(result) {
						if (result) {
							result = $.parseJSON(result);
							// 成功是0 非0是失败
							if (result.ret_code == "0") {
								//存入本地存储中
								var delInfo = result.address;
								var deliveryInfo = sessionStorage.deliveryInfo;

								if (deliveryInfo == undefined) {
									deliveryInfo = delInfo;
								} else {
									deliveryInfo = $.parseJSON(deliveryInfo);
									if (delInfo.building_id) {
										deliveryInfo.building_id = delInfo.building_id;
										deliveryInfo.building_name = delInfo.building_name;
										deliveryInfo.detail_location = delInfo.detail_location;
										deliveryInfo.address_id = delInfo.address_id;
									}
									deliveryInfo.username = delInfo.username;
									deliveryInfo.tel = delInfo.tel;
								}

								deliveryInfo.delivery_type = postwayId;
								//0为立即配送，1为预约
								deliveryInfo.appointment = 0;
								sessionStorage.deliveryInfo = JSON
										.stringify(deliveryInfo);
								//跳转订单确认页面
								navigateTo("postwayselector", "orderform");
							} else {
								//默认当前用户的名字与手机
								var deliveryInfo = sessionStorage.deliveryInfo;
								deliveryInfo = $.parseJSON(deliveryInfo);
								deliveryInfo.username = (userInfo.name == '新用户' ? ''
										: userInfo.name);
								deliveryInfo.tel = userInfo.account;
								deliveryInfo.delivery_type = postwayId;
								//0为立即配送，1为预约
								deliveryInfo.appointment = 0;
								sessionStorage.deliveryInfo = JSON
										.stringify(deliveryInfo);

								//没有配送过，则需要填写
								navigateTo("postwayselector",
										"deliveryinfoform");
							}
						} else {
							alert("上次地址信息获取失败，请重试");
							return false;
						}
					});
		}
	</script>
</body>
</html>