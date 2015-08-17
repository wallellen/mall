<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta content="telephone=no" name="format-detection" />
<title>我的记录查询</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<link type="text/css" rel="stylesheet" href="${css}/style.css" />
<script type="text/javascript" src="${js}/iscroll.js"></script>
<script type="text/javascript">
	var myScroll;
	function loaded() {
		myScroll = new iScroll('wrapper', {
			scrollbarClass : 'myScrollbar',
			bounce : false
		});
	}
	
	document.addEventListener('DOMContentLoaded', loaded, false);
	
	function startCrowd() {
		var href = encodeURIComponent("http://"+serverurl+"/wxmall/order/start");
		var httpsUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf06e6587146f9056&redirect_uri=URL&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
		var url = httpsUrl.replace("URL", href);
		window.location.href = url;				
	} 

	
	//计算宽度
	function go(num,sum,imgWidth){ 
		var percent= (num/sum).toFixed(2);
	/* 	if (0 != percent && 0==parseInt(percent*100)){
			percent = 0.01;
		} */
		//alert(percent);
	    var tempwidth = $("#bar").width();
	    if (null == tempwidth || "" == tempwidth){
	    	 
	    	tempwidth= document.body.clientWidth - imgWidth -60 ;
	    }
	    var showWidth = 0;
	    if (0 != percent){
	    	showWidth = parseInt(tempwidth * percent) -30; 
	    }
	    return showWidth ;
	} 
	//加载我的众筹信息
	$.post("${ctx}/raise/getCrowdOrder", function (result){
		if (result){
			 var html = "";
			 for(var i =0 ;i< result.length;i++){
				html += "<div class=\"role-shoop\"><div class=\"shoop_nr\"><p class=\"jk-shoop-name\">";
				html += result[i].prodList[0].prod_name;
				html +="</p><table  width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" height=\"52\"><tr><td class=\"my_crowd\">";
				html += " <input type=\"hidden\" name=\"oid\" value=\"";
				html += result[i].order_id ;
				html += " \" />";
				html +=  "<div style=\"padding-right: 60px; position: relative;\"><span style=\"width: 100%; height: 20px; background: #ff3d45; border-radius: 10px; display: inline-block\">";
				html +="</span><span style=\"position: absolute; right: 0px; width: 60px; top: 0px; height: 25px; line-height: 25px; font-size: 14px; padding-left: 5px; color: #ff3743\">";
				var total =(result[i].total_prod_price * 100 / 10000).toFixed(2);
				var payed = (result[i].payed_amount * 100 / 10000).toFixed(2);
				var showWidth = go(payed,total,0);
				var leftmount =(total - payed).toFixed(2);
				html += total;
				html += "元</span><span style=\"position: absolute; left: 0px; height: 20px; top: 0px; z-index: 5; width: ";
				html += showWidth;
				html += "; background: url(${img}/jdt-img.png) repeat-x; background-size: 20px 20px; border-top-left-radius: 15px; border-bottom-left-radius: 15px;\"></span>";
				html += "<span style=\"position: absolute; width: 30px; height: 30px; border-radius: 30px; left: ";
				html += showWidth;
				html += "; top: -5px; background: url(${img}/check_bj.png) no-repeat; background-size: 100%\"></span>";
				html += "<span style=\"position: absolute; margin-left: -24px; margin-top: 25px; font-size: 12px; color: #ff3743; left: ";
				html += showWidth;
				html += ";\">还差";
				html += leftmount;
				html += "块钱 </span></div></td></tr></table></div></div>";
			 }
			 //alert(html);
			 $("#crowd_info").html(html);
		}else{
			 
		}
	});
	 
	$.post("${ctx}/raise/getCrowdPay", function (result){
		if (result && result.length > 0){
			 var html = "";
			 for(var i =0 ;i< result.length;i++){
				 html += "<div class=\"role-shoop jk-f-border\"> <div class=\"role-img\"><img src=\"";
				 var imgUrl = result[i].member.member_img;
				 if(imgUrl == "" || imgUrl == null  ){
					 imgUrl = "${img}/grzx2.png";
				 }
				 html += imgUrl;
				 html += "\" width=\"63\" height=\"63\" /><p>";
				 html += result[i].member.member_name;
				 html += "</p></div><div class=\"shoop_nr\"><p class=\"jk-shoop-name\">";
				 html += result[i].order.prodList[0].prod_name;
				 html += "</p><table   width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" height=\"52\"><tr><td class=\"crowd_table\">";
				 html += " <input type=\"hidden\" name=\"oid\" value=\"";
				 html += result[i].order.order_id ;
				 html += " \" />";
				 html += " <input type=\"hidden\" name=\"mid\" value=\"";
				 html += result[i].member.member_id;
				 html += " \" />";
				 
				 
				 
				 html += "<div style=\"padding-right: 60px; position: relative;\"><span style=\"width: 100%; height: 20px; background: #ff3d45; border-radius: 10px; display: inline-block\">";
				 html +="</span><span style=\"position: absolute; right: 0px; width: 60px; top: 0px; height: 25px; line-height: 25px; font-size: 14px; padding-left: 5px; color: #ff3743\">";
				 var total =(result[i].order.total_prod_price * 100 / 10000).toFixed(2);
				 var payed = (result[i].order.payed_amount * 100 / 10000).toFixed(2);
				 var showWidth = go(payed,total,80);
				 var leftmount =(total - payed).toFixed(2);
				 html += total;
				 html += "元</span><span style=\"position: absolute; left: 0px; height: 20px; top: 0px; z-index: 5; width: ";
				 html += showWidth;
				 html += "; background: url(${img}/jdt-img.png) repeat-x; background-size: 20px 20px; border-top-left-radius: 15px; border-bottom-left-radius: 15px;\"></span>";
				 html += "<span style=\"position: absolute; width: 30px; height: 30px; border-radius: 30px; left: ";
				 html += showWidth;
				 html += "; top: -5px; background: url(${img}/check_bj.png) no-repeat; background-size: 100%\"></span>";
				 html += "<span style=\"position: absolute; margin-left: -24px; margin-top: 25px; font-size: 12px; color: #ff3743; left: ";
				 html += showWidth;
				 html += ";\">还差";
				 html += leftmount;
				 html += "块钱 </span></div>";
				 html += "</td></tr></table></div></div>"; 
			 }
			 $("#crowd_info2").html(html);
		}else{
			var html = "你还没给其他朋友赞助哦！";
			$("#crowd_info2").html(html);
		}
	});
	
	$('.my_crowd').live("click",function() {
		var oid = $(this).children("input[name='oid']").val();
		location.href = "${ctx}/raise/detail?order_id="+oid;
	});

	$('.crowd_table').live("click",function() {
		var oid = $(this).children("input[name='oid']").val();
		var mid = $(this).children("input[name='mid']").val();
		location.href = "${ctx}/raise/detail?order_id=" + oid	+ "&share=" + mid;			
	});
