<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta content="telephone=no" name="format-detection" />
<title>发起众筹</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript" src="${js}/sha1.js"></script>
<script type="text/javascript">
	$(function (){
		$(".wx1").click(function (){
			var addr = $('#address_id').val();
			if(addr != ""){
				window.location.href = "${ctx}/order/create?prod_id=${crowd.prod_id}&new_count=1&address_id="+$("#address_id").val()+"&crowd_id=${crowd.crowd_id}&pay_type=1&type=2&coupon=0&message="+$("#message").val();
			}else{
				alert("请选择地址");
			}
		});
	});
</script>
<script type="text/javascript">
var appid = "wxf06e6587146f9056";

var oldNonceStr;		//随机串
var oldTimeStamp;		//时间戳

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

//获取前面串
function getSignStr() {
	var signStr = "accesstoken=${access_token}&appid=" + appid + "&noncestr=" + oldNonceStr + "&timestamp=" + oldTimeStamp + "&url=" + window.location.href;
	return CryptoJS.SHA1(signStr).toString();
}

document.addEventListener('WeixinJSBridgeReady',function onBridgeReady() {
	$(".address").click(function(e) {
		WeixinJSBridge.invoke('editAddress', {
			"appId" : appid,
			"scope" : "jsapi_address",
			"signType" : "SHA1",
			"timeStamp" : getTimeStamp(),
			"nonceStr" : getNonceStr(),
			"addrSign" : getSignStr()
		}, function(res) {
			if(res.err_msg == 'edit_address:ok'){
				var name = res.userName;
				var phone = res.telNumber;
				var address = res.proviceFirstStageName + res.addressCitySecondStageName + res.addressCountiesThirdStageName + res.addressDetailInfo;
				$('.pag_address').text(address);
				$('.touch').html(name+"<span>"+phone+"</span>");

				$.post("${ctx}/addr/updAddress", {
					name : name,
					phone : phone,
					address : address
				},function (text){
					if (null == jQuery("#address_id").val() || "" == jQuery("#address_id").val()){
					    jQuery("#address_id").val(text);
					}
				});
			}
		});
	});
});
</script>
</head>

<body>
<input type="hidden" id="address_id" value="${address.address_id }" />
	<div class="list" style="margin-top: 15px;">
		<div class="casual">
			<div class="p_title p_no_textarea">
				<textarea placeholder="" id="message" name="message" disabled="disabled" style="font-size: 14px;">${crowd.ext1}</textarea>
			</div>
		</div>
	</div>
	<div class="address conf_address">
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td width="90">
					收货地址：
				</td>
				<td>
					<p class="pag_address">${address.address }</p>
					<p class="touch">${address.consignee_name }<span>${address.phone }</span></p>
				</td>
			</tr>
		</table>
	</div>
	<div class="list" style="margin-top: 20px">
		<div class="pay">
			<a href="javascript:void(0)" class="wx1">找朋友赞助</a>
		</div>
	</div>
	
	<div class="list" style="margin-top: 15px;font-size: 16px;">
		<div class="casual">
			<div class="p_title p_no_textarea">
				<p>1 进入下个页面记得分享给好友，获得好友的赞助资金哟！</p>
				<p>2 该地址为赞助成功后的收货地址，请认真填写 </p>
				<p>3 本次活动均包邮哟</p>
			</div>
		</div>
	</div>
	
<jsp:include page="/foot.jsp" />
</body>
</html>