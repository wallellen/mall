<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport"/>
<meta content="telephone=no" name="format-detection"/>
<link type="text/css" href="${css }/public.css" rel="stylesheet"/>
<link type="text/css" rel="stylesheet" href="${css }/style.css" />
<script type="text/javascript"> 
	var href = encodeURIComponent("http://"+serverurl+"/wxmall/raise/detail?order_id=${order.order_id}&share=${member.member_id}");
	var appId = "";
	var MsgImg = "http://"+serverurl+"/moweiwx/static/images/fenxiang.jpg";
	var TLImg = "http://"+serverurl+"/moweiwx/static/images/fenxiang.jpg";
	var httpsUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf06e6587146f9056&redirect_uri=URL&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
	var url = httpsUrl.replace("URL",href);
	var title = '${crowd.wx_title}';
	var desc = '${crowd.wx_remark}';
	var fakeid = "";
	var openId = "";
	share(appId, MsgImg, TLImg, url, title, desc, fakeid, openId);
	function toShare(){
		jQuery('.shoop_share').show();
	} 
jQuery(function (){
	jQuery("#product").click(function (){
		jQuery("#description").removeClass("on");
		jQuery(this).addClass("on");
		jQuery(".zc-shoop").show();
		jQuery(".zc-qk").hide();
	});
	jQuery("#description").click(function (){
		jQuery("#product").removeClass("on");
		jQuery(this).addClass("on");
		jQuery(".zc-shoop").hide();
		jQuery(".zc-qk").show();
	});
	
	jQuery("#zz").click(function (){
		jQuery.post("${ctx}/raise/checkAmount", {"order_id":"${order.order_id}"}, function (result){
			if (result){
				alert("订单已完成");
			}else{
				window.location.href = "${ctx }/raise/support?order_id=${order.order_id}&type=1&pay_type=1&share_member_id=${share_member.member_id}";
			}
		});
	});
 
	
	jQuery("#bq").click(function (){
		jQuery.post("${ctx}/raise/checkAmount", {"order_id":"${order.order_id}"}, function (result){
			if (result){
				alert("订单已完成");
			}else{
				window.location.href = "${ctx }/raise/support?order_id=${order.order_id}&type=1&pay_type=2&share_member_id=${member.member_id}";
			}
		});
	});
	var w=jQuery("#move").width();
	jQuery("#move").css("margin-left",-w/2)
	
	
});
</script>
<title>赞助详情</title>
<script type="text/javascript"> 
	function go(num,sum){ 
		var percent=num/sum;
		if (0 != percent && 0==parseInt(percent*100)){
			percent = 0.01;
		}
	    var tempwidth = $("#bar").width();
	    if (null == tempwidth || "" == tempwidth){
	    	tempwidth= document.body.clientWidth * 0.85;
	    }
	    var showWidth = 0;
	    if (0 != percent){
	    	showWidth = parseInt(tempwidth * percent); 
	    }
	    $("#bar_total").text('<fmt:formatNumber value="${order.payment_price/100}" type="currency" pattern="0.00"/>元');
	    $("#bar_txt").text('还差<fmt:formatNumber value="${order.payment_price/100 -order.payed_amount/100 }" type="currency" pattern="0.00"/>元');
	    $("#bar_pic1").css("width",showWidth);
	    $("#bar_pic2").css("left",showWidth);
	    $("#bar_txt").css("left",showWidth);
} 

setTimeout('go(<fmt:formatNumber value="${order.payed_amount/100}" type="currency" pattern="0.00"/>,<fmt:formatNumber value="${order.payment_price/100}" type="currency" pattern="0.00"/>)',50);
</script> 
</head>

