<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta content="telephone=no" name="format-detection" />
<title>我的记录查询</title>
<link type="text/css" rel="stylesheet" href="${css}/zc2.css" />
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
	function go(num,sum){ 
		if(num == null || num == ""){
			num = 0;
		}
		if(sum == null || sum == ""){
			sum = 0;
		}
		
		var percent= (num/sum).toFixed(2);
	 	if (  percent > 0 && percent < 0.03){
			percent = 0.03;
		} 
	    var tempwidth = $("#bar").width();
	   // alert(tempwidth);
	    if (null == tempwidth || "" == tempwidth){
	    	 
	    	tempwidth= document.body.clientWidth;
	    }
	    var showWidth = 0;
	    if (0 != percent){
	    	showWidth = parseInt(tempwidth * percent) ; 
	    }
	    return showWidth ;
	} 
	
	//加载我的众筹信息
	/* $.post("${ctx}/raise/getCrowdOrder", function (result){
		if (result){
			var html = "";
			html += "<div class=\"shoop-je\"> ";
			html += " <input type=\"hidden\" name=\"oid\" value=\"";
			html += result[0].order_id ;
			html += " \" />";
			html += "<div class=\"shoop-title\">";
			html += result[0].prodList[0].prod_name;
			html +="</div><p class=\"form-time\">发起时间："+result[0].create_time+"</p>";
			html +="<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"mar-top\">";
			html +="<tr> <td><div  style=\"position:relative; height:45px;\">";
			html +="<span id=\"bar\" style=\"width:100%; height:20px; background:#e5e5e5; border-radius:10px; display:inline-block\"></span> ";
			html +="<span  style=\" position:absolute; left:0px;height:19px;top:0px; z-index:5; width:20%; background:url(${img}/bar_m.png) repeat-x; background-size:20px 20px; border-top-left-radius:15px;border-bottom-left-radius:15px;border-top-right-radius:15px;border-bottom-right-radius:15px;\"></span>";
			html +="<span style=\"position:absolute;left:20%;padding:1px 10px;text-align:center; background-size:10px 8px; font-size:12px; color:#4ac3d3; min-width:48px; text-align:center; margin-left:-34px;\">";
			html +="<img src=\"${img}/jiao-img.png\" width=\"10\" height=\"8\" /><br />25091</span>	";
			html +="</div></td><td class=\"tool-price\">148.00</td></tr></table>";
			$(".shoop-table").append(html);
		} 
	}); */
	$.post("${ctx}/raise/getCrowdPay", function (result){
		if (result && result.length > 0){
			 var html = "<div class=\"public\" style=\"border-collapse:separate; border-spacing:10px;\"><table cellpadding=\"0\"  cellspacing=\"0\" width=\"100%\">";
			 for(var i =0 ;i< result.length;i++){
				 var imgUrl = result[i].member.member_img;
				 if(imgUrl == "" || imgUrl == null  ){
					 imgUrl = "${img}/grzx2.png";
				 }
				 var pic = "${server}" + result[i].order.prodList[0].picList[0].pic_url;
				 var crowdTotal = (result[i].pay_amount/100).toFixed(2);
				 if(i==0){
					 html += "<tr><td width=\"110\"><img src=\""
				 }else{
					 html += "<tr height=\"160\" style=\"padding-top:25px\"><td width=\"110\"><img src=\""
				 }
				
				 html += pic;
				 html +=" \" width=\"100\" height=\"100\" /><p class=\"my-give\"><nobr>我赞助了<span>￥"+crowdTotal+"</span></nobr></p></td>";
				 html +=" <td style=\"padding-left:10px;\"><div class=\"shoop-user-name\"><img src=\" "+imgUrl+"\" width=\"25\" height=\"25\" />";
				 html += result[i].member.member_name;
				 html += "</div><div class=\"shoop-title\">";
				 html += result[i].order.prodList[0].prod_name;
				 var arr = result[i].order.create_time.split(" ");
				 var dArr = arr[0].split("-");
				 var str = dArr[0]+"年"+dArr[1]+"月"+dArr[2]+"日";
				 html += "</div><div class=\"fy-time\" >发起时间："+str+"</div>";
				 var payed = result[i].order.payed_amount ;
				 if(payed && payed == null  &&  payed == ""){
					 payed = (payed/100).toFixed(2);
				 }else{
					 payed = 0;
				 }
				 var width = go(payed,result[i].order.payment_price);
				 html +="<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"mar-top\">";
				 html +="<tr> <td><div  style=\"position:relative; height:45px;\">";
				 html +="<span   style=\"width:100%; height:20px; background:#e5e5e5; border-radius:10px; display:inline-block\"></span> ";
				 html +="<span  style=\" position:absolute; left:0px;height:19px;top:0px; z-index:5; width:"+width+"px; background:url(${img}/bar_m.png) repeat-x; background-size:20px 20px; border-top-left-radius:15px;border-bottom-left-radius:15px;border-top-right-radius:15px;border-bottom-right-radius:15px;\"></span>";
				 html +="<span style=\"position:absolute;left:"+width+"px;padding:1px 10px;text-align:center; background-size:10px 8px; font-size:12px; color:#4ac3d3; min-width:48px; text-align:center; margin-left:-34px;\">";
				 html +="<img src=\"${img}/jiao-img.png\" width=\"10\" height=\"8\" /><br />"+payed+"</span>	";
				 //html +="<span style=\"display:inline-block; width:15px; padding-left:5px; position:absolute; left:0px; bottom:10px; height:15px;\"/>0</span>	";
				 html +="</div></td><td class=\"tool-price\">"+(result[i].order.payment_price/100).toFixed(2)+"</td></tr></table></td></tr>";
			 }
			 html += " </table></div>";
			 $(".my-fireds").append(html);
		}else{
			var html = " <div class=\"no_public\">	还没有哦！</div> ";
			$(".my-fireds").append(html);
		}
	});
	
	$('.shoop-je').live("click",function() {
		var oid = $(this).children("input[name='oid']").val();
		location.href = "${ctx}/raise/detail?order_id="+oid;
	});

	$('.public').live("click",function() {
		var oid = $(this).children("input[name='oid']").val();
		var mid = $(this).children("input[name='mid']").val();
		location.href = "${ctx}/raise/detail?order_id=" + oid	+ "&share=" + mid;			
	});
	
	function processMyCrowd(){
		var width = go(${order.payed_amount},${order.payment_price});
		$("#pay_img").css("width",width);
		$("#bar_payed").css("left",width);
		$("#bar_payed").append('<fmt:formatNumber value="${order.payed_amount/100 }" type="currency" pattern="0.00"/>');
	}

