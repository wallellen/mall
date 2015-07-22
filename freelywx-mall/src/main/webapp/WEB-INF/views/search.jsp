<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta name="HandheldFriendly" content="true">
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
	/* 	var userInfo = sessionStorage.userInfo;
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
<script type="text/javascript"	src="http://api.map.baidu.com/api?v=2.0&ak=xjHrhcd3ZUrV79HKwZwBEuE8"></script>
<style>
body {
	background: #EAEBEC;
}

.outerdiv #mainContent {
	overflow-y: auto;
	margin: 0;
	width: 100%;
	-webkit-overflow-scrolling: touch;
}

.input-box {
	border: solid 1px #FC8D00;
	height: 100%;
	border-radius: 4px;
	padding: 0 40px 0 35px;
	position: relative;
}

.input-box span:first-child {
	background: url(${img}/ico_location.png) no-repeat;
	background-origin: border-box;
	background-size: 100% 100%;
	width: 18px;
	height: 18px;
	position: absolute;
	top: 9px;
	left: 9px;
}

.input-box .btn-reset {
	background: url(${img}/ico_remove.png) no-repeat;
	background-origin: border-box;
	z-index: 9999;
	background-size: 40% 40%;
	background-position: center;
	width: 38px;
	height: 38px;
	position: absolute;
	top: -1px;
	right: -5px;
	display: none;
}

#search-site {
	padding-left: 7px;
	border-left: solid 2px #D6D6D6;
	width: 100%;
	font-size: 14px;
	border-radius: 0;
	margin-right: -7px;
}

.getinglocation {
	-webkit-animation-name: rotateicon;
	-webkit-animation-duration: 2.0s;
	-webkit-animation-iteration-count: infinite;
	-webkit-animation-timing-function: linear;
}

@
-webkit-keyframes rotateicon /* Safari 和 Chrome */ {from {	-webkit-transform:rotate(0deg);}

to {-webkit-transform: rotate(360deg);}

}
.city-list {
	margin: 11px;
	background: #FFFFFF;
	border-radius: 4px;
	border: solid 1px #D6D7D8;
	overflow: hidden;
}

.city-list span {
	width: 50%;
	text-align: center;
	display: inline-block;
	border: solid 1px #D6D7D8;
	border-width: 1px 1px 0px 0px;
	margin: -2px -1px 0 0px;
	padding: 1px 0 -1px;
	height: 33px;
	line-height: 36px;
}

.site-group-list:first-child {
	margin-top: 11px;
	border-top-width: 1px;
}

.site-group-list {
	margin: 0 11px;
	line-height: 37px;
	background: #FFFFFF;
	border-radius: 2px;
	border: solid 1px #D6D7D8;
	border-top-width: 0;
	overflow: hidden;
}

.site-group-list.selected {
	border-color: #FC8D00;
}

.site-group-list.collapsed {
	height: 37px;
}

.site-group-list.collapsed .site-title span:first-child {
	font-weight: normal;
}

.site-group-list.collapsed .site-title span:nth-child(2) {
	display: none;
}

.site-group-list .site-title {
	border-bottom: solid 1px #D6D7D8;
	color: #929394;
	padding: 0 10px;
	position: relative;
}

.site-group-list .site-title span:first-child {
	color: #333333;
	font-weight: bold;
}

.site-group-list .site-title span:last-child {
	background: url(${img}/ico_arr.png) no-repeat;
	background-origin: border-box;
	background-size: 100% 100%;
	width: 18px;
	height: 18px;
	position: absolute;
	top: 13px;
	right: 9px;
	transform: rotate(270deg);
	-webkit-transform: rotate(270deg);
	transition: all 0.2s ease-out 0s;
}

.site-group-list.collapsed .site-title span:last-child {
	transform: rotate(90deg);
	-webkit-transform: rotate(90deg);
	top: 6px;
	transition: all 0.2s ease-out 0s;
}

.site-group-list .building {
	border-bottom: solid 1px #D6D7D8;
	text-align: center;
	color: #646566;
}

.site-group-list .building:last-child {
	border-width: 0;
}

.site-group-list .building a {
	color: #646566;
}

.site-group-list .building.selected {
	color: #FC8D00;
}

#siteNotFound {
	overflow: hidden;
	height: 0px;
}

.site-not-found {
	background: #FFFFFF;
	padding: 10px;
	overflow: hidden;
}

.site-not-found span {
	line-height: 22px;
	font-size: 14px;
	color: #FC8D00
}

.site-not-found p {
	line-height: 22px;
	font-size: 14px;
	color: #646566;
	clear: both;
}

