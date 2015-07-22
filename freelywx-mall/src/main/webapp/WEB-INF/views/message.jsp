<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title>8小时咖啡在哪儿开店 由你说了算</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta name="HandheldFriendly" content="true" />
<meta name="viewport"	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no;">
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
	/* var userInfo = sessionStorage.userInfo;
	var url = window.location.href;
	if (userInfo == undefined
			&& window.location.href.indexOf("refresh_session") <= 0) {
		window.location.href = (url + "&refresh_session=true");
	} else if (userInfo != undefined && url.indexOf('refresh_session') > 0) {
		url = url.replace('&refresh_session=true', '');
		if (url.indexOf("orderform") <= 0 && url.indexOf("goingpayform") <= 0
				&& url.indexOf("myaccount") <= 0) {
			if (url.indexOf("showwxpaytitle") > 0) {
				url = url.replace("&showwxpaytitle=1", "");
			}
		}
		window.location.href = url;
	} else if (url.indexOf("orderform") <= 0
			&& url.indexOf("goingpayform") <= 0
			&& url.indexOf("myaccount") <= 0) {
		if (url.indexOf("showwxpaytitle") > 0) {
			url = url.replace("&showwxpaytitle=1", "");
			window.location.href = url;
		}
	} */
</script>
<link href="${css}/common.css?v=20150618" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${js}/fastclick.min.js "></script>
<script type="text/javascript"	src="http://api.map.baidu.com/api?v=2.0&ak=DLiLeN2LYrDowUufZx0nNTYL"></script>
<style>
</style>
</head>
<body>
	<div id="wantasite">
		<div>
			<img src="${img}/pic_address.jpg" style="width: 100%; height: auto;" />
		</div>
		<div style="border-bottom: solid 1px #ccc;">
			<div class="o_btn clearfix"
				style="margin-bottom: 20px; margin-top: 15px;">
				<input type="button" value="关注8小时咖啡 店开哪儿你说了算" style="width: 100%" class="o_btn_orange" id="subscribeBtn" />
				<div style="clear: both"></div>
			</div>
		</div>
		<div>
			<ul>
				<li style="border-bottom: solid 1px #ccc; padding: 5px 15px;">
					<div
						style="position: relative; padding-left: 65px; height: auto; min-height: auto;">
						<p style="margin-bottom: 12px;">
							<span>曜阳</span> <span style="float: right; font-size: 12px;">2015-07-11 19:52</span>
						</p>
						<p style="margin-bottom: 6px;"> 希望在<span style="color: #f09128;">武汉市武昌区百瑞景中央生活区</span>开设新门店
						</p>
						<img
							src="http://wx.qlogo.cn/mmopen/pVf2KzEaqibEsjWqr6psxem6J8xrGmiajbhDL3VibWDRnkwy6iboJl40g0DntARLYV9qnt15QH7iaqGrKRFymMIdVmZnWA9YwX3Dr/0"
							style="width: 56px; height: auto; position: absolute; left: 0px; top: 0px;" />
						<div style="clear: both"></div>
					</div>
				</li>
			</ul>
		</div>
	</div>

	<script>
		var addressComponent = null;
		var isfan = '0';
		var ac = null;
		$(function() {
			FastClick.attach(document.body);

			if (isfan == '1') {
				placeLocation();
				bindEvent();
				$("#wishAddBtn").click(function() {
					doAddWish();
				});
			} else {
				//未关注时
				$("#subscribeBtn") .click( function() {
					window.location.href = "http://mp.weixin.qq.com/s?__biz=MjM5Nzg4NDk5NQ==&mid=207116333&idx=1&sn=6dfe6b6fa54593577f868eb48c466b00#rd";
				});
			}

		});

		function bindEvent() {
			//建立一个自动完成的对象
			ac = new BMap.Autocomplete({
				"input" : "buildingname",
				"location" : '全国',
				"onSearchComplete" : bMapSearchComplete
			});
			ac.addEventListener("onconfirm", function() {
				ac.hide();
			}, true);
		}

		function bMapSearchComplete(result) {
			$(".tangram-suggestion div:last-child").hide();
		}

		function placeLocation() {
			if (navigator.geolocation) {
				$('#myplace').html('自动定位中...');
				//精确定位,超时时间10s,缓存时间10m
				navigator.geolocation.getCurrentPosition(getLocation,
						function() {
							$('#myplace').html('自动定位失败');
						}, {
							enableHighAccuracy : true,
							timeout : 10000,
							maximumAge : 600000
						});
			} else {
				showTip("不支持地理位置定位", "#wantasite");
			}
		}

		function getLocation(position) {
			doGetLocation(position, function(result) {
				if (result) {
					result = $.parseJSON(result);
					// 成功是0 非0是失败
					if (result.status == "0") {
						addressComponent = result.result.addressComponent;
						var address = addressComponent.city
								+ addressComponent.district
								+ addressComponent.street
								+ addressComponent.street_number;
						ac.setLocation(addressComponent.city);
						$('#myplace').html(address);
					} else {
						$('#myplace').html('自动定位失败');
						return false;
					}
				} else {
					$('#myplace').html('自动定位失败');
					return false;
				}
			}, function(errinfo) {
				$('#myplace').html('自动定位失败');
				return false;
			});
		}

		function doAddWish() {
			var building_name = $.trim($("#buildingname").val());
			if (building_name == "") {
				showTip("请输入附近的楼宇名称", "#wantasite");
				return false;
			}
			var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/addSiteWish.html";
			var data = {};
			if (addressComponent != null) {
				data.country = addressComponent.country;
				data.province = addressComponent.province;
				data.city = addressComponent.city;
				data.district = addressComponent.district;
				data.street = addressComponent.street;
				data.street_number = addressComponent.street_number;
			}
			if (building_name != "") {
				data.building_name = building_name;
			}
			_postAjax(url, data, function(result) {
				if (result) {
					result = $.parseJSON(result);
					//成功是0 非0是失败
					if (result.ret_code == "0") {
						showTip("您的愿望提交成功", "#wantasite");
						window.location.reload();
					} else {
						showTip(result.ret_info, "#wantasite");
						return false;
					}
				} else {
					showTip("您的愿望提交失败,请重试～", "#wantasite");
					return false;
				}
			});
		}
	</script>
</body>
</html>