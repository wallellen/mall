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
        <script type="text/javascript" src="resource/fastclick.js"></script>
        <title>我的兑换券</title>
        <link href="resource/common.css" rel="stylesheet" type="text/css">
        <style>
            .licls {border:solid 1px #dfdfdf;margin:20px;cursor:pointer;color:#7c7c7c;position:relative;}
            .status_img {position:absolute;top:10px;right:15px;width:50%;height:auto;max-height:100%;}
        </style>
        <script type="text/javascript">
            $(function(){
            	FastClick.attach(document.body);
            	
            	var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/getuserconpons.html";
                var params = {};
                var userInfo = sessionStorage.userInfo;
                userInfo = $.parseJSON(userInfo);
                params.user_id = userInfo.user_id;
                
                _postAjax(url,params,function(result){
                    if(result) {
                        result = $.parseJSON(result);
                        // 成功是0 非0是失败
                        if(result.ret_code == "0") {
                            var htmlstr = "";
                            
                            if(result.ret_info && result.ret_info.length > 0) {
                            	for(var i=0; i<result.ret_info.length;i++) {
                                    var cObj = result.ret_info[i];
                                    htmlstr += "<li class='licls'>";
                                    if(cObj.status == "1") {
                                        htmlstr += "  <p style='margin-bottom:10px;'><img src='/wx/Addons/CoffeeStore/View/default/Public/icons/ui/img_voucher_fifteen_out.png' style='width:100%;height:auto;'/></p>";
                                    } else {
                                        htmlstr += "  <p style='margin-bottom:10px;'><img src='/wx/Addons/CoffeeStore/View/default/Public/icons/ui/img_voucher_fifteen.png' style='width:100%;height:auto;'/></p>";
                                    }
                                    
                                    htmlstr += "  <div style='padding-left:15px;font-size:12px;padding-bottom:10px;'>";
                                    htmlstr += "    <p><span>兑换券编号：</span><span>"+cObj.coupon_code+"</span></p>";
                                    htmlstr += "    <p><span>使用范围：</span><span>任何8hcoffee水吧台</span></p>";
                                    htmlstr += "    <p><span>使用期限：</span><span>"+formatCouponDate(cObj.end_date)+"</span></p>";
                                    htmlstr += "  </div>";
                                    if(cObj.status == "1") {
                                        htmlstr += "  <img src='/wx/Addons/CoffeeStore/View/default/Public/icons/ui/ico_invalid.png' class='status_img'/>";
                                    }
                                    htmlstr += "</li>";
                                }
                            } else {
                            	htmlstr += "<li>";
                            	htmlstr += "<div style='width:80%;text-align:center;margin-left:10%;margin-top:30%;'>";
                                htmlstr += "    <img style='width:100px;height:100px;' src='/wx/Addons/CoffeeStore/View/default/Public/icons/ui/pic_coupon_nothing.png'/>";
                                htmlstr += "    <div style='color:#656565;font-size:14px;margin-top:20px;margin-bottom:50px;'>";
                                htmlstr += "        <p>现在您还没有兑换券</p>";
                                htmlstr += "        <p>请关注8hcoffee线上活动获取兑换券</p>";
                                htmlstr += "    </div>";
                                htmlstr += "</div>";
                                htmlstr += "</li>";
                            }
                            
                            $("#couponslist").html(htmlstr);
                        } else {
                            alert("兑换券获取失败，请重试");
                            return false;
                        }
                    } else {
                        alert("兑换券获取失败，请重试");
                        return false;
                    }
                });
            });
        </script>
    </head>
    <body>
      <section>
        <ul id="couponslist"><li><div style="width:80%;text-align:center;margin-left:10%;margin-top:30%;">    <img style="width:100px;height:100px;" src="resource/pic_coupon_nothing.png">    <div style="color:#656565;font-size:14px;margin-top:20px;margin-bottom:50px;">        <p>现在您还没有兑换券</p>        <p>请关注8hcoffee线上活动获取兑换券</p>    </div></div></li></ul>
      </section>
    
</body></html>