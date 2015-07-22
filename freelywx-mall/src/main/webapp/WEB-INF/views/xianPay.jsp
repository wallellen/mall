<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!DOCTYPE html>
<html class="ui-mobile">
<head>
<!-- base href="http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/orderlist.html&token=gh_afd96c055327&getOpenId=1" -->
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
	sessionStorage.userInfo = JSON
			.stringify({
				"id" : "3340",
				"account" : "18271812185",
				"social_account" : "\u4e00\u6487\u9633\u5149",
				"social_account_type" : "1",
				"name" : "\u4e00\u6487\u9633\u5149",
				"age" : null,
				"gender" : null,
				"qq" : null,
				"email" : null,
				"remain_amount" : "0",
				"status" : 1,
				"created" : "2015-07-08 22:32:58",
				"mytoken" : "enySJtjgb6G%lKl,bqno000oQvi9IDogIjE4MjcxODEyMTg1IiwgImlzc3VlZF9hdCIgOiAiMjAxNS0wNy0wOSAyMToxMzo0NyJ9",
				"user_id" : "3340"
			});
</script>
<script type="text/javascript">
	/* var userInfo = sessionStorage.userInfo;
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
	} */
</script>
<title>订单详情</title>
        <link href="${css}/common.css " rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${js}/layer.js"></script>
        <script type="text/javascript" src="${js}/fastclick.min.js "></script>
        <script type="text/javascript" src="${js}/orderdetailform.js "></script>
        <style>
          #payBtn {margin-top:5px;}
          #paid, #unpaid, #paid img {display:none}
          .layermbox1 .layermchild {border-radius:15px;background-color:#fffde4;}
        </style>
    </head>
    <body style="font-size:14px;">
        <!--主体-->
        <input type='hidden' id='uiIconPath' value='/wx/Addons/CoffeeStore/View/default/Public/icons/ui' />
        <form method="post" action="" onsubmit="return tgSubmit()">
          <section id="orderTracking">
            <div id="unpaid">
              <label class="fl">当前订单状态：</label><label id="orderStatus">未支付</label>
              <div class="fr b_btn_red" id="payBtn" style="line-height:20px;">去支付</div>
            </div>
            <div id="paid">
              <img src="${img}/bg_Process_step1.png" id="paidst1">
              <img src="${img}/bg_Process_step2.png" id="paidst2">
              <img src="${img}/bg_Process_step3.png" id="paidst3">
              <img src="${img}/bg_Process_step4.png" id="paidst4">
            </div>
          </section>
          <section>
            <div class="csTitle">
              <img src="${img}/ico_drinks.png"/>
              <span>饮品信息</span>
            </div>
            <div class="csBody">
              <ul id="productslist" class="proList">
                  
              </ul>
              
              <ul id="promotionlist" class="proList">
                
              </ul>
              
              <ul id="totalAmountUL" class="proList nobottom">
              
              </ul>
            </div>
          </section>
          
          <section id='evaluateSec' style='display:none;'>
            <div class="csTitle">
              <img src="${img}/ico_wx.png"/>
              <span>评价信息</span>
            </div>
            <div class="csBody">
              <ul class="proList nobottom" style='display:none;' id='hasEvaluationUl'>
                <li>
                  <span style='float:left;height:20px;line-height:20px;padding-top:1px;' id='stars'>
                    
                  </span>
                  <span style='border:solid 1px #fea03b;color:#fea03b;padding:0px 5px;height:20px;line-height:20px;margin-left:10px;float:left;' id='pointval'></span>
                  <label id="evaluateTime" style='float:right;height:20px;line-height:20px;'></label>
                  <div style='clear:both;'></div>
                </li>
                <li style='height:auto;' style='display:none;' id='evaComsLi'>
                  <div>
                    <label id='eva_comments'></label><br/>
                    <label style='display:none;' id='feedbacklbl'>
                      <b style='color:#fea03b;font-weight:normal;'>[小8哥回复]：</b>
                      <b style='color:#707070;font-weight:normal;' id='feedbackval'></b>
                    </label>
                  </div>
                </li>
              </ul>
              <ul class="proList nobottom" style='display:none;' id='noEvaluationUl'>
                <li>
                  <label style='float:left;'>您还未评价哦，立即去评价吧～</label>
                  <span style='border:solid 1px #fea03b;color:#fea03b;padding:0px 20px;float:right;height:27px;line-height:27px;' id='evaluateBtn'>去评价</span>
                  <div style='clear:both;'></div>
                </li>
              </ul>
            </div>
          </section>
          
          <section>
            <div class="csTitle">
              <img src="${img}/ico_collect.png"/>
              <span>收货信息</span>
            </div>
            <div class="csBody">
              <ul class="proList nobottom">
                <li>
                  <label>姓名：</label>
                  <label id="contact"></label>
                </li>
                <li>
                  <label>电话：</label>
                  <label id="phone"></label>
                </li>
                <li>
                  <label>地址：</label>
                  <label id="address"></label>
                </li>
                <li>
                  <label>&nbsp;&nbsp;&nbsp;&nbsp;</label>
                  <label id="address-2"></label>
                </li>
              </ul>
            </div>
          </section>
          
          <section>
            <div class="csTitle">
              <img src="${img}/ico_order.png"/>
              <span>订单信息</span>
            </div>
            <div class="csBody">
              <ul class="proList nobottom">
                <li>
                  <label>订单号码：</label>
                  <label id="ordercode"></label>
                </li>
                <li id="offlineorder" style="display:none">
                  <label>线下流水：</label>
                  <label id="offlineorderid"></label>
                </li>
                <li>
                  <label>订单日期：</label>
                  <label id="ordertime"></label>
                </li>
                <li style="display:none;" id="appointLi">
                  <label>预约送达：</label>
                  <label id="appointTime"></label>
                </li>
                <li>
                  <label>支付方式：</label>
                  <label id="paymenttype"></label>
                </li>
              </ul>
            </div>
          </section>
        </form>
    </body>
</html>