<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
<meta content="telephone=no" name="format-detection"/>
<title>微信支付</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript" src="${js}/md5.js"></script>
<script type="text/javascript" src="${js}/sha1.js"></script>
<script type="text/javascript">
$(function(){
	$('.fr').click(function(){
		var id = $(this).next().val();
		location.href="${ctx}/order/finish?order_id="+id+"&type=2";
	});
});
</script>
<script type="text/javascript">

	var appid = "wxf06e6587146f9056";
	var appkey = "Qd0SG67RInaeeLW3DAB0wKLJXAjz93SQAn6DNwlQfnWlvfetbaZzf6D63j2vdeHaW805wmN957OqHUedpz8328spjOhonjUHOo7a6LDZIjhK5TPQNjdbNxsYb6dWeXtU";
	
	var oldNonceStr;		//随机串
	var oldTimeStamp;		//时间戳
	var oldPackageStr;		//扩展串

	//获取随机串
	function getNonceStr() {
		var $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
		var nonceStr = "";
		for (var i = 0; i < 32; i++) {
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

	function getPackageStr() {
		var banktype = "WX";
		var body = "商品名称";	//商品名称信息
		var fee_type = "1";//费用类型，这里1为默认的人民币
		var input_charset = "UTF-8";//字符集，这里将统一使用GBK
		var notify_url = "http://"+serverurl+"/wxmall";//支付成功后将通知该地址
		var out_trade_no = "123456789";//订单号(唯一性)
		var partner = "1220680301";//收款商户号
		var spbill_create_ip = "127.0.0.1";//用户的IP
		var total_fee = "1";//付款总金额。
		var partnerKey = "de4f89c978ea5ea5082aa6c25fa2f1e9";//收款商户KEY(签名串需要，传输串不需要)
		
		body = "${prod.prod_name}";//商品名称
		//out_trade_no = "${order.order_id}";//订单号
		out_trade_no = "${pay_id}";//付款号
		//total_fee = "${order.payment_price}";//总价
		spbill_create_ip = "${IP}";//用户的IP
		
		//首先第一步：对原串进行签名，注意这里不要对任何字段进行编码。这里是将参数按照key=value进行字典排序后组成下面的字符串,在这个字符串最后拼接上key=XXXX。由于这里的字段固定，因此只需要按照这个顺序进行排序即可。
		var signStr = "bank_type=" + banktype + "&body=" + body	+ "&fee_type=" + fee_type + "&input_charset=" + input_charset	+ "&notify_url=" + notify_url + "&out_trade_no=" + out_trade_no	+ "&partner=" + partner + "&spbill_create_ip="	+ spbill_create_ip + "&total_fee=" + total_fee + "&key="+ partnerKey;
		var signStrMD5 = ("" + CryptoJS.MD5(signStr)).toUpperCase();

		//然后第二步，对每个参数进行url转码，如果您的程序是用js，那么需要使用encodeURIComponent函数进行编码。
		banktype = encodeURIComponent(banktype);
		body = encodeURIComponent(body);
		fee_type = encodeURIComponent(fee_type);
		input_charset = encodeURIComponent(input_charset);
		notify_url = encodeURIComponent(notify_url);
		out_trade_no = encodeURIComponent(out_trade_no);
		partner = encodeURIComponent(partner);
		spbill_create_ip = encodeURIComponent(spbill_create_ip);
		total_fee = encodeURIComponent(total_fee);

		//然后进行最后一步，这里按照key＝value除了sign外进行字典序排序后组成下列的字符串,最后再串接sign=value
		var completeString = "bank_type=" + banktype + "&body=" + body	+ "&fee_type=" + fee_type + "&input_charset=" + input_charset	+ "&notify_url=" + notify_url + "&out_trade_no=" + out_trade_no	+ "&partner=" + partner + "&spbill_create_ip="	+ spbill_create_ip + "&total_fee=" + total_fee;
		completeString = completeString + "&sign=" + signStrMD5;

		oldPackageStr = completeString;//记住package，方便最后进行整体签名时取用
		return completeString;
	}

	function getSignStr() {
		var signStr = "appid=" + appid + "&appkey=" + appkey + "&noncestr=" + oldNonceStr + "&package=" + oldPackageStr + "&timestamp=" + oldTimeStamp;
		return CryptoJS.SHA1(signStr).toString();
	}
	
	document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		$('.wx').click(function(e) {
			WeixinJSBridge.invoke('getBrandWCPayRequest', {
				"appId" : appid,
				"timeStamp" : getTimeStamp(),
				"nonceStr" : getNonceStr(),
				"package" : getPackageStr(),
				"signType" : "SHA1",
				"paySign" : getSignStr()
			}, function(e) {
				if (e.err_msg == "get_brand_wcpay_request:ok") {
					alert("支付成功");
					window.location.href = "${ctx}/order/pay?order_id=${order.order_id}&type=1&pay_id=${pay_id}";
				}else if (e.err_msg == "get_brand_wcpay_request:fail") {
					alert("支付失败");
					window.location.href = "${ctx}/order/pay?order_id=${order.order_id}&type=2&pay_id=${pay_id}";
				}else if (e.err_msg == "get_brand_wcpay_request:cancel") {
					alert("支付取消");
				}else{
					alert("支付异常 " + e.err_msg);
				}
			});
		});
	}, false);
</script>
</head>

<body>
<div class="ds_list succress_top">${tip.text}</div>

<div class="pag_success"><img src="${img}/success.jpg" width="30" height="30" />购买成功！<c:if test="${order.order_type==1}">待支付</c:if><c:if test="${order.order_type==2}">货到付款</c:if><span class="number_family">${order.payment_price/100}</span>元</div>

<div class="go clearfix"><a href="javascript:void(0)" class="wx fl" style="background: none repeat scroll 0 0 #e4393c;color: #f7f7f7">微信支付</a><a href="javascript:void(0)" class="fr">查看订单</a><input type="hidden" value="${order.order_id}"/></div>

<div class="info">订单信息</div>

<!--list 商品-->
<div class="success_shoop clearfix">
	<img src="${prodPic.pic_url}" width="98" height="110" class="fl" />
	<div class="shoop_abstract">
		<div class="shoop_title">${prod.prod_name}</div>
		<p>酷魔方价：<span>￥${prod.sale_price/100}</span></p>
		<c:if test="${not empty orderDetailAttr}">
			<p>颜色：<c:if test="${not empty orderDetailAttr.prod_attr_value}">${orderDetailAttr.prod_attr_value}</c:if><c:if test="${empty orderDetailAttr.prod_attr_value}">无</c:if></p>
		</c:if>
		<p>数量：<span>${orderDetail.prod_amount}</span></p>
		<p>总价：<span>${order.payment_price/100}</span></p>
	</div>
</div>
<!--list 商品-->

<jsp:include page="/foot.jsp" />
</body>
</html>