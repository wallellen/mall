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
 <title>确认订单</title>
        <link href="${css}/common.css " rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${js}/fastclick.min.js"></script>
        <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
        <script type="text/javascript" src="${js}/orderform.js "></script>
        <style>
            .ui-page-theme-a a, html .ui-bar-a a, html .ui-body-a a, html body .ui-group-theme-a a {color:#333; font-weight:normal;}
            #prodwrapper{overflow:hidden;width:100%;height:69px;}
            #prodswitch{display:none;padding:6px;border-top:solid 1px #F7F7F7;border-bottom:dashed 1px #FE3E04;background:#FFFFFF;text-align:center;cursor:pointer;}
            #prodswitch span{height:0;width:0;display:inline-block;border:solid 5px #353535;border-width:8px 6px 0px 6px;border-color:#353535 #FFFFFF #FFFFFF #FFFFFF;margin-left:6px;}
            #prodswitch span.expand-style{border-width:0px 6px 8px 6px;border-color:#FFFFFF #FFFFFF #353535 #FFFFFF;}
        </style>
    </head>
    <body style="margin:0px;font-size:16px;">
        <input type="hidden" id="addonpath" value="/wx/Addons/CoffeeStore/View/default/Public"/>
        <form id='orderform'>
          <section style="margin-bottom:20px;">
            <div class="csBody">
              <ul>
                <li class="nobottom" id="psaddrlabel" style="height:auto;line-height:auto;padding-top:10px;padding-bottom:10px;postion:relative;">
                  <p style="min-height:21px;line-height:21px;">
                    <span style="margin-right:15px;" id="username"></span>
                    <span style="color:#3535353;" id="tel"></span>
                  </p>
                  <p style="min-height:21px;line-height:21px;">
                    <span style="margin-right:15px;">配送</span>
                    <span style="color:#3535353;" id="detail_location"></span>
                  </p>
                  <div id="chgdeliveryinfo" style="display:inline-block;position:absolute;right:0px;top:9px;float:right;margin-right:10px;width:80px;text-align:right;" >
                    <span style="height:auto;line-height:auto;color:#f09128;">修改</span>
                    <img src='${img }/ico_arr.png' style="height:18px;width:18px;vertical-align:text-bottom;"/>
                  </div>
                  <div style='clear:both'></div>
                </li>
                <li class="nobottom" id="zqaddrlabel" style="display:none;">
                    <span style="margin-right:20px;">自取</span>
                    <span style="color:#3535353;" id="siteaddrs"></span>
                </li>
              </ul>
            </div>
          </section>
          
          <section id="appointSec" style="margin:20px 0;display:none;">
            <div class="csBody">
              <ul>
                <li id="appointLi" style="padding-right:11px;">
                  <label id='appointLabel'></label>
                  <img src="${img }/ico_arr.png" style="height:18px;width:18px;margin-top:13px;float:right;"/>
                  <label id="appointBtn" style="float:right;margin-right:5px;color:#f09128;">预约</label>
                </li>
              </ul>
            </div>
          </section>
          
          <section>
            <div class="csBody" style="background-color:#ebebeb;">
              <div id="prodwrapper">
              <ul id="productslist" class="proList" style="background-color:#ffffff;"></ul>
              <ul id="promotionlist" class="proList" style="background-color:#ffffff;"></ul>
              </div>
              <div id="prodswitch" expanded="false"><font>显示全部</font><span></span></div>
              <ul id="totalAmountUL" class="proList" style="background-color:#ffffff;"></ul>
              <ul id="couponlist" class="proList" style="display:none;background-color:#ffffff;margin-bottom:30px;">
                <li class="nobottom" id="">
                  <a id="couponlistLink" style="color:#000000;display:block;padding-left:5px" rel="external" class="cslink addrselectLink">
                      <p style="color:#3c3c3c;width:40%;">兑换券</p>
                      <p style="color:#bcbcbc;width:50%;float:right;text-align:right;padding-right:20px;" id="couponlabel">使用特浓杯兑换券</p>
                      <img src="${img }/ico_arr.png"/>
                  </a>
                </li>
              </ul>
            </div>
          </section>
        </form>
        <div id="payBtnFooter">
        <div class="o_btn clearfix" style="margin-bottom:20px;">
            <input type="button" value="余额+微信支付" style="width:100%" class="o_btn_green" id="wxBtn"/>
            <div style="clear:both"></div>
        </div>
        
        <div class="o_btn clearfix">
            <input type="button" value="现金支付" style="width:100%" class="o_btn_orange" id="cashBtn"/>
            <div style="clear:both"></div>
        </div>
        </div>
    </body>
</html>