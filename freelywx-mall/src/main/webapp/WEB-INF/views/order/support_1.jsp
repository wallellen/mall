<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta content="telephone=no" name="format-detection" />
<title>众筹赞助</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<link type="text/css" rel="stylesheet" href="${css}/style.css" />
<script type="text/javascript" src="${js}/md5.js"></script>
<script type="text/javascript" src="${js}/sha1.js"></script>
<script type="text/javascript">

	var appid = "wx20535c8754819c80";
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
		var partner = "1217924801";//收款商户号
		var spbill_create_ip = "127.0.0.1";//用户的IP
		var total_fee = "1";//付款总金额。
		var partnerKey = "de4f89c978ea5ea5082aa6c25fa2f1e9";//收款商户KEY(签名串需要，传输串不需要)
		
		body = "${orderDetail.prod_name}";//商品名称
		out_trade_no = jQuery("#orderPay_id").val();//订单号
		//total_fee =  jQuery("#pay_amount").val();//总价
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
		
		$('#wx').click(function(e) {
			var boo = false;
	    	var pay = "${needPayAmount/100}0";//剩余待支付的金额
			var treatPay = jQuery("#treatPay").val();//等待支付的金额
			var check=/^(([1-9]\d*\.[0-9]{2})|(0\.[1-9][0-9])|(0\.[0-9][1-9])|([1-9]\d*))$/;
			if(check.test(treatPay)){
				if(parseFloat(treatPay)>parseFloat(pay)){
					//jQuery("#treatPay").val(pay);
					alert("待支付金额大于剩余支付金额");
				}else{
					boo = true;
					var payAmount =(parseFloat(treatPay)* 100).toFixed(0); 
					jQuery("#payFee").val(payAmount);
				}
			}else{
				//jQuery("#treatPay").val(pay);
				alert("支付金额为正整数或保留2位的小数（不足补0，例:100、1.10)");
			}
			
			if (boo){
				jQuery.post('${ctx}/raise/pay',{"order_id":'${order.order_id}',"payFee":jQuery("#payFee").val(),"share_member_id":'${share_member_id}',"needPayAmount":'${needPayAmount}',"message":jQuery("#message").val()},function (result){
					if (result.result == 0){
						jQuery("#orderPay_id").val(result.orderPay_id);
						jQuery("#pay_amount").val(result.pay_amount);
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
								window.location.href = "${ctx}/raise/operatePayerror?orderPay_id="+result.orderPay_id;
							}else if (e.err_msg == "get_brand_wcpay_request:cancel") {
								alert("支付取消");
								window.location.href = "${ctx}/raise/operatePayerror?orderPay_id="+result.orderPay_id;
							}else{
								alert("支付异常 " + e.err_msg);
								window.location.href = "${ctx}/raise/operatePayerror?orderPay_id="+result.orderPay_id;
							}
						});
					}else{
						alert("支付失败");
					}
				});
			}
		});
	}, false);
</script>
</head>

<body>
	<input type="hidden"  id="orderPay_id"/>
	<input type="hidden"  id="pay_amount"/>
	
	<div class="pay_polishing">
		 <c:if test="${pay_type == '1' }">
    	<p class="font-m">输入赞助金额</p>
        <p class="font-b">还可以赞助<fmt:formatNumber value="${needPayAmount/100}" type="currency" pattern="￥0.00"/>元</p>
         </c:if>  
   	 	<c:if test="${pay_type == '2' }">	
   	 	需支付剩余金额<fmt:formatNumber value="${needPayAmount/100}" type="currency" pattern="￥0.00"/>元
    	</c:if>  
    </div>
    <c:if test="${pay_type == '1' }">
    <div class="pay-jk-input">
    	<div class="pay-input">
	         <div class="t-pay">
	             <input type="text" class="input" id="treatPay"  placeholder="请输入支付金额"/>&nbsp;&nbsp;&nbsp;&nbsp元
				 <input type="hidden" id="payFee" />
	         </div>
	         <textarea class="jk-textarea"  placeholder="你可以随便说点什么" id="message">${crowd.ext2}</textarea>
	    </div>
        <div class="jk_wx_pay">
            <a href="#" id="wx">微信支付</a>
        </div>    
    </div>  
    </c:if>  
    <c:if test="${pay_type == '2' }">
     <div class="wx_pay">
     	<input type="hidden" id="treatPay" value="<fmt:formatNumber value="${needPayAmount/100}" type="currency" pattern="0.00"/>" /> 
     	<input type="hidden" id="payFee" />
    	<a href="#" id="wx">微信支付</a>
     </div>
    </c:if>  
    <div class="explain" style="padding-left: 15px;">
    	<p>说明：</p>
        <p>1、为了便于您查询，请关注微信号：锋付智能；</p>
		<p>2、如果未成功积满金额，建议发起者补齐金额；</p>
		<p>3、如果退款，款项会全部退至发起者账户。</p>
		<p>申请退款电话：400-809-9959</p>
    </div>
	<jsp:include page="/foot.jsp" />
</body>
</html>