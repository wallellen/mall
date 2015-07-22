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
  /**var userInfo = sessionStorage.userInfo;
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
  } **/
</script>
        <title>登录</title>
        <link href="resource/common.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="resource/login.js"></script>
        <style>
            
        </style>
    </head>
    <body style="font-size:12px;">
        <form>
          <section>
            <div class="csTitle" id="noticeinfo">
              <span style="color:#f18f28;">为了确保咖啡的准时送达，需要验证您的手机号</span>
            </div>
            <div class="csBody">
              <ul>
                <li style="position:relative">
                  <input placeholder="请输入您的手机号码" id="tel" name="tel" style="position:absolute;top:7px;left:10px;right:130px;" type="tel">
                  <input class="o_btn_org ts1" value="发送验证码" style="width:100px;padding-left:12px;border-left:solid 1px #DADADA;margin-top:13px;height:20px;" id="sendBtn" type="button">
                  <input class="o_btn_grey ts1" value="重新发送(45)" style="width:100px;padding-left:12px;border-left:solid 1px #DADADA;margin-top:13px;height:20px;display:none" id="resendBtn" type="button">
                </li>
                <li class="nobottom">
                  <input placeholder="请输入您收到的验证码" style="width:100%" id="validcode" name="validcode" type="tel">
                </li>
              </ul>
            </div>
          </section>
        </form>
        
        <div class="o_btn clearfix">
          <input class="o_btn_yellow ts1" value="确认" style="width:100%;margin-top:20px;" id="submitBtn" type="button">
          <div style="clear:both"></div>
        </div>
    
    <script type="text/javascript">
      $('#tel').keyup(function() {
        if ($(this).val().length == 11) {
          if ($('#sendBtn').is(":visible") == true) {
            $(this).blur();
            $('#sendBtn').click();
          }
        }
      });
    </script>
</body></html>