.site-not-found div {
	width: 50%;
	float: left;
}

.site-not-found a {
	margin: 10px 5px 10px 0;
	display: block;
	border: solid 1px #D6D7D8;
	border-radius: 3px;
	text-align: center;
	padding: 7px;
	color: #646566;
	font-size: 14px;
	line-height: 16px;
}

.site-not-found div:last-child a {
	margin: 10px 0 10px 5px;
	border-color: #FC8D00;
	color: #FC8D00
}
</style>
</head>
<body>
	<div class="outerdiv">
		<div id="mainContent">
			<section>
				<div style="height: 36px; line-height: 36px; background-color: #ffffff; overflow: hideen; padding: 10px; padding-bottom: 12px; border-bottom: solid 1px #D6D7D8">
					<div class="input-box">
						<span id="checkLocation"></span> 
						<input type="text" name="keyword" id="search-site" value="" placeholder="搜索你所在的楼栋" /> 
						<input type="reset" name="reset" id="btnReset" value="" class="btn-reset" />
					</div>
				</div>
			</section>
			<section id="siteNotFound"  >
				<div class="site-not-found" >
					<span class="site-name"> </span>
					<p class="comments">Sorry,您所在的位置离现有门店过于遥远，小8哥就算搭灰机也不能到达，除非在你位置新开一个门店，你支持么？</p>
					<div>
						<a id="havealook" href="javascript:void(0)">算了，随便逛逛</a>
					</div>
					<div>
						<a href="http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/wantasite.html&token=gh_afd96c055327">支持，过来开店</a>
					</div>
				</div>
			</section>
			<section>
				<div class="city-list">
					<span>武汉</span><span>&nbsp;</span>
				</div>
			</section>

			<section>
				<ul id="sitelistUl">
					<!-- <li style="margin-bottom: 5px;">
					<div id="site_1" class="site-group-list collapsed" site_id="1" site_name="取水楼圈" site_code="10001" style="height: 37px; overflow: hidden;">
							<div class="site-title">
								<span>取水楼圈</span><span>（请选择你所在的楼栋）</span><span></span>
							</div>
							<div class="building" name="buildingItem"
								id="b_10001_17_IFC国际金融中心_0" vid="bt_17">IFC国际金融中心</div>
							<div class="building" name="buildingItem" id="b_10001_18_登月大厦_0"
								vid="bt_18">登月大厦</div>
							<div class="building" name="buildingItem"
								id="b_10001_20_福星国际商会大厦_0" vid="bt_20">福星国际商会大厦</div>
							<div class="building" name="buildingItem" id="b_10001_5_环亚大厦_0"
								vid="bt_5">环亚大厦</div>
							<div class="building" name="buildingItem" id="b_10001_19_良友大厦_0"
								vid="bt_19">良友大厦</div>
							<div class="building" name="buildingItem" id="b_10001_6_民生银行大厦_0"
								vid="bt_6">民生银行大厦</div>
							<div class="building" name="buildingItem"
								id="b_10001_13_浦发银行大厦_1" vid="bt_13">浦发银行大厦</div>
							<div class="building" name="buildingItem" id="b_10001_16_庭瑞大厦_0"
								vid="bt_16">庭瑞大厦</div>
							<div class="building" name="buildingItem" id="b_10001_15_伟业大厦_0"
								vid="bt_15">伟业大厦</div>
							<div class="building" name="buildingItem" id="b_10001_24_云湖大厦_0"
								vid="bt_24">云湖大厦</div>
							<div class="building" name="buildingItem" id="b_10001_14_中环大厦_0"
								vid="bt_14">中环大厦</div>
							<div class="building">
								<a href="http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/wantasite.html&amp;token=gh_afd96c055327">找不到您所在的办公楼？</a>
							</div>
						</div>
						<div id="site_2" class="site-group-list collapsed" site_id="2" site_name="航空路圈" site_code="10002" style="height: 37px;">
							<div class="site-title">
								<span>航空路圈</span><span>（请选择你所在的楼栋）</span>
								<span></span>
							</div>
							<div class="building" name="buildingItem" id="b_10002_8_创世纪大厦_1" vid="bt_8">创世纪大厦</div>
							<div class="building" name="buildingItem" id="b_10002_12_湖北广播大楼_0" vid="bt_12">湖北广播大楼</div>
							<div class="building" name="buildingItem" id="b_10002_11_世贸广场写字楼_0" vid="bt_11">世贸广场写字楼</div>
							<div class="building" name="buildingItem" id="b_10002_10_武汉广场写字楼_0" vid="bt_10">武汉广场写字楼</div>
							<div class="building" name="buildingItem" id="b_10002_9_中山广场_0" vid="bt_9">中山广场</div>
							<div class="building">
								<a href="http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/wantasite.html&amp;token=gh_afd96c055327">找不到您所在的办公楼？</a>
							</div>
						</div>
						<div id="site_4" class="site-group-list collapsed" site_id="4" site_name="利济北路圈" site_code="10004" style="height: 37px;">
							<div class="site-title">
								<span>利济北路圈</span><span>（请选择你所在的楼栋）</span><span></span>
							</div>
							<div class="building" name="buildingItem" id="b_10004_22_财源大厦_0" vid="bt_22">财源大厦</div>
							<div class="building" name="buildingItem" id="b_10004_21_泰合广场写字楼_1" vid="bt_21">泰合广场写字楼</div>
							<div class="building" name="buildingItem" id="b_10004_23_武汉市第一医院_0" vid="bt_23">武汉市第一医院</div>
							<div class="building">
								<a href="http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/wantasite.html&amp;token=gh_afd96c055327">找不到您所在的办公楼？</a>
							</div>
						</div></li> -->
				</ul>
			</section>
			<input type="hidden" value="" id="selected_site" />
		</div>
	</div>

	<script>
		//用于存放site列表
		var siteMap = new Map();
		var ac = null;
		$(function() {
			FastClick.attach(document.body);
			doGetSiteList();
			bindEvent();
			baiduAutoComplete();
		});

		function baiduAutoComplete() {
			//建立一个自动完成的对象
			ac = new BMap.Autocomplete({
				"input" : "search-site",
				"location" : '全国',
				"onSearchComplete" : bMapSearchComplete
			});
			ac.addEventListener('onconfirm', function(e) {
				ac.hide();
				searchbuilding();
			}, true);
		}

		function bMapSearchComplete(result) {
			$(".tangram-suggestion div:last-child").hide();
		}

		function bindEvent() {
			$('#checkLocation').click(function() {
				getNearestSite();
			});
			$('#sitelistUl').delegate('.site-group-list', 'click', function() {
				if ($(this).hasClass('collapsed')) {
					$('.site-group-list').animate({
						height : 37
					}, {
						queue : false
					}).addClass('collapsed');
					var count = $(this).find('div').length;
					$(this).animate({
						height : (38 * count)
					}, {
						queue : false
					}).removeClass('collapsed');
				} else {
					$(this).animate({
						height : (37)
					}, {
						queue : false
					}).addClass('collapsed');
				}
			});

			$('#sitelistUl').delegate("div[name='buildingItem']", 'click',
					function() {
						var idarr = this.id.split("_");
						submitSelect(idarr[1], idarr[2], idarr[3] , idarr[4]);
					});

			$('#havealook').click(function() {
				$('#siteNotFound').animate({
					height : 0
				});
				$('.site-group-list').animate({
					height : 37
				}).addClass('collapsed');
				var group = $('.site-group-list:first');
				if (group.length > 0) {
					var count = group.find('div').length;
					group.animate({
						height : (38 * count)
					}, {
						queue : false
					}).removeClass('collapsed');
				}
			});

			$('#search-site').keyup(function() {
				var keyword = $.trim($('#search-site').val());
				if (keyword.length > 0) {
					$('#btnReset').show();
				} else {
					$('#btnReset').hide();
				}
			});
			$('#btnReset').on('touchstart', function() {
				$('#search-site').val('');
				$(this).hide();
				return false;
			});
			$('#search-site').change(function() {
				searchbuilding();
			});
		}

		//定位门店
		function locateSite() {
			//地理定位
			getNearestSite();
		}

		//获取最近门店
		function getNearestSite() {
			if (navigator.geolocation) {
				$('#checkLocation').addClass('getinglocation');
				navigator.geolocation.getCurrentPosition(doGetNearestSite,
						getLocationError, {
							enableHighAccuracy : true,
							timeout : 10000,
							maximumAge : 600000
						});
			} else {
				$('#checkLocation').removeClass('getinglocation');
				showTip("不支持地理位置定位", "#mainContent");
			}
			setTimeout(getLocationError, 9000);
		}
		function getLocationError() {
			if ($('#checkLocation').hasClass('getinglocation')) {
				$('#checkLocation').removeClass('getinglocation');
				showTip("自动定位置失败，请手动选择办公楼", "#mainContent");
			}
		}

		//获取最近门店
		var locationGot = false;
		var notInGroup = false;
		function doGetNearestSite(position) {
			locationGot = false;
			notInGroup = false;
			$('#checkLocation').removeClass('getinglocation');
			doGetLocation(position, function(result) {
				if (result) {
					result = $.parseJSON(result);
					// 成功是0 非0是失败
					if (result.status == "0") {
						var addressComponent = result.result.addressComponent;
						var address = addressComponent.city
								+ addressComponent.district
								+ addressComponent.street
								+ addressComponent.street_number;
						ac.setLocation(addressComponent.city);
						$('.site-name').text(address);
					}
					if (notInGroup) {
						$('#siteNotFound').animate({
							height : 131
						}, function() {
							$(this).height('auto')
						});
					}
				}
				locationGot = true;
			}, function() {
				locationGot = true;
			});

			$('#search-site').attr('placeholder', '正在定位...');
			var url = "${ctx}/store/search";
//查询最近点门店信息			//var url = "${ctx}/store/search";
			var params = {};
			params.lat = parseFloat(position.coords.latitude);
			params['long'] = parseFloat(position.coords.longitude);

			_postAjax(url, params, function(result) {
				$('#search-site').attr('placeholder', '搜索你所在的楼栋');
				if (result) {
					// 成功是0 非0是失败
					if (result.ret_code == "0") {
						var inGroup = result.datas.in_group;
						var building = result.datas.building;
						var buildings = result.ret_info.all_buildings;
						if (inGroup) {
							$("#locate_sitename").html(building.name);
							resortSiteBuildings(building.site_id, buildings,
									building.id);
						} else {
							// 不在圈内
							notInGroup = true;
							if (locationGot) {
								$('#siteNotFound').animate({
									height : 131
								}, function() {
									$(this).height('auto')
								});
							}
						}
					} else {
						$('#locate_sitename').html('自动定位失败，请手动选择');
						showTip("办公楼定位失败，请重试", "#mainContent");
						return false;
					}
				} else {
					$('#locate_sitename').html('自动定位失败，请手动选择');
					showTip("办公楼定位失败，请重试", "#mainContent");
					return false;
				}
			});
		}

		//获取门店列表
		function doGetSiteList() {
			var url = "${ctx}/store/getList";
			var params = {};
			_postAjax(url, params, function(result) {
				if (result) {
					//result = $.parseJSON(result);
					// 成功是0 非0是失败
					if (result.ret_code == "0") {
						generateSiteList(result.datas);
					} else {
						showTip("办公楼获取失败，请重试", "#mainContent");
						return false;
					}
				} else {
					showTip("办公楼获取失败，请重试", "#mainContent");
					return false;
				}
			});
		}

		//渲染门店列表页面
		function generateSiteList(datas) {
			var htmlstr = "";
			for ( var i = 0; i < datas.length; i++) {
				var city = datas[i];
				htmlstr += "<li style='margin-bottom:5px;'>";
				for ( var k in city.sites) {
					var site = city.sites[k];
					var buildings = site.buildings;
					var buildingNum = 0;
					var isOdd = true;

					if (buildings != undefined) {
						buildingNum = buildings.length;
					}

					if (buildingNum % 2 == 0) {
						isOdd = false;
					}

					htmlstr += "<div id='site_" + site.site_id + "' class='site-group-list collapsed' site_id='" + site.site_id + "' site_name='" + site.site_name + "' >"
					htmlstr += "<div class='site-title'>";
					htmlstr += "<span>" + site.site_name
							+ "</span><span>（请选择你所在的楼栋）</span><span></span>";
					htmlstr += "</div>";

					for ( var j in buildings) {
						var divstr = "";
						building = buildings[j];
						divstr += "<div class='building' name='buildingItem' id='b_" + site.site_id + "_" + building.build_id + "_" + building.build_name + "_" + building.has_site +   "' vid='bt_" + building.build_id + "'>"
								+ building.build_name + "</div>";
						htmlstr += divstr;
					}
					htmlstr += "<div class='building'><a href='http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/wantasite.html&token=gh_afd96c055327'>找不到您所在的办公楼？</a></div>";
					htmlstr += "</div>";

					siteMap.put(site.site_id, site);
				}
				htmlstr += "</li>";
			}
			$("#sitelistUl").html(htmlstr);
			locateSite();
		}

		//确认选择
		function submitSelect(site_id, buildingId, buildingName, hasSite) {
			//获取门店信息
			var site = siteMap.get(site_id);
			if (site && site != undefined && site != null) {
				//设置门店信息到本地存储中
				var deliveryInfo = sessionStorage.deliveryInfo;
				if (deliveryInfo == undefined) {
					deliveryInfo = {};
				} else {
					deliveryInfo = $.parseJSON(deliveryInfo);
				}

				if (deliveryInfo.site_id != undefined
						&& deliveryInfo.site_id != site.id) {
					//切换了门店后，需要删除现有的订单记录
					sessionStorage.removeItem("orderinfo");
					sessionStorage.removeItem("productsinfo");
				}

				deliveryInfo.site_city = site.city;
				deliveryInfo.site_district = site.district;
				deliveryInfo.site_name = site.site_name;
				deliveryInfo.sitename = site.cityname + site.districtname + site.site_name;
				deliveryInfo.site_id = site.site_id;
				deliveryInfo.service_buildings = site.buildings;
				deliveryInfo.siteaddr = site.address;
				deliveryInfo.building_id = buildingId;
				deliveryInfo.building_name = buildingName;
				deliveryInfo.building_has_site = hasSite;
				deliveryInfo.detail_location = "";
				deliveryInfo.fromSelector = "true";
				deliveryInfo.announcement = site.announcement;

				sessionStorage.deliveryInfo = JSON.stringify(deliveryInfo);
				sessionStorage.notCheckLBS = true;

				var url = window.location.href.replace("siteselector",	"productlist");
				window.location.href = "${ctx}/product?site_id="+site.site_id;
			} else {
				showTip("请先选择办公楼哦", "#mainContent");
				return false;
			}
		}

		function resortSiteBuildings(siteId, buildings, buildingId) {
			var group = $('#site_' + siteId);
			var site = {
				"site_id" : siteId,
				"site_name" : group.attr('site_name'),
			};

			var htmlstr = "<div id='site_" + site.site_id + "' class='site-group-list collapsed' site_id='" + site.site_id + "' site_name='" + site.site_name + "' >"
			htmlstr += "<div class='site-title'>";
			htmlstr += "<span>" + site.site_name
					+ "</span><span>（请选择你所在的楼栋）</span><span></span>";
			htmlstr += "</div>";

			for ( var j in buildings) {
				var divstr = "";
				building = buildings[j];
				/* divstr += "<div class='building' name='buildingItem' id='b_" + site.site_id + "_" + building.build_id + "_" + building.build_name +   "' vid='bt_" + building.build_id + "'>"
				+ building.build_name + "</div>"; */
				if (building.id == buildingId) {
					divstr += "<div class='building selected' name='buildingItem' id='b_" + site.site_id + "_" + building.build_id + "_" + building.build_name + "_" + building.has_site + "' vid='bt_" + building.build_name + "'>"
							+ building.build_name + "</div>";
				} else {
					divstr += "<div class='building' name='buildingItem' id='b_" + site.site_id + "_" + building.build_id + "_" + building.build_name + "_" + building.has_site + "' vid='bt_" + building.build_id + "'>"
							+ building.build_name + "</div>";
				}
				htmlstr += divstr;
			}
			htmlstr += "<div class='building'><a href='http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/wantasite.html'>找不到您所在的办公楼？</a></div>";
			htmlstr += "</div>";
			group.remove();
			if($('.site-group-list:first')){
				alert(1);
				$("#sitelistUl").html(htmlstr);
			}else{
				$(htmlstr).insertBefore($('.site-group-list:first'));
			}
			$('.site-group-list').animate({
				height : 37
			}, {
				queue : false
			}).addClass('collapsed');
			$('#site_' + siteId).animate({
				height : (76 + 38 * buildings.length)
			}, {
				queue : false
			}).removeClass('collapsed').addClass('selected');
			
		}

		function searchbuilding() {
			var keyword = $.trim($('#search-site').val());
			if (keyword.length) {
				$('#siteNotFound').animate({
					height : 0
				});
				var url = "${ctx}/store/search";
				var params = {
					'keyword' : keyword
				};
				_postAjax(url, params, function(result) {
					var res = false;
					if (result) {
						console.log(result);
						// 成功是0 非0是失败
						if (result.ret_code == "0") {
							res = true;
							var building = result.datas.building;
							var buildings = result.datas.all_buildings;
							resortSiteBuildings(building.site_id, buildings,building.build_id);
						}
					}
					if (!res) {
						$(".site-name").text(keyword);
						$('#siteNotFound').animate({
							height : 131
						}, function() {
							$(this).height('auto')
						});
					}
				}, function() {
					$(".site-name").text(keyword);
					$('#siteNotFound').animate({
						height : 131
					}, function() {
						$(this).height('auto')
					});
				});
			}
		}
	</script>
</body>
</html>