</script>
</head>
<body class="body-bj">
	<div class="my-from">
    	我发起的众筹
    </div>
   <c:if test="${!orderFlag}">
	<div class="no-fq">
		 <div class="shoop-table">
		    <div  class="you-name">
		               你还没发起众筹哦！
		    </div>
		    <div  class="me-from">
		       <a href="${ctx}/raise">我来发起</a>
		    </div>
		 </div>
	</div>
   </c:if>
   <c:if test="${orderFlag}">
   	<div class="shoop">
    	<div class="shoop-table">
        	<div class="shoop-img">
                <c:if test="${empty member.member_img}"><img src="${img}/grzx2.png"  width="110" height="110"/></c:if>
				<c:if test="${not empty member.member_img}"><img src="${member.member_img}"  width="110" height="110"/></c:if>
            </div>	
            <div class="shoop-je">
            	<div class="shoop-title">${order.prodList[0].prod_name}</div>
                <p class="form-time">发起时间：2014年10月2日</p>
                <table cellpadding="0" cellspacing="0" width="100%" class="mar-top">
                	<tr>
                        <td>
						<div  style="position:relative; height:45px;">                	
                    		<%-- <span id="bar" style="width:100%; height:20px; background:#e5e5e5; border-radius:10px; display:inline-block"></span>                        
							<span id="pay_img" style=" position:absolute; width:20%;  height:19px;top:0px; z-index:5;   background:url(${img}/bar_m.png) repeat-x; background-size:20px 20px; border-top-left-radius:15px;border-bottom-left-radius:15px;border-top-right-radius:15px;border-bottom-right-radius:15px;"></span>                       
							<span id="bar_payed" style="position:absolute;padding:1px 10px;text-align:center; background-size:10px 8px; font-size:12px; color:#4ac3d3; min-width:48px; text-align:center; margin-left:-34px;">
							<img src="${img}/jiao-img.png" width="10" height="8" /><br /></span>	                        		
                          <span style="display:inline-block; width:15px; padding-left:5px; position:absolute; left:0px; bottom:10px; height:15px;">0</span>                
						</div></td>
                          <td class="tool-price" id="total_amount"><fmt:formatNumber value="${order.payment_price/100 }" type="currency" pattern="0.00"/></td> --%>
                          <span id="bar" style="width:100%; height:20px; background:#e5e5e5; border-radius:10px; display:inline-block"></span>                        
							<span id="pay_img" style=" position:absolute; left:0px;height:19px;top:0px; z-index:5; width:0px; background:url(${img}/bar_m.png) repeat-x; background-size:20px 20px; border-top-left-radius:15px;border-bottom-left-radius:15px;border-top-right-radius:15px;border-bottom-right-radius:15px;"></span>                       
							<span id="bar_payed" style="position:absolute;left:0px;padding:1px 10px;text-align:center; background-size:10px 8px; font-size:12px; color:#4ac3d3; min-width:48px; text-align:center; margin-left:-34px;">
							<img src="${img}/jiao-img.png" width="10" height="8" /><br /> 0</span>	                        		
                        <span style="display:inline-block; width:15px; padding-left:5px; position:absolute; left:0px; bottom:10px; height:15px;"> </span>              
						</div></td>
                          <td class="tool-price"><fmt:formatNumber value="${order.payment_price/100 }" type="currency" pattern="0.00"/></td>
                    </tr>
                </table> 
            </div>
        </div>
    </div>
	</c:if>

 	<div class="my-fireds">
    		<div class="my-f-t">
            	我赞助的朋友
            </div>
    </div>
    
    
    
	<!--我要做微商-->
	<div class="press">
		<a href="${ctx}/raise/join" class="bj-blue">我要做微商</a>
	</div>

	<jsp:include page="/foot.jsp" />
	<script type="text/javascript">
	processMyCrowd();
	</script>
</body>

</html>