<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta content="telephone=no" name="format-detection" />
<title>确认订单</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript" src="${js}/sha1.js"></script>
<script type="text/javascript">
	setInterval(function(){
		var order_id = document.getElementById("order_id").value;
		var href = encodeURIComponent("http://"+serverurl+"/wxmall/order/gift?order_id="+order_id);
		var appId = "";
		var MsgImg = "http://"+serverurl+"/moweiwx/static/images/fenxiang.jpg";
		var TLImg = "http://"+serverurl+"/moweiwx/static/images/fenxiang.jpg";
		var httpsUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf06e6587146f9056&redirect_uri=URL&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
		var url = httpsUrl.replace("URL",href);
		var title = "您的好友 ${member.member_name} 给你送了一份礼物";
		var desc = "${prod.prod_name}";
		var fakeid = "";
		var openId = "";
		if(order_id != 0)
		share(appId, MsgImg, TLImg, url, title, desc, fakeid, openId);
	},100)
</script>
<script type="text/javascript">
	$(function() {
		var addressS = '${addressS}';

		var cPrice = '${cc.cash_coupon_value}';
		var price = '${prod.sale_price}';
		$('.number_min').click(function() {
			var num = $('.shuzi').text() * 1 - 1;
			if (num == 0)
				num = 1;
			$('.shuzi').text(num);
			$('.countPrice').text("￥" + parseFloat(((num * price) - cPrice) / 100));
		});
		$('.number_add').click(function() {
			var num = $('.shuzi').text() * 1 + 1;
			$('.shuzi').text(num);
			$('.countPrice').text("￥" + parseFloat(((num * price) - cPrice) / 100));
		});

		$('.zf').click(function() {
			var addr_id = $('.addr_id').val() * 1;
			var count = $('.shuzi').text();
			var url = '${ctx}/order/create?${url}&new_count=' + count + '&pay_type=1&address_id_r=' + addr_id + "&order_id=" + $('#order_id').val();
			if (addressS == 1) {
				if (addr_id != 0) {
					location.href = url;
				} else {
					alert("请选择地址")
				}
			} else {
				location.href = url;
			}
		});
		
		$('.fx').click(function(){
			$('.shoop_share').show();
		})
		
		$('.change_address span').click(function() {
			$('.change_address span').removeClass("hover_radio");
			$(this).addClass("hover_radio");
			if($(this).attr("dis") == "zf"){
				$("#zf").show();
				$(".zf").show();
				$(".fx").hide();
			}
			if($(this).attr("dis") == "fx"){
				$("#zf").hide();
				$(".zf").hide();
				$(".fx").show();
				
				var order_id = $('#order_id').val();
				var count = $('.shuzi').text();
				$.post("${ctx}/order/updOrder", {
					order_id : order_id,
					count : count,
					prod_id : "${prod.prod_id}",
					color : "${color}",
					coupon : "${coupon}",
					pay_type : 1,
					type : 1
				}, function(text) {
					$('#order_id').val(text);
				});
			}
		});

	});
</script>
<script type="text/javascript">
	var appid = "wxf06e6587146f9056";

	var oldNonceStr; //随机串
	var oldTimeStamp; //时间戳

	//获取随机串
	function getNonceStr() {
		var $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
		var nonceStr = "";
		for ( var i = 0; i < 32; i++) {
			nonceStr += $chars.charAt(Math.floor(Math.random() * $chars.length));
		}
		oldNonceStr = nonceStr;
		return nonceStr;
	}

	//获取时间戳
	function getTimeStamp() {
		var timeStamp = new Date().getTime().toString();
		oldTimeStamp = timeStamp;
		return timeStamp;
	}

	//获取前面串
	function getSignStr() {
		var signStr = "accesstoken=${access_token}&appid=" + appid + "&noncestr=" + oldNonceStr + "&timestamp=" + oldTimeStamp + "&url=" + window.location.href;
		return CryptoJS.SHA1(signStr).toString();
	}

	document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		$("#zf").click(function(e) {
			WeixinJSBridge.invoke('editAddress', {
				"appId" : appid,
				"scope" : "jsapi_address",
				"signType" : "SHA1",
				"timeStamp" : getTimeStamp(),
				"nonceStr" : getNonceStr(),
				"addrSign" : getSignStr()
			}, function(res) {
				if (res.err_msg == 'edit_address:ok') {
					var name = res.userName;
					var phone = res.telNumber;
					var address = res.proviceFirstStageName + res.addressCitySecondStageName + res.addressCountiesThirdStageName + res.addressDetailInfo;

					$('.pag_address').text(address);
					$('.touch').html(name + "<span>" + phone + "</span>");

					$.post("${ctx}/addr/updAddress", {
						name : name,
						phone : phone,
						address : address
					}, function(text) {
						$('.addr_id').val(text);
					});
				}
			});
		});
	});
