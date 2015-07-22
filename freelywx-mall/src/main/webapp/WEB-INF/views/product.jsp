<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
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
	/**var userInfo = sessionStorage.userInfo;
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
	} **/
</script>
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<link rel="stylesheet" type="text/css" href="${css}/font-awesome.css"
	media="all">
<link href="${css}/wcy_shop.css" rel="stylesheet" type="text/css">
<link href="${css}/common.css?v=20150618" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${js}/fastclick.min.js"></script>
<script type="text/javascript" src="${js}/productlist.js"></script>
<style type="text/css">
.opencls {
	cursor: pointer;
	background: #ff7d50;
	background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#ff7d50),
		to(#ff7d50) );
}

.closecls {
	background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#949494),
		to(#C4C4C4) );
}

.circle {
	width: 16px;
	height: 16px;
	background-color: #ff7d50;
	-webkit-border-radius: 100px;
	border-radius: 50%;
	color: #fff;
	position: absolute;
	right: -10px;
	top: -8px;
	font-size: 10px;
	line-height: 16px;
	padding-top: 1px;
	display: none;
}

.numCircle {
	background: #ff7d50;
	position: absolute;
	right: -1px;
	top: 0px;
	width: 18px;
	padding-left: 2px;
	padding-top: 3px;
	color: #fff;
	line-height: 16px;
	height: 16px;
	text-align: center;
	border-radius: 50% 0 0 50%;
	font-size: 13px;
}

#infoSection .arolist dl {
	padding: 4px 14px 9px 90px;
	border-top: solid 1px #F7F7F7;
	margin: 0;
}

#infoSection .arolist div:first-child {
	border-bottom: 0;
}

#infoSection div.arolist dl dd img {
	top: -28px;
	border-radius: 0;
}

#navBar dl dd {
	padding: 4px 0 1px;
}

#footerbar input {
	height: 40px;
	line-height: 40px;
	text-shadow: none;
	font-size: 16px;
}

#listFooter {
	position: fixed;
	bottom: 2px;
	left: 0px;
	right: 0px;
	padding: 9px 15px 0px;
	border-top: 1px solid #cbc9ca;
	height: 48px;
	background: #FFFFFF;
}

.marquee {
	padding-left: 0px;
	background-color: #1E1E1E;
	font-size: 12px;
	color: #FFFFFF;
	height: 20px;
	line-heigh: 20px;
}

.marquee span {
	
}

.btn-cart {
	width: 32px;
	height: 32px;
	z-index: 999;
	display: inline-block;
	vertical-align: middle;
	margin-bottom: 4px;
}
</style>
</head>

