<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta name="HandheldFriendly" content="true">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta name="description" content="">

<title>8小时咖啡</title>

<script type="text/javascript" src="resource/jquery-2.js"></script>
<script type="text/javascript" src="resource/spin.js"></script><style type="text/css"></style>
<script type="text/javascript" src="resource/jquery.js"></script>
<script type="text/javascript" src="resource/myloading.js"></script>
<script type="text/javascript" src="resource/common.js"></script>
<script type="text/javascript"></script>
<script type="text/javascript">
  var userInfo = sessionStorage.userInfo;
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
  }
</script>
        <title>账户余额</title>
        <link href="resource/common.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="resource/fastclick.js"></script>
        <script type="text/javascript" src="resource/layer.js"></script><link id="layermcss" rel="styleSheet" type="text/css" href="resource/layer.css">
        <script src="resource/jweixin-1.js"></script>
    </head>

    <body>
        <section class="csBody" style="height: 9.5em;margin-bottom: 1.7em;position: relative;">
            <div class="acctMoney">
                <p>￥<b style="font-weight: normal; font-size: 56px;" id="remainAmount">0</b></p>
                <label>目前您的账户余额</label>
                <img src="resource/pic_money.png">
            </div>
        </section>

        <section class="csRow">
            <div style="cursor:pointer;" id="amountselector">
                <span class="cslblName">充值金额</span>
                <span class="cslblValue"><b id="amountvalue" style="font-weight:normal;">100</b>元</span>
                <img class="csAray" src="resource/ico_arr.png">
            </div>
        </section>

        <section class="csBody" style="display:none;">
            <div class="csTitle">
                <img src="resource/ico_wx.png">
                <span>支付方式</span>    
            </div>
            <div class="csBody">
                <ul>
                    <li style="font-size: 1.3em;height: 2.7em; line-height: 2.7em; position: relative">
                        <img src="resource/wx.png" style="height: 1.7em;padding-left: 0.4em;padding-top: 0.5em;margin-right: 0.5em;">
                        <span style="position: absolute; bottom: 0.05em;">微信支付</span>
                        <div class="radioselector_div">
                            <img src="resource/ico_check.png">
                            <input id="paytype_selector" value="" checked="checked" style="display:none;" type="radio">
                        </div>
                    </li>
                </ul>    
            </div>
        </section>
        
        <div class="o_btn clearfix">
            <input class="o_btn_red" value="确认充值" id="submitBtn" style="width:100%;margin-top:20px;cursor:pointer;" type="button">
        </div>

        <script>
	        var jsapiParams = "";
	        var order_code = "";
	        
            $(function(){
            	FastClick.attach(document.body);
                bindEvent();
                initData();
            });
    
            function initData() {
                getUserInfoByAccount();
            }
    
            function bindEvent() {
                $("#submitBtn").click(function(){
                    var amount = $.trim($("#amountvalue").html());
                    recharge(parseInt(amount));
                });
                
                $("#amountselector").click(function(){
                    var currVal = $.trim($("#amountvalue").html());
                    var amount_arr = new Array("50","100","200");
                    var htmlstr = "";
                    var width = "300px";
                    var height = "auto";
                    
                    htmlstr += "<section style='width:"+width+";height:"+height+";overflow-y:scroll;'>";
                    htmlstr += "  <div class='csBody' style='height:"+height+";min-height:200px;'>";
                    htmlstr += "    <ul>";
                    for(var i=0; i< amount_arr.length; i++) {
                        htmlstr += "  <li style='position:relative; width:100%;margin:0px;border-bottom:solid 1px #f7f7f7;' name='amountitem' amountval='"+amount_arr[i]+"'>";
                        htmlstr += "    <label style='color:#313131;width:100%;float:left;cursor:pointer;text-align:left;padding-left:20px;'>"+amount_arr[i]+"元</label>";
                        htmlstr += "    <div class='radioselector_div' style='padding-right:20px;'>";
                        if(currVal == amount_arr[i]) {
                            htmlstr += "      <img src='/wx/Addons/CoffeeStore/View/default/Public/icons/ui/ico_check.png'/>";
                        } else {
                            htmlstr += "      <img src='/wx/Addons/CoffeeStore/View/default/Public/icons/ui/ico_nor.png'/>";
                        }
                        htmlstr += "    </div>";
                        htmlstr += "  <div style='clear:both;'></div></li>";
                    }
                    htmlstr += "    <div style='clear:both;'></div></ul>";
                    htmlstr += "  <div style='clear:both;'></div></div>";
                    htmlstr += "</section>";
                    
                    var pagei = layer.open({
                        //1代表页面层
                        type: 1, 
                        content: htmlstr,
                        style: 'width:'+width+'; height:'+height+';',
                        success: function(olayer){
                            $("ul li[name='amountitem']").click(function(){
                                $("#amountvalue").html($(this).attr("amountval"));
                                layer.close(pagei);
                            });
                        }
                    });
                });
            }
    
            function recharge(amount) {
                //获取用户信息
                var userInfo = sessionStorage.userInfo;
                if(userInfo != undefined) {
                    userInfo = $.parseJSON(userInfo);
                    var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/rechargeforuser.html";
                    var data = {};
                    data.user_id = userInfo.user_id;
                    data.amount = amount;
                    
                    _postAjax(url,data,function(result){
                        if(result) {
                            result = $.parseJSON(result);
                           // 成功是0 非0是失败
                            if(result.ret_code == "0") {
                            	doWxPay(result.order_code);
                            } else if(result.ret_code == "1"){
                                showTip(result.ret_info,"body");
                                return false;
                            } else if(result.ret_code == "2") {
                                showTip("登录信息无效，请重新登录","body");
                                navigateTo("myaccount","login");
                                return false;
                            } else {
                                showTip("充值失败，请重试","body");
                                return false;
                            }
                            
                        } else {
                            showTip("充值失败","body");
                            return false;
                        }
                    },function(result){
                        //出错时
                        showTip("充值失败","body");
                        return false;
                    });
                    
                }
            }
            
            function getUserInfoByAccount() {
                var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/getuserinfo.html";
                var userInfo = sessionStorage.userInfo;
                
                if(userInfo == undefined) {
                	showTip("你还没有登录，请先登录","body");
                    navigateTo("myaccount","login");
                    return false;
                }
                
                userInfo = $.parseJSON(userInfo);
                
                _postAjax(url,userInfo,function(result){
                    if(result) {
                        result = $.parseJSON(result);
                       // 成功是0 非0是失败
                        if(result.ret_code == "0") {
                            $("#remainAmount").html(result.user.remain_amount).css('font-size', '56px');
                        } else if(result.ret_code == "1"){
                            alert(result.ret_info);
                            return false;
                        } else if(result.ret_code == "2") {
                            showTip("登录信息无效，请重新登录","body");
                            navigateTo("myaccount","login");
                            return false;
                        } else {
                            showTip("用户信息获取失败，请重试","body");
                            return false;
                        }
                        
                    } else {
                        showTip("用户信息获取失败","body");
                        return false;
                    }
                },function(result){
                    //出错时
                    showTip("用户信息获取失败","body");
                    return false;
                });
            }
            
            //微信支付
            function doWxPay(orderCode) {
                var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/getjsapiparams.html";
                var data = {};
                data.order_code = orderCode;
                
                _postAjax(url,data,function(result){
                    if(result) {
                        result = $.parseJSON(result);
                        if(result.ret_code == "0") {
                            jsapiParams = $.parseJSON(result.jsApiParameters);
                            order_code = orderCode;
                            callpay();
                        } else if(result.ret_code == "1") {
                            showTip(result.ret_info,"body");
                            return false;
                        } else if(result.ret_code == "2"){
                            showTip("登录信息无效，请重新登录","body");
                            navigateTo("orderform","login");
                            return false;
                        } else {
                            showTip("微信支付失败","body");
                            return false;
                        }
                    } else {
                        showTip("微信支付失败","body");
                        return false;
                    }
                });
            }
            
            //微信支付成功后的处理逻辑
            function wxPaySuccessFn() {
                var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/checkOrderPayStatus.html";
                var params = {};
                params.order_code = order_code;

                _postAjax(url,params,function(result){
                    if(result) {
                        result = $.parseJSON(result);
                        // 成功是0 非0是失败
                        if(result.ret_code == "0") {
                            //var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/mypage.html";
                            //充值支付成功
                            jsapiParams = "";
                            order_code = "";
                            //window.location.href = url;
                            navigateTo("myaccount","mypage");
                        } else if(result.ret_code == "1") {
                            showTip(result.ret_info,"body");
                            return false;
                        } else if(result.ret_code == "2") {
                            showTip("登录信息无效，请重新登录","body");
                            navigateTo("myaccount","login");
                            return false;
                        } else {
                            showTip("充值失败，请重试","body");
                            navigateTo("myaccount","mypage");
                            return false;
                        }
                    } else {
                        showTip("充值失败，请重试","body");
                        navigateTo("myaccount","mypage");
                        return false;
                    }
                });
            }
            
            //调用微信JS api 支付
            function jsApiCall(){
                WeixinJSBridge.invoke(
                    'getBrandWCPayRequest',
                    jsapiParams,
                    function(res){
                        WeixinJSBridge.log(res.err_msg);
                        
                        url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/mypage.html";
                        if(res.err_msg != "get_brand_wcpay_request:ok") {
                            if(res.err_msg != "get_brand_wcpay_request:cancel") {
                                //充值失败或取消充值时，需要删除订单
                                var removeurl = "./index.php?s=/addon/CoffeeStore/CoffeeStore/removeorder.html";
                                var removeparam = {};
                                removeparam.order_code = order_code;

                                _postAjax(removeurl,removeparam,function(result){
                                    if(result) {
                                        result = $.parseJSON(result);

                                       // 成功是0 非0是失败
                                        if(result.ret_code == "0") {
                                            window.location.href = url;
                                        } else if(result.ret_code == "1") {
                                            showTip(result.ret_info,"body");
                                            return false;
                                        } else if(result.ret_code == "2") {
                                            showTip("登录信息无效，请重新登录","body");
                                            navigateTo("myaccount","login");
                                            return false;
                                        } else {
                                            showTip("订单删除失败","body");
                                            return false;
                                        }
                                    } else {
                                        showTip("订单删除失败","body");
                                        return false;
                                    }
                                });
                            } else {
                                //取消支付时，停留在原页面
                                //do nothing
                            }
                        } else {
                            //充值支付成功
                            wxPaySuccessFn();
                        }
                    }
                );
            }

            function callpay(){
                if (typeof WeixinJSBridge == "undefined"){
                    if( document.addEventListener ){
                        document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
                    }else if (document.attachEvent){
                        document.attachEvent('WeixinJSBridgeReady', jsApiCall); 
                        document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
                    }
                }else{
                    jsApiCall();
                }
            }
          
          
        </script>
    
</body></html>