</script>
</head>
<body>
	<div class="role">
		<div class="my-start">我发起的众筹</div>

		<c:if test="${!orderFlag}">
			<div class="role-shoop">
				<div class="role-img">
					<c:if test="${empty member.member_img}"><img src="${img}/grzx2.png"  width="63" height="63"/></c:if>
					<c:if test="${not empty member.member_img}"><img src="${member.member_img}"  width="63" height="63"/></c:if>
					<p>${member.member_name}</p>
				</div>

				<div class="shoop_nr">
					<p class="jk-shoop-name">你还未发起众筹喔！</p>
					<div class="jk-other">
						<table width="100%" cellpadding="0" cellspacing="0" height="52">
							<tr id="fqzc"> <td><a href="javascript:startCrowd();" class="jk-my-f">我来发起</a></td></tr>
						</table>
						</p>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${orderFlag}">
			<div class="role-img">
				<c:if test="${empty member.member_img}"><img src="${img}/grzx2.png"  width="63" height="63"/></c:if>
				<c:if test="${not empty member.member_img}"><img src="${member.member_img}"  width="63" height="63"/></c:if>
				<p>${member.member_name}</p>
			</div>
			<div id="crowd_info">
			</div>
		</c:if>
		<div class="jk-my-support">
			<div class="my-start">我赞助过的朋友</div>
		</div>
	</div>

	<div class="end_friends">
		<div class="role" style="padding-bottom: 65px" id="crowd_info2">
		</div>
	</div>


	<!--我要做微商-->
	<div class="jk_bottom">
		<a href="${ctx}/raise/join">我要做微商</a>
	</div>

	<jsp:include page="/foot.jsp" />
</body>
</html>