<body>

  <div class="role-shoop c-boder-b">
  		
        <div class="role-img">
			<c:if test='${empty orderMem.member_img }'><img src="${img}/grzx2.png" /></c:if>
			<c:if test='${not empty orderMem.member_img }'><img src="${orderMem.member_img}"  width="63" height="63" /></c:if>
            <p>${orderMem.member_name }</p>
        </div>
        
        <div class="shoop_nr">
            <p class="jk-shoop-name">${prod.prod_name}</p>
             <table width="100%" cellpadding="0" cellspacing="0" height="52">
               	<tr><td>
                	<div  style="padding-right:50px; position:relative;">
                    	<span id="bar" style="width:94%; height:20px; background:#ff3d45; border-radius:10px; display:inline-block"></span>
                        <span id="bar_total" style="position: absolute; right:0px; width:60px;top:0px; height:25px; line-height:25px; font-size:14px; padding-left:5px; color:#ff3743"></span>
                        <span id="bar_pic1" style=" position:absolute; left:0px;height:20px;top:0px; z-index:5;   background:url(${img}/jdt-img.png) repeat-x; background-size:20px 20px; border-top-left-radius:15px;border-bottom-left-radius:15px;"></span>
                        <span id="bar_pic2" style="position:absolute; width:30px; height:30px; border-radius:30px;   top:-5px; background:url(${img}/check_bj.png) no-repeat; background-size:100%"></span>
                        <span id="bar_txt" style="position:absolute;   margin-top:25px; font-size:12px; color:#ff3743;  "> </span>
                    </div>    	
                </td></tr>
            </table>
        </div>
    </div>
    <div class="new-shoop">
     	${order.message}
     </div>  
    <!--banner-->
    <div class="banner">
    	<div class="banner-product">
        	<a href="${ctx}/raise?type=1">产品介绍</a>
        </div> 
        <img src="${crowd.ext3}" width="100%"  />
    </div>
    <div>
    	<ul class="banner-ul clearfix">
        	<li>
            	<c:if test="${ orderMem.member_id != member.member_id }">
                	<a id="zz" href="#">
                	<img src="${img}/iocn-a.png" width="26" height="20" />
					<p>我来赞助</p>
					 </a>
				</c:if>
				<c:if test="${ orderMem.member_id == member.member_id}">
					<a id="bq" href="#">
                	<img src="${img}/iocn-a.png" width="26" height="20" />
					<p>补齐金额</p>
					 </a>
				</c:if>
            </li>
            <li>
            	<c:if test="${orderMem.member_id != member.member_id }">
                	<a href="${ctx}/raise">
	                	<img src="${img}/iocn-b.png"  width="26" height="20"/>
	                    <p > 我也想要 </p>
	                </a>
				</c:if>
				<c:if test="${orderMem.member_id == member.member_id}">
					<a href="javascript:toShare()">
	                	<img src="${img}/iocn-b.png"  width="26" height="20"/>
	                    <p >分享 </p>
	                </a>
				</c:if>
            	
            </li>
            <li>
            	<a href="${ctx}/raise/my">
                	<img src="${img}/iocn-c.png"  width="24" height="20"/>
                    <p  >  记录查询 </p>
                </a>
            </li>
        </ul>
    </div>
     <!--banner end-->
     <div class="tab">
     	<ul class="tab_ul clearfix">
        	<li id="product" class="on" ><a href="javascript:void(0)" >众筹商品</a></li>
            <li id= "description"><a href="javascript:void(0)">众筹情况</a></li>
        </ul>
        <div class="zc-shoop" >
        	${prod.long_description}
        </div>
        <div class="zc-qk" style="display:none">
        	<table cellpadding="0" cellspacing="0" width="100%">
        		<c:forEach var="orderPayList" items="${orderPayList }">
        		<tr>
                	<td width="83" align="center"><img src="${orderPayList.member_img }" width="63" height="63" /></td>
                    <td class="f-p-r">
                    	<div class="jk-pj-name clearfix">
                        	<span class="c-red">${orderPayList.member_name }</span><font><fmt:formatDate value="${orderPayList.pay_time}" type="date"/></font>
                        </div>
                        <p class="good-pj">${orderPayList.message }</p>
                    </td>
                    <td width="80" class="c-mondy">
                    	<p>资助了<span class="c-red"><fmt:formatNumber value="${orderPayList.pay_amount/100}" type="currency" pattern="￥0.00" /></span>元</p>
                    </td>
                </tr>
				</c:forEach>
            </table>
            <c:if test="${empty orderPayList}">
            	<div  style="text-align: center;margin-top: 20px;">暂无好友赞助</div>
            </c:if>
        </div>
        
     </div>  
       <jsp:include page="/foot.jsp" />
</body>
</html>