<body>
	<input value="/wx/Addons/CoffeeStore/View/default/Public"	id="addonPath" type="hidden">
	<div class="shop_dome">
		<!-- 门店信息 -->
		<div
			style="height: 48px; line-height: 48px; background-color: #F18E28; text-align: center; color: #fff; font-size: 16px;">
			<p
				style="display: inline-block; padding: 0px 20px 0px 60px; cursor: pointer;"
				id="linkto_siteselector">
				<span id="sitenameSpan">武汉市第一医院</span> <img
					src="${img}/prodico_address_arr.png"
					style="height: 10px; width: 10px;">
			</p>
			<p
				style="float: right; padding: 0px 10px 0px 10px; height: 41px; margin-top: 7px;"
				id="siteEvaluatesLink">
				<img src="${img}/prodico_quote.png" style="height: auto; width: 24px;">
			</p>
		</div>

		<!-- 公告信息 -->
		<div class="marquee" style="width: 100%;">
			<img src="${img}/prodico_notice.png"
				style="width: 16px; height: 16px; float: left; margin: 2px 6px 0 6px;">
			<marquee behavior="scroll"
				onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
				scrollamount="3" contenteditable="false" width="90%">
				<span id="site_announce" unselectable="on"
					style="height: 20px; line-height: 20px;">今年夏令三伏，老板下令三福。初福7月13日起至8月21日，首次购买咖啡便可得柠檬杯一个。还等什么，给办公桌面一丝清凉吧~~</span>
			</marquee>
			<div style="clear: both;"></div>
		</div>

		<!-- 导航菜单 -->
		<nav style="height: 808px;" id="navBar">
			<dl>
				<dd class="style5" id="Brolist_0" name="typename">
					<span style="font-size: 12px;">全部</span>
				</dd>
				<dd class="style6" id="Brolist_2" name="typename">
					<span style="font-size: 12px; position: relative;">普通冰咖 <span
						class="circle" id="typenum_2">0</span>
					</span>
				</dd>
				<dd class="style6" id="Brolist_1" name="typename">
					<span style="font-size: 12px; position: relative;">普通热咖 <span
						class="circle" id="typenum_1">0</span>
					</span>
				</dd>
				<dd class="style6" id="Brolist_3" name="typename">
					<span style="font-size: 12px; position: relative;">特浓热咖 <span
						class="circle" id="typenum_3">0</span>
					</span>
				</dd>
				<dd class="style6" id="Brolist_16" name="typename">
					<span style="font-size: 12px; position: relative;">会议壶装 <span
						class="circle" id="typenum_16">0</span>
					</span>
				</dd>
				<dd class="style6" id="Brolist_11" name="typename">
					<span style="font-size: 12px; position: relative;">果汁 <span
						class="circle" id="typenum_11">0</span>
					</span>
				</dd>
				<dd class="style6" id="Brolist_15" name="typename">
					<span style="font-size: 12px; position: relative;">盛夏冰饮 <span
						class="circle" id="typenum_15">0</span>
					</span>
				</dd>
				<dd class="style6" id="Brolist_18" name="typename">
					<span style="font-size: 12px; position: relative;">营养粥 <span
						class="circle" id="typenum_18">0</span>
					</span>
				</dd>
				<dd class="style6" id="Brolist_9" name="typename">
					<span style="font-size: 12px; position: relative;">牛奶 <span
						class="circle" id="typenum_9">0</span>
					</span>
				</dd>
				<dd class="style6" id="Brolist_10" name="typename">
					<span style="font-size: 12px; position: relative;">西点 <span
						class="circle" id="typenum_10">0</span>
					</span>
				</dd>
			</dl>
		</nav>

		<!-- 饮品列表 -->
		<section style="height: 808px;" id="infoSection">
			<article style="padding: 0; border-width: 0" id="productlist">
				<div id="Arolist0" class="arolist" style="display: block;">
					<div
						style="background-color: #fff; height: 24px; line-height: 24px; color: #aaa; font-size: 12px; padding: 4px 0 0 10px;">普通冰咖</div>
					<ul>
						<li id="A150302"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodamerican_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150302"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">美式现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡和水，纯粹之极</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150302">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="14" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150302_-1_-10.00_2" flag="minus_150302"> <img
												btn_prod="14" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150302_1_10.00_2" name="plus_minus_btn"
												flag="plus_150302"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150102"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcaramel_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150102"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">焦糖拿铁现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡，牛奶和焦糖风味</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150102">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="2" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150102_-1_-15.00_2" flag="minus_150102"> <img
												btn_prod="2" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150102_1_15.00_2" name="plus_minus_btn"
												flag="plus_150102"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150204"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodlatte_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150204"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">拿铁现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">最经典浓缩咖啡牛奶组合</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150204">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="12" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150204_-1_-15.00_2" flag="minus_150204"> <img
												btn_prod="12" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150204_1_15.00_2" name="plus_minus_btn"
												flag="plus_150204"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150104"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmocha_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150104"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">摩卡现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡和浓郁巧克力</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150104">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="4" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150104_-1_-15.00_2" flag="minus_150104"> <img
												btn_prod="4" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150104_1_15.00_2" name="plus_minus_btn"
												flag="plus_150104"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150106"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodvanilla_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150106"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">香草拿铁现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡，牛奶和香草</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150106">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="6" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150106_-1_-15.00_2" flag="minus_150106"> <img
												btn_prod="6" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150106_1_15.00_2" name="plus_minus_btn"
												flag="plus_150106"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150108"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodhazelnut_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150108"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">榛果现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡，牛奶和榛果</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150108">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="8" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150108_-1_-15.00_2" flag="minus_150108"> <img
												btn_prod="8" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150108_1_15.00_2" name="plus_minus_btn"
												flag="plus_150108"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
					<input id="qty150302" value="0" name="proQty"
						iden="qty_2_150302_14" proname="美式现磨咖啡（冰）" proprice="10.00"
						imgsrc="american_iced.jpg" type="hidden"><input
						id="qty150102" value="0" name="proQty" iden="qty_2_150102_2"
						proname="焦糖拿铁现磨咖啡（冰）" proprice="15.00" imgsrc="caramel_iced.jpg"
						type="hidden"><input id="qty150204" value="0"
						name="proQty" iden="qty_2_150204_12" proname="拿铁现磨咖啡（冰）"
						proprice="15.00" imgsrc="latte_iced.jpg" type="hidden"><input
						id="qty150104" value="0" name="proQty" iden="qty_2_150104_4"
						proname="摩卡现磨咖啡（冰）" proprice="15.00" imgsrc="mocha_iced.jpg"
						type="hidden"><input id="qty150106" value="0"
						name="proQty" iden="qty_2_150106_6" proname="香草拿铁现磨咖啡（冰）"
						proprice="15.00" imgsrc="vanilla_iced.jpg" type="hidden"><input
						id="qty150108" value="0" name="proQty" iden="qty_2_150108_8"
						proname="榛果现磨咖啡（冰）" proprice="15.00" imgsrc="hazelnut_iced.jpg"
						type="hidden">
					<div style="clear: both"></div>
					<div
						style="background-color: #fff; height: 24px; line-height: 24px; color: #aaa; font-size: 12px; padding: 4px 0 0 10px;">普通热咖</div>
					<ul>
						<li id="A150201"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcappuccino_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150201"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">卡布基诺现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">极丰富奶泡，和浓缩咖啡</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150201">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="9" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150201_-1_-15.00_1" flag="minus_150201"> <img
												btn_prod="9" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150201_1_15.00_1" name="plus_minus_btn"
												flag="plus_150201"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150301"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodamerican_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150301"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">美式现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡和水，纯粹之极</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150301">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="13" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150301_-1_-10.00_1" flag="minus_150301"> <img
												btn_prod="13" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150301_1_10.00_1" name="plus_minus_btn"
												flag="plus_150301"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150101"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcaramel_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150101"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">焦糖拿铁现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡，牛奶和焦糖风味</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150101">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="1" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150101_-1_-15.00_1" flag="minus_150101"> <img
												btn_prod="1" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150101_1_15.00_1" name="plus_minus_btn"
												flag="plus_150101"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150203"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodlatte_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150203"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">拿铁现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">最经典浓缩咖啡牛奶组合</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150203">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="11" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150203_-1_-15.00_1" flag="minus_150203"> <img
												btn_prod="11" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150203_1_15.00_1" name="plus_minus_btn"
												flag="plus_150203"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150103"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmocha_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150103"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">摩卡现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡和浓郁巧克力</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150103">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="3" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150103_-1_-15.00_1" flag="minus_150103"> <img
												btn_prod="3" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150103_1_15.00_1" name="plus_minus_btn"
												flag="plus_150103"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150105"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodvanilla_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150105"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">香草拿铁现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡，牛奶和香草</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150105">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="5" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150105_-1_-15.00_1" flag="minus_150105"> <img
												btn_prod="5" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150105_1_15.00_1" name="plus_minus_btn"
												flag="plus_150105"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150107"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodhazelnut_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150107"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">榛果现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡，牛奶和榛果</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150107">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="7" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150107_-1_-15.00_1" flag="minus_150107"> <img
												btn_prod="7" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150107_1_15.00_1" name="plus_minus_btn"
												flag="plus_150107"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
					<input id="qty150201" value="0" name="proQty" iden="qty_1_150201_9"
						proname="卡布基诺现磨咖啡（热）" proprice="15.00" imgsrc="cappuccino_hot.jpg"
						type="hidden"><input id="qty150301" value="0"
						name="proQty" iden="qty_1_150301_13" proname="美式现磨咖啡（热）"
						proprice="10.00" imgsrc="american_hot.jpg" type="hidden"><input
						id="qty150101" value="0" name="proQty" iden="qty_1_150101_1"
						proname="焦糖拿铁现磨咖啡（热）" proprice="15.00" imgsrc="caramel_hot.jpg"
						type="hidden"><input id="qty150203" value="0"
						name="proQty" iden="qty_1_150203_11" proname="拿铁现磨咖啡（热）"
						proprice="15.00" imgsrc="latte_hot.jpg" type="hidden"><input
						id="qty150103" value="0" name="proQty" iden="qty_1_150103_3"
						proname="摩卡现磨咖啡（热）" proprice="15.00" imgsrc="mocha_hot.jpg"
						type="hidden"><input id="qty150105" value="0"
						name="proQty" iden="qty_1_150105_5" proname="香草拿铁现磨咖啡（热）"
						proprice="15.00" imgsrc="vanilla_hot.jpg" type="hidden"><input
						id="qty150107" value="0" name="proQty" iden="qty_1_150107_7"
						proname="榛果现磨咖啡（热）" proprice="15.00" imgsrc="hazelnut_hot.jpg"
						type="hidden">
					<div style="clear: both"></div>
					<div
						style="background-color: #fff; height: 24px; line-height: 24px; color: #aaa; font-size: 12px; padding: 4px 0 0 10px;">特浓热咖</div>
					<ul>
						<li id="A150303"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodamerican_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150303"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨美式咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">更浓咖啡和水，浓郁之极</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150303">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="25" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150303_-1_-10.00_3" flag="minus_150303"> <img
												btn_prod="25" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150303_1_10.00_3" name="plus_minus_btn"
												flag="plus_150303"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150205"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcappuccino_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150205"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨卡布基诺（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">极丰富奶泡，和更浓咖啡</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150205">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="23" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150205_-1_-15.00_3" flag="minus_150205"> <img
												btn_prod="23" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150205_1_15.00_3" name="plus_minus_btn"
												flag="plus_150205"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150206"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodlatte_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150206"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨拿铁（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">最经典浓缩咖啡牛奶组合</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150206">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="24" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150206_-1_-15.00_3" flag="minus_150206"> <img
												btn_prod="24" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150206_1_15.00_3" name="plus_minus_btn"
												flag="plus_150206"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150109"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcaramel_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150109"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨焦糖拿铁（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">更浓咖啡，牛奶和焦糖</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150109">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="19" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150109_-1_-15.00_3" flag="minus_150109"> <img
												btn_prod="19" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150109_1_15.00_3" name="plus_minus_btn"
												flag="plus_150109"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150110"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmocha_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150110"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨摩卡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">更浓咖啡和香甜巧克力</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150110">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="20" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150110_-1_-15.00_3" flag="minus_150110"> <img
												btn_prod="20" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150110_1_15.00_3" name="plus_minus_btn"
												flag="plus_150110"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150111"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodvanilla_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150111"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨香草拿铁（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">更浓咖啡，牛奶和香草</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150111">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="21" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150111_-1_-15.00_3" flag="minus_150111"> <img
												btn_prod="21" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150111_1_15.00_3" name="plus_minus_btn"
												flag="plus_150111"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150112"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodhazelnut_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150112"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨榛果咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">更浓咖啡，牛奶和榛果</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150112">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="22" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150112_-1_-15.00_3" flag="minus_150112"> <img
												btn_prod="22" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150112_1_15.00_3" name="plus_minus_btn"
												flag="plus_150112"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
					<input id="qty150303" value="0" name="proQty"
						iden="qty_3_150303_25" proname="特浓现磨美式咖啡（热）" proprice="10.00"
						imgsrc="american_hot.jpg" type="hidden"><input
						id="qty150205" value="0" name="proQty" iden="qty_3_150205_23"
						proname="特浓现磨卡布基诺（热）" proprice="15.00" imgsrc="cappuccino_hot.jpg"
						type="hidden"><input id="qty150206" value="0"
						name="proQty" iden="qty_3_150206_24" proname="特浓现磨拿铁（热）"
						proprice="15.00" imgsrc="latte_hot.jpg" type="hidden"><input
						id="qty150109" value="0" name="proQty" iden="qty_3_150109_19"
						proname="特浓现磨焦糖拿铁（热）" proprice="15.00" imgsrc="caramel_hot.jpg"
						type="hidden"><input id="qty150110" value="0"
						name="proQty" iden="qty_3_150110_20" proname="特浓现磨摩卡（热）"
						proprice="15.00" imgsrc="mocha_hot.jpg" type="hidden"><input
						id="qty150111" value="0" name="proQty" iden="qty_3_150111_21"
						proname="特浓现磨香草拿铁（热）" proprice="15.00" imgsrc="vanilla_hot.jpg"
						type="hidden"><input id="qty150112" value="0"
						name="proQty" iden="qty_3_150112_22" proname="特浓现磨榛果咖啡（热）"
						proprice="15.00" imgsrc="hazelnut_hot.jpg" type="hidden">
					<div style="clear: both"></div>
					<div
						style="background-color: #fff; height: 24px; line-height: 24px; color: #aaa; font-size: 12px; padding: 4px 0 0 10px;">会议壶装</div>
					<ul>
						<li id="A150209"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodlatte_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150209"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">拿铁现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;牛奶
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150209">￥30</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="53" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150209_-1_-30.00_16" flag="minus_150209"> <img
												btn_prod="53" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150209_1_30.00_16" name="plus_minus_btn"
												flag="plus_150209"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150117"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcaramel_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150117"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">焦糖拿铁现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;牛奶&amp;焦糖风味
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150117">￥30</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="54" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150117_-1_-30.00_16" flag="minus_150117"> <img
												btn_prod="54" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150117_1_30.00_16" name="plus_minus_btn"
												flag="plus_150117"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150118"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodvanilla_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150118"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">香草拿铁现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;牛奶&amp;香草
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150118">￥30</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="55" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150118_-1_-30.00_16" flag="minus_150118"> <img
												btn_prod="55" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150118_1_30.00_16" name="plus_minus_btn"
												flag="plus_150118"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150119"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmocha_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150119"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">摩卡现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;浓郁巧克力
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150119">￥30</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="56" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150119_-1_-30.00_16" flag="minus_150119"> <img
												btn_prod="56" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150119_1_30.00_16" name="plus_minus_btn"
												flag="plus_150119"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150120"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodhazelnut_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150120"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">榛果现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;牛奶&amp;榛果
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150120">￥30</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="57" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150120_-1_-30.00_16" flag="minus_150120"> <img
												btn_prod="57" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150120_1_30.00_16" name="plus_minus_btn"
												flag="plus_150120"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150306"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodamerican_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150306"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">美式现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;纯粹水
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150306">￥20</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="58" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150306_-1_-20.00_16" flag="minus_150306"> <img
												btn_prod="58" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150306_1_20.00_16" name="plus_minus_btn"
												flag="plus_150306"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
					<input id="qty150209" value="0" name="proQty"
						iden="qty_16_150209_53" proname="拿铁现磨咖啡（壶）" proprice="30.00"
						imgsrc="latte_hot.jpg" type="hidden"><input id="qty150117"
						value="0" name="proQty" iden="qty_16_150117_54"
						proname="焦糖拿铁现磨咖啡（壶）" proprice="30.00" imgsrc="caramel_hot.jpg"
						type="hidden"><input id="qty150118" value="0"
						name="proQty" iden="qty_16_150118_55" proname="香草拿铁现磨咖啡（壶）"
						proprice="30.00" imgsrc="vanilla_hot.jpg" type="hidden"><input
						id="qty150119" value="0" name="proQty" iden="qty_16_150119_56"
						proname="摩卡现磨咖啡（壶）" proprice="30.00" imgsrc="mocha_hot.jpg"
						type="hidden"><input id="qty150120" value="0"
						name="proQty" iden="qty_16_150120_57" proname="榛果现磨咖啡（壶）"
						proprice="30.00" imgsrc="hazelnut_hot.jpg" type="hidden"><input
						id="qty150306" value="0" name="proQty" iden="qty_16_150306_58"
						proname="美式现磨咖啡（壶）" proprice="20.00" imgsrc="american_hot.jpg"
						type="hidden">
					<div style="clear: both"></div>
					<div
						style="background-color: #fff; height: 24px; line-height: 24px; color: #aaa; font-size: 12px; padding: 4px 0 0 10px;">果汁</div>
					<ul>
						<li id="A150506"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodwatermelon.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150506"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">现榨西瓜汁</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">豪饮装，附赠4个16盎司分享杯~</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150506">￥15</b> /瓶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="72" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150506_-1_-15.00_11" flag="minus_150506"> <img
												btn_prod="72" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150506_1_15.00_11" name="plus_minus_btn"
												flag="plus_150506"><span class="hide limit-label">限量0瓶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150507"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodsummer_orange.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150507"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">VC多橙汁</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">全新夏橙，超多维C，酸爽无比</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150507">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="73" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150507_-1_-10.00_11" flag="minus_150507"> <img
												btn_prod="73" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150507_1_10.00_11" name="plus_minus_btn"
												flag="plus_150507"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150508"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_mango.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150508"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">小8真芒</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">新鲜澳芒
										+ 果糖 + 冰块</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150508">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="75" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150508_-1_-15.00_11" flag="minus_150508"> <img
												btn_prod="75" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150508_1_15.00_11" name="plus_minus_btn"
												flag="plus_150508"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
					<input id="qty150506" value="0" name="proQty"
						iden="qty_11_150506_72" proname="现榨西瓜汁" proprice="15.00"
						imgsrc="watermelon.jpg" type="hidden"><input
						id="qty150507" value="0" name="proQty" iden="qty_11_150507_73"
						proname="VC多橙汁" proprice="10.00" imgsrc="summer_orange.jpg"
						type="hidden"><input id="qty150508" value="0"
						name="proQty" iden="qty_11_150508_75" proname="小8真芒"
						proprice="15.00" imgsrc="pic_mango.jpg" type="hidden">
					<div style="clear: both"></div>
					<div
						style="background-color: #fff; height: 24px; line-height: 24px; color: #aaa; font-size: 12px; padding: 4px 0 0 10px;">盛夏冰饮</div>
					<ul>
						<li id="A150901"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmocha_hongdou_bingle.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150901"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">红豆抹茶冰乐</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">红豆
										&amp; 抹茶奶昔 &amp; 冰块</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150901">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="41" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150901_-1_-15.00_15" flag="minus_150901"> <img
												btn_prod="41" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150901_1_15.00_15" name="plus_minus_btn"
												flag="plus_150901"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150902"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmanlin_ice.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150902"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">巧克力咖啡冰乐</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">曼特宁咖啡
										&amp; 巧克力奶昔 &amp; 冰块</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150902">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="42" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150902_-1_-15.00_15" flag="minus_150902"> <img
												btn_prod="42" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150902_1_15.00_15" name="plus_minus_btn"
												flag="plus_150902"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151001"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodbingyao_midou_hongcha.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151001"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">冰瑶蜜豆红茶</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">红茶，果糖，红豆和柠檬片</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151001">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="43" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151001_-1_-10.00_15" flag="minus_151001"> <img
												btn_prod="43" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151001_1_10.00_15" name="plus_minus_btn"
												flag="plus_151001"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151101"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodjinju_guihua_lvcha_ice.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151101"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">冰瑶桔桂绿茶</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">金桔
										&amp; 桂花 &amp; 柠檬 &amp; 绿茶 &amp; 冰块</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151101">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="44" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151101_-1_-10.00_15" flag="minus_151101"> <img
												btn_prod="44" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151101_1_10.00_15" name="plus_minus_btn"
												flag="plus_151101"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151102"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmoli_guihua_qingcha_ice.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151102"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">冰瑶茉桂花茶</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">桂花
										&amp; 柠檬 &amp; 茉莉茶 &amp; 冰块</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151102">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="45" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151102_-1_-10.00_15" flag="minus_151102"> <img
												btn_prod="45" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151102_1_10.00_15" name="plus_minus_btn"
												flag="plus_151102"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
					<input id="qty150901" value="0" name="proQty"
						iden="qty_15_150901_41" proname="红豆抹茶冰乐" proprice="15.00"
						imgsrc="mocha_hongdou_bingle.jpg" type="hidden"><input
						id="qty150902" value="0" name="proQty" iden="qty_15_150902_42"
						proname="巧克力咖啡冰乐" proprice="15.00" imgsrc="manlin_ice.jpg"
						type="hidden"><input id="qty151001" value="0"
						name="proQty" iden="qty_15_151001_43" proname="冰瑶蜜豆红茶"
						proprice="10.00" imgsrc="bingyao_midou_hongcha.jpg" type="hidden"><input
						id="qty151101" value="0" name="proQty" iden="qty_15_151101_44"
						proname="冰瑶桔桂绿茶" proprice="10.00"
						imgsrc="jinju_guihua_lvcha_ice.jpg" type="hidden"><input
						id="qty151102" value="0" name="proQty" iden="qty_15_151102_45"
						proname="冰瑶茉桂花茶" proprice="10.00"
						imgsrc="moli_guihua_qingcha_ice.jpg" type="hidden">
					<div style="clear: both"></div>
					<div
						style="background-color: #fff; height: 24px; line-height: 24px; color: #aaa; font-size: 12px; padding: 4px 0 0 10px;">营养粥</div>
					<ul>
						<li id="A151301"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_lotus.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151301"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">百莲粥</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">百合，莲子，黄豆和燕麦米</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151301">￥10</b> /份
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="65" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151301_-1_-10.00_18" flag="minus_151301"> <img
												btn_prod="65" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151301_1_10.00_18" name="plus_minus_btn"
												flag="plus_151301"><span class="hide limit-label">限量0份/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151302"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_walnuts.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151302"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">核花粥</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">核桃，花生，黄豆和燕麦米</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151302">￥10</b> /份
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="66" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151302_-1_-10.00_18" flag="minus_151302"> <img
												btn_prod="66" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151302_1_10.00_18" name="plus_minus_btn"
												flag="plus_151302"><span class="hide limit-label">限量0份/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151303"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_jujube.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151303"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">枣杞粥</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">红枣，枸杞，黄豆和燕麦米</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151303">￥10</b> /份
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="67" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151303_-1_-10.00_18" flag="minus_151303"> <img
												btn_prod="67" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151303_1_10.00_18" name="plus_minus_btn"
												flag="plus_151303"><span class="hide limit-label">限量0份/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151304"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_sesame.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151304"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">黑麻粥</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">黑芝麻，黑豆和燕麦米</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151304">￥10</b> /份
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="68" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151304_-1_-10.00_18" flag="minus_151304"> <img
												btn_prod="68" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151304_1_10.00_18" name="plus_minus_btn"
												flag="plus_151304"><span class="hide limit-label">限量0份/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151305"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_grains.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151305"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">五谷粥</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">红豆，黄豆，绿豆，黑豆和燕麦米</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151305">￥10</b> /份
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="69" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151305_-1_-10.00_18" flag="minus_151305"> <img
												btn_prod="69" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151305_1_10.00_18" name="plus_minus_btn"
												flag="plus_151305"><span class="hide limit-label">限量0份/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
					<input id="qty151301" value="0" name="proQty"
						iden="qty_18_151301_65" proname="百莲粥" proprice="10.00"
						imgsrc="pic_lotus.jpg" type="hidden"><input id="qty151302"
						value="0" name="proQty" iden="qty_18_151302_66" proname="核花粥"
						proprice="10.00" imgsrc="pic_walnuts.jpg" type="hidden"><input
						id="qty151303" value="0" name="proQty" iden="qty_18_151303_67"
						proname="枣杞粥" proprice="10.00" imgsrc="pic_jujube.jpg"
						type="hidden"><input id="qty151304" value="0"
						name="proQty" iden="qty_18_151304_68" proname="黑麻粥"
						proprice="10.00" imgsrc="pic_sesame.jpg" type="hidden"><input
						id="qty151305" value="0" name="proQty" iden="qty_18_151305_69"
						proname="五谷粥" proprice="10.00" imgsrc="pic_grains.jpg"
						type="hidden">
					<div style="clear: both"></div>
					<div
						style="background-color: #fff; height: 24px; line-height: 24px; color: #aaa; font-size: 12px; padding: 4px 0 0 10px;">牛奶</div>
					<ul>
						<li id="A150401"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmilk_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150401"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">热牛奶</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">香浓牛奶，满满的营养</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150401">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="15" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150401_-1_-10.00_9" flag="minus_150401"> <img
												btn_prod="15" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150401_1_10.00_9" name="plus_minus_btn"
												flag="plus_150401"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
					<input id="qty150401" value="0" name="proQty"
						iden="qty_9_150401_15" proname="热牛奶" proprice="10.00"
						imgsrc="milk_hot.jpg" type="hidden">
					<div style="clear: both"></div>
					<div
						style="background-color: #fff; height: 24px; line-height: 24px; color: #aaa; font-size: 12px; padding: 4px 0 0 10px;">西点</div>
					<ul>
						<li id="A150602"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodLotus.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150602"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">Lotus和情焦糖饼干(条装)</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">12小包24片焦糖饼干</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150602">￥20</b> /条
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="37" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150602_-1_-20.00_10" flag="minus_150602"> <img
												btn_prod="37" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150602_1_20.00_10" name="plus_minus_btn"
												flag="plus_150602"><span class="hide limit-label">限量0条/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
					<input id="qty150602" value="0" name="proQty"
						iden="qty_10_150602_37" proname="Lotus和情焦糖饼干(条装)" proprice="20.00"
						imgsrc="Lotus条装.jpg" type="hidden">
					<div style="clear: both"></div>
				</div>
				<div id="Arolist2" class="arolist" style="display: none;">
					<ul>
						<li id="A150302"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodamerican_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150302"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">美式现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡和水，纯粹之极</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150302">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="14" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150302_-1_-10.00_2" flag="minus_150302"> <img
												btn_prod="14" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150302_1_10.00_2" name="plus_minus_btn"
												flag="plus_150302"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150102"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcaramel_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150102"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">焦糖拿铁现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡，牛奶和焦糖风味</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150102">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="2" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150102_-1_-15.00_2" flag="minus_150102"> <img
												btn_prod="2" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150102_1_15.00_2" name="plus_minus_btn"
												flag="plus_150102"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150204"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodlatte_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150204"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">拿铁现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">最经典浓缩咖啡牛奶组合</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150204">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="12" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150204_-1_-15.00_2" flag="minus_150204"> <img
												btn_prod="12" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150204_1_15.00_2" name="plus_minus_btn"
												flag="plus_150204"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150104"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmocha_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150104"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">摩卡现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡和浓郁巧克力</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150104">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="4" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150104_-1_-15.00_2" flag="minus_150104"> <img
												btn_prod="4" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150104_1_15.00_2" name="plus_minus_btn"
												flag="plus_150104"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150106"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodvanilla_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150106"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">香草拿铁现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡，牛奶和香草</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150106">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="6" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150106_-1_-15.00_2" flag="minus_150106"> <img
												btn_prod="6" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150106_1_15.00_2" name="plus_minus_btn"
												flag="plus_150106"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150108"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodhazelnut_iced.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150108"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">榛果现磨咖啡（冰）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡，牛奶和榛果</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150108">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="8" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150108_-1_-15.00_2" flag="minus_150108"> <img
												btn_prod="8" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150108_1_15.00_2" name="plus_minus_btn"
												flag="plus_150108"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
				</div>
				<div id="Arolist1" class="arolist" style="display: none;">
					<ul>
						<li id="A150201"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcappuccino_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150201"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">卡布基诺现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">极丰富奶泡，和浓缩咖啡</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150201">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="9" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150201_-1_-15.00_1" flag="minus_150201"> <img
												btn_prod="9" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150201_1_15.00_1" name="plus_minus_btn"
												flag="plus_150201"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150301"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodamerican_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150301"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">美式现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡和水，纯粹之极</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150301">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="13" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150301_-1_-10.00_1" flag="minus_150301"> <img
												btn_prod="13" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150301_1_10.00_1" name="plus_minus_btn"
												flag="plus_150301"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150101"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcaramel_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150101"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">焦糖拿铁现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡，牛奶和焦糖风味</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150101">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="1" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150101_-1_-15.00_1" flag="minus_150101"> <img
												btn_prod="1" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150101_1_15.00_1" name="plus_minus_btn"
												flag="plus_150101"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150203"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodlatte_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150203"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">拿铁现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">最经典浓缩咖啡牛奶组合</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150203">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="11" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150203_-1_-15.00_1" flag="minus_150203"> <img
												btn_prod="11" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150203_1_15.00_1" name="plus_minus_btn"
												flag="plus_150203"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150103"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmocha_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150103"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">摩卡现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡和浓郁巧克力</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150103">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="3" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150103_-1_-15.00_1" flag="minus_150103"> <img
												btn_prod="3" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150103_1_15.00_1" name="plus_minus_btn"
												flag="plus_150103"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150105"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodvanilla_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150105"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">香草拿铁现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡，牛奶和香草</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150105">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="5" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150105_-1_-15.00_1" flag="minus_150105"> <img
												btn_prod="5" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150105_1_15.00_1" name="plus_minus_btn"
												flag="plus_150105"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150107"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodhazelnut_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150107"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">榛果现磨咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">浓缩咖啡，牛奶和榛果</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150107">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="7" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150107_-1_-15.00_1" flag="minus_150107"> <img
												btn_prod="7" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150107_1_15.00_1" name="plus_minus_btn"
												flag="plus_150107"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
				</div>
				<div id="Arolist3" class="arolist" style="display: none;">
					<ul>
						<li id="A150303"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodamerican_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150303"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨美式咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">更浓咖啡和水，浓郁之极</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150303">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="25" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150303_-1_-10.00_3" flag="minus_150303"> <img
												btn_prod="25" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150303_1_10.00_3" name="plus_minus_btn"
												flag="plus_150303"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150205"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcappuccino_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150205"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨卡布基诺（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">极丰富奶泡，和更浓咖啡</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150205">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="23" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150205_-1_-15.00_3" flag="minus_150205"> <img
												btn_prod="23" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150205_1_15.00_3" name="plus_minus_btn"
												flag="plus_150205"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150206"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodlatte_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150206"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨拿铁（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">最经典浓缩咖啡牛奶组合</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150206">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="24" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150206_-1_-15.00_3" flag="minus_150206"> <img
												btn_prod="24" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150206_1_15.00_3" name="plus_minus_btn"
												flag="plus_150206"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150109"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcaramel_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150109"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨焦糖拿铁（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">更浓咖啡，牛奶和焦糖</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150109">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="19" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150109_-1_-15.00_3" flag="minus_150109"> <img
												btn_prod="19" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150109_1_15.00_3" name="plus_minus_btn"
												flag="plus_150109"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150110"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmocha_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150110"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨摩卡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">更浓咖啡和香甜巧克力</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150110">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="20" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150110_-1_-15.00_3" flag="minus_150110"> <img
												btn_prod="20" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150110_1_15.00_3" name="plus_minus_btn"
												flag="plus_150110"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150111"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodvanilla_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150111"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨香草拿铁（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">更浓咖啡，牛奶和香草</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150111">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="21" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150111_-1_-15.00_3" flag="minus_150111"> <img
												btn_prod="21" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150111_1_15.00_3" name="plus_minus_btn"
												flag="plus_150111"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150112"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodhazelnut_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150112"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">特浓现磨榛果咖啡（热）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">更浓咖啡，牛奶和榛果</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150112">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="22" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150112_-1_-15.00_3" flag="minus_150112"> <img
												btn_prod="22" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150112_1_15.00_3" name="plus_minus_btn"
												flag="plus_150112"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
				</div>
				<div id="Arolist16" class="arolist" style="display: none;">
					<ul>
						<li id="A150209"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodlatte_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150209"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">拿铁现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;牛奶
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150209">￥30</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="53" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150209_-1_-30.00_16" flag="minus_150209"> <img
												btn_prod="53" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150209_1_30.00_16" name="plus_minus_btn"
												flag="plus_150209"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150117"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodcaramel_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150117"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">焦糖拿铁现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;牛奶&amp;焦糖风味
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150117">￥30</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="54" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150117_-1_-30.00_16" flag="minus_150117"> <img
												btn_prod="54" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150117_1_30.00_16" name="plus_minus_btn"
												flag="plus_150117"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150118"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodvanilla_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150118"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">香草拿铁现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;牛奶&amp;香草
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150118">￥30</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="55" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150118_-1_-30.00_16" flag="minus_150118"> <img
												btn_prod="55" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150118_1_30.00_16" name="plus_minus_btn"
												flag="plus_150118"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150119"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmocha_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150119"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">摩卡现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;浓郁巧克力
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150119">￥30</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="56" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150119_-1_-30.00_16" flag="minus_150119"> <img
												btn_prod="56" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150119_1_30.00_16" name="plus_minus_btn"
												flag="plus_150119"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150120"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodhazelnut_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150120"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">榛果现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;牛奶&amp;榛果
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150120">￥30</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="57" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150120_-1_-30.00_16" flag="minus_150120"> <img
												btn_prod="57" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150120_1_30.00_16" name="plus_minus_btn"
												flag="plus_150120"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150306"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodamerican_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150306"
										style="display: none;">0</span> <img alt=""
										src="${img}/prodico_pic_game.png"
										style="position: absolute; left: 0px; bottom: -1px; width: 26px; height: 26px;">
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">美式现磨咖啡（壶）</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">咖啡&amp;纯粹水
										1L会议装</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150306">￥20</b> /壶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="58" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150306_-1_-20.00_16" flag="minus_150306"> <img
												btn_prod="58" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150306_1_20.00_16" name="plus_minus_btn"
												flag="plus_150306"><span class="hide limit-label">限量0壶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
				</div>
				<div id="Arolist11" class="arolist" style="display: none;">
					<ul>
						<li id="A150506"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodwatermelon.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150506"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">现榨西瓜汁</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">豪饮装，附赠4个16盎司分享杯~</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150506">￥15</b> /瓶
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="72" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150506_-1_-15.00_11" flag="minus_150506"> <img
												btn_prod="72" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150506_1_15.00_11" name="plus_minus_btn"
												flag="plus_150506"><span class="hide limit-label">限量0瓶/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150507"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodsummer_orange.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150507"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">VC多橙汁</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">全新夏橙，超多维C，酸爽无比</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150507">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="73" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150507_-1_-10.00_11" flag="minus_150507"> <img
												btn_prod="73" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150507_1_10.00_11" name="plus_minus_btn"
												flag="plus_150507"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150508"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_mango.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150508"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">小8真芒</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">新鲜澳芒
										+ 果糖 + 冰块</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150508">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="75" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150508_-1_-15.00_11" flag="minus_150508"> <img
												btn_prod="75" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150508_1_15.00_11" name="plus_minus_btn"
												flag="plus_150508"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
				</div>
				<div id="Arolist15" class="arolist" style="display: none;">
					<ul>
						<li id="A150901"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmocha_hongdou_bingle.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150901"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">红豆抹茶冰乐</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">红豆
										&amp; 抹茶奶昔 &amp; 冰块</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150901">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="41" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150901_-1_-15.00_15" flag="minus_150901"> <img
												btn_prod="41" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150901_1_15.00_15" name="plus_minus_btn"
												flag="plus_150901"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A150902"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmanlin_ice.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150902"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">巧克力咖啡冰乐</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">曼特宁咖啡
										&amp; 巧克力奶昔 &amp; 冰块</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150902">￥15</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="42" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150902_-1_-15.00_15" flag="minus_150902"> <img
												btn_prod="42" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150902_1_15.00_15" name="plus_minus_btn"
												flag="plus_150902"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151001"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodbingyao_midou_hongcha.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151001"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">冰瑶蜜豆红茶</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">红茶，果糖，红豆和柠檬片</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151001">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="43" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151001_-1_-10.00_15" flag="minus_151001"> <img
												btn_prod="43" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151001_1_10.00_15" name="plus_minus_btn"
												flag="plus_151001"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151101"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodjinju_guihua_lvcha_ice.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151101"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">冰瑶桔桂绿茶</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">金桔
										&amp; 桂花 &amp; 柠檬 &amp; 绿茶 &amp; 冰块</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151101">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="44" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151101_-1_-10.00_15" flag="minus_151101"> <img
												btn_prod="44" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151101_1_10.00_15" name="plus_minus_btn"
												flag="plus_151101"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151102"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmoli_guihua_qingcha_ice.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151102"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">冰瑶茉桂花茶</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">桂花
										&amp; 柠檬 &amp; 茉莉茶 &amp; 冰块</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151102">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="45" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151102_-1_-10.00_15" flag="minus_151102"> <img
												btn_prod="45" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151102_1_10.00_15" name="plus_minus_btn"
												flag="plus_151102"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
				</div>
				<div id="Arolist18" class="arolist" style="display: none;">
					<ul>
						<li id="A151301"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_lotus.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151301"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">百莲粥</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">百合，莲子，黄豆和燕麦米</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151301">￥10</b> /份
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="65" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151301_-1_-10.00_18" flag="minus_151301"> <img
												btn_prod="65" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151301_1_10.00_18" name="plus_minus_btn"
												flag="plus_151301"><span class="hide limit-label">限量0份/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151302"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_walnuts.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151302"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">核花粥</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">核桃，花生，黄豆和燕麦米</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151302">￥10</b> /份
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="66" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151302_-1_-10.00_18" flag="minus_151302"> <img
												btn_prod="66" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151302_1_10.00_18" name="plus_minus_btn"
												flag="plus_151302"><span class="hide limit-label">限量0份/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151303"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_jujube.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151303"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">枣杞粥</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">红枣，枸杞，黄豆和燕麦米</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151303">￥10</b> /份
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="67" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151303_-1_-10.00_18" flag="minus_151303"> <img
												btn_prod="67" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151303_1_10.00_18" name="plus_minus_btn"
												flag="plus_151303"><span class="hide limit-label">限量0份/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151304"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_sesame.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151304"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">黑麻粥</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">黑芝麻，黑豆和燕麦米</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151304">￥10</b> /份
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="68" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151304_-1_-10.00_18" flag="minus_151304"> <img
												btn_prod="68" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151304_1_10.00_18" name="plus_minus_btn"
												flag="plus_151304"><span class="hide limit-label">限量0份/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
						<li id="A151305"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodpic_grains.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_151305"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">五谷粥</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">红豆，黄豆，绿豆，黑豆和燕麦米</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_151305">￥10</b> /份
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="69" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="151305_-1_-10.00_18" flag="minus_151305"> <img
												btn_prod="69" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="151305_1_10.00_18" name="plus_minus_btn"
												flag="plus_151305"><span class="hide limit-label">限量0份/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
				</div>
				<div id="Arolist9" class="arolist" style="display: none;">
					<ul>
						<li id="A150401"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodmilk_hot.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150401"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">热牛奶</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">香浓牛奶，满满的营养</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150401">￥10</b> /杯
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="15" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150401_-1_-10.00_9" flag="minus_150401"> <img
												btn_prod="15" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150401_1_10.00_9" name="plus_minus_btn"
												flag="plus_150401"><span class="hide limit-label">限量0杯/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
				</div>
				<div id="Arolist10" class="arolist" style="display: none;">
					<ul>
						<li id="A150602"
							style="border-top: solid 1px #f7f7f7; width: 100%; height: auto;">
							<div style="padding: 10px 10px 10px 5px; width: 303.58px;"
								name="proitem">
								<div
									style="display: inline-block; width: 76px; height: 76px; position: relative; float: left;">
									<img src="${img}/prodLotus.jpg" alt=""
										style="height: 100%; width: 100%; float: left; border: solid 1px #f7f7f7;">
									<span class="numCircle" name="productNum_150602"
										style="display: none;">0</span>
								</div>
								<div
									style="display: inline-block; float: left; position: relative; word-break: break-all; word-wrap: break-word; padding-left: 10px; width: 217.58px;"
									name="prodetail">
									<p style="color: #353535; margin-bottom: 5px;">Lotus和情焦糖饼干(条装)</p>
									<p style="color: #666; font-size: 12px; margin-bottom: 10px;">12小包24片焦糖饼干</p>
									<div>
										<p style="margin: 0px; display: inline-block; float: left;">
											<em
												style="color: #ff7d50; height: 20px; line-height: 20px; font-size: 10px; font-style: normal;">
												<b style="font-size: 18px; font-weight: normal;"
												id="price_150602">￥20</b> /条
											</em>
										</p>
										<div style="float: right; overflow: hidden;" left_limit="0">
											<img btn_prod="37" src="${img}/prodbtn_red.png"
												style="margin-right: 8px; display: none;"
												name="plus_minus_btn" class="btn-cart"
												iden="150602_-1_-20.00_10" flag="minus_150602"> <img
												btn_prod="37" src="${img}/prodbtn_add.png" class="btn-cart"
												iden="150602_1_20.00_10" name="plus_minus_btn"
												flag="plus_150602"><span class="hide limit-label">限量0条/天</span>
											<div style="clear: both;"></div>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</div>
						</li>
					</ul>
				</div>
			</article>
		</section>

		<div class="clear" style="clear: both;"></div>

		<!-- 底部按钮 -->
		<div id="listFooter">
			<div
				style="float: left; padding-top: 8px; color: #ff7d50; font-size: 16px;">
				<span>合计:</span><span style="font-size: 20px">￥<span
					id="totalAcc">0.00</span></span> <input id="totalNum" value="0"
					type="hidden">
			</div>
			<div id="footerbar" class="o_btn clearfix"
				style="float: right; margin: 0px;">
				<input class="o_btn_back ts1 opencls"
					style="width: 100%; padding: 0px 20px; display: none;"
					disabled="disabled" id="submitBtn" value="点好了(0)" type="button">
				<input class="o_btn_back ts1 closecls"
					style="width: 100%; padding: 0px 20px;" value="打烊了"
					disabled="disabled" id="siteCloseBtn" type="button">
			</div>
			<div style="clear: both"></div>
		</div>
		<!-- 提交产品信息到口味页面 -->
		<form id="tasteform" method="POST"
			action="http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/tastesetting.html">
			<input id="tasteinput" name="pids" value="" type="hidden">
		</form>
	</div>

</body>
</html>