</script>
</head>
<body>
	<c:if test="${addressS==1}"><input type="hidden" class="addr_id" value="0" /></c:if>
	<c:if test="${addressS==0}"><input type="hidden" class="addr_id" value="${address.address_id}" /></c:if>
	<input type="hidden" id="order_id" value="0" />

	<div class="tab_ul ds_list">确认订单 <a href="javascript:location.href='${ctx}/getProd?${url}'" class="back_page"><img src="${img}/back.png" width="16" height="25" /></a></div>
	<div class="ds_list succress_top">${tip.text}</div>

	<div class="confirm_info">订单信息</div>
	<div class="list">

		<div class="buy_number">
			<div class="list">
				<div class="shoop_xq clearfix">
					<img src="${prodPic.pic_url}" width="85" height="85" class="fl" />
					<div class="shoop_model">
						<p class="title_number" style="margin-top: 0px;">${prod.prod_name}</p>
						<p>酷魔方价：<span class="number_family"><fmt:formatNumber value="${prod.sale_price/100}" type="currency" pattern="￥ 0.00" /></span></p>
						<p>颜色：<c:if test="${not empty color}">${color}</c:if><c:if test="${empty color}">无</c:if></p>
						<p>数量： <span class="buy_shoop"><span class="number_span number_min"></span><font class="shuzi">${count}</font><span class="number_span number_add"></span></span></p>
					</div>
				</div>
			</div>
		</div>
		
		<div class="address">
			<span class="dispatching">配送方式：</span>普通快递
		</div>
		<%-- <div class="address">
			<span class="dispatching">优&nbsp; 惠&nbsp; 券：</span>
			<c:if test="${not empty cc.cash_coupon_name}">${cc.cash_coupon_name}</c:if>
			<c:if test="${empty cc.cash_coupon_name}">无</c:if>
		</div> --%>

		<div class="change_address boder_p">
			<p><span dis="fx"><input type="radio" /></span>对方填写地址</p>
			<p><span class="hover_radio" dis="zf"><input type="radio" /></span>我填写地址(点击修改)</p>
		</div>

	</div>
	
	<div class="address conf_add" id="zf">
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td class="a_dz">
					<table cellpadding="0" cellspacing="0" border="0" width="100%" style="margin-top: 3px;">
						<tr>
							<td>地</td>
							<td align="right">址：</td>
						</tr>
					</table>
				</td>
				<td>
					<p class="pag_address">${address.address}</p>
					<p class="touch">${address.consignee_name}<span>${address.phone}</span></p>
				</td>
			</tr>
		</table>
	</div>

	<div class="total tatal_no">总价：<span class="countPrice"><fmt:formatNumber value="${prod.sale_price/100*count-cc.cash_coupon_value/100}" type="currency" pattern="￥ 0.00" /></span></div>

	<div class="list">
		<div class="pay">
			<a href="javascript:void(0)" class="wx zf">微信支付</a>
			<a href="javascript:void(0)" class="wx fx" style="display: none;">分享</a>
		</div>
	</div>

	<jsp:include page="/foot.jsp" />
</body>
</html>