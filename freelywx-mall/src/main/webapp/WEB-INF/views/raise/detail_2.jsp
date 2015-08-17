<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport"/>
<meta content="telephone=no" name="format-detection"/>
<link type="text/css" href="${css }/zc2.css" rel="stylesheet"/>
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
		jQuery(".zq-img").show();
		jQuery(".zc-qk").hide();
	});
	jQuery("#description").click(function (){
		jQuery("#product").removeClass("on");
		jQuery(this).addClass("on");
		jQuery(".zq-img").hide();
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
	
	jQuery(".more").click(function (){
		window.location.href = "${ctx}/raise?type=1";
	});
	var w=jQuery("#move").width();
	jQuery("#move").css("margin-left",-w/2)
	
	
});
</script>
<title>赞助详情</title>
<script type="text/javascript"> 
	function go(num,sum){ 
		if(num == null || num == ""){
			num = 0;
		}
		if(sum == null || sum == ""){
			sum = 0;
		}
		var percent=num/sum;
		if (  percent > 0 && percent < 0.03){
			percent = 0.03;
		} 
	    var tempwidth = $("#bar").width();
	    if (null == tempwidth || "" == tempwidth){
	    	tempwidth= document.body.clientWidth  ;
	    }
	    var showWidth = 0;
	    showWidth = parseInt(tempwidth * percent); 
  	    $("#bar_payed").text('<fmt:formatNumber value="${order.payed_amount/100 }" type="currency" pattern="0.00"/>');
  	    $("#bar_payed_img").css("width",showWidth);
  	    $("#bar_payed").css("left",showWidth);
} 

setTimeout('go(<fmt:formatNumber value="${order.payed_amount/100}" type="currency" pattern="0.00"/>,<fmt:formatNumber value="${order.payment_price/100}" type="currency" pattern="0.00"/>)',50);
</script> 
</head>

<body>
	<div class="head-shoop ">
        <div class="head-img">
            <c:if test='${empty orderMem.member_img }'><img src="${img}/grzx2.png"  width="65" height="65" /></c:if>
			<c:if test='${not empty orderMem.member_img }'><img src="${orderMem.member_img}"  width="65" height="65" /></c:if>
             
        </div>
        
        <div class="crowd-desc">
        	 <p>${orderMem.member_name }</p>
        	<div class ="crowd-show">${order.message}</div> 
            <div class="crowd-info">
            	<img src="${img}/heart.png" width="17" height="15" style="position:relative;top:-2px" />
                <span >愿望目标:
                	<font style="color:#fe4545; "><fmt:formatNumber value="${order.total_prod_price/100}" type="currency" pattern="0.00"/>元</font>
                </span>
             </div>            
        </div>
    </div>
	<div class="wave-m">
        <img src="${crowd.ext3}"  width="100%"/>
        <div class="more">
        </div>
    </div>
    <div class="bor-w"> 	
    <div class="bar"> 
         <table width="100%" cellpadding="0" cellspacing="0">
            <tr><td class="cj-name" colspan="3" style="padding-right:65px; padding-bottom:5px;">
            <div class="clearfix" style="font-size:16px;">
            	<span class="cj"></span><span class="fr"><font style="font-size:22px; color:#000; margin-right:3px; font-weight:bold;">${fn:length(orderPayList)}</font>人已赞助</span>
              </div>  
            </td>
            </tr>
            
            <tr>
            <td width="15">0</td>
            <td>
           	<div  style="position:relative;">
                	
                    	<span id = "bar" style="width:100%; height:20px; background:#e5e5e5; border-radius:10px; display:inline-block"></span>                        
                    	<span id="bar_payed_img" style=" position:absolute; left:0px;height:19px;top:0px; z-index:5; width:20%; background:url(${img}/bar_m.png) repeat-x; background-size:20px 20px; border-top-left-radius:15px;border-bottom-left-radius:15px;border-top-right-radius:15px;border-bottom-right-radius:15px;"></span>                       
                        <span id="bar_payed" style="position:absolute;left:20%;top:22px;background:url(${img}/bar_title.png) no-repeat; padding:16px 5px 10px; background-size:100% 100%;  text-align:center; font-size:12px; color:#4ac3d3; min-width:48px; text-align:center; margin-left:-29px;"> </span>			
                    </div>
            </td>
            <td style="padding-left:5px;width:40px;"><fmt:formatNumber value="${order.payment_price/100}" type="currency" pattern="0.00"/></td>
            </tr>
         </table>
    </div>
  </div>  
  
   <div class="button">
    	<table cellpadding="0" cellspacing="0" style="width:100%">
        	<tr>
        		<c:if test="${ orderMem.member_id == member.member_id }">
            	<td>
                	<a class="share" href="javascript:toShare()">
                		<img src="${img}/share1.png" width="30" height="18" /><span>分享</span>
                     </a>
                </td>
                <td>
                	<a href="#" id="bq"  class="bq">
                		<img src="${img}/pay.png" width="22" height="18" /><span>补齐资金</span>
                     </a>
                </td>
                <td>
                	<a href="${ctx}/raise/my" class="query">
                		<img src="${img}/query.png" width="17" height="18" /><span>记录查询</span>
                     </a>
                </td>
                </c:if>
        		<c:if test="${ orderMem.member_id != member.member_id }">
            	<td>
                	<a  class="support" id="zz" href="#">
                		<img src="${img}/B_liwu.png" width="20"height="18" /><span>赞助</span>
                     </a>
                </td>
                <td>
                	<a href="${ctx}/raise" class="ask">
                		<img src="${img}/pay.png" width="22" height="18" /><span>我也要</span>
                     </a>
                </td>
                <td>
                	<a href="${ctx}/raise/my" class="query">
                		<img src="${img}/query.png" width="17" height="18" /><span>记录查询</span>
                     </a>
                </td>
                </c:if>
            </tr>
           
        </table>
    </div>
  	 <div class="tab" >
     	<ul class="tab_ul clearfix">
        	<li class="on" id="product" class="on" ><a href="javascript:void(0)" >众筹商品</a></li>
            <li id= "description"><a href="javascript:void(0)">众筹情况</a></li>
        </ul>
         <!--众筹情况-->
        <div class="zc-qk" style="display:none">
        	<c:forEach var="orderPayList" items="${orderPayList }">
        		<table cellpadding="0" cellspacing="0" width="100%">
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
	                        <p>还差<span class="c-red m-l"><fmt:formatNumber value="${(orderPayList.order.payment_price - orderPayList.order.payment_type)/100}" type="currency" pattern="￥0.00" /></span>元</p>
	                    </td>
	                </tr>
	            </table>
        	</c:forEach>
        	<c:if test="${empty orderPayList}">
            	<div  style="text-align: center;margin-top: 20px;">暂无好友赞助</div>
            </c:if>
        </div>
        
     </div> 
     <!--众筹商品--> 
   <div class="zq-img"  >
       <!-- <div class="new-shoop">
            CK新品上市，快打赞助我把，需要你们的时候到了
         </div>  --> 
          <div class="zc-shoop">
               ${prod.long_description}
                    
          </div>
  </div> 
    <jsp:include page="/foot.jsp" />
</body>
</html>
