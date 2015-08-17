var serverurl = "120.24.73.10";
	var href = encodeURIComponent(window.location.href); 
	var text = "";
	text = "Mobile Fun " + document.title; 
	var appId = "";
	var MsgImg = "http://120.24.73.10/wxmall/static/images/fenxiang.png";
	var TLImg = "http://120.24.73.10/wxmall/static/images/fenxiang.png";
	var httpsUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf06e6587146f9056&redirect_uri=URL&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
	var url = httpsUrl.replace("URL",href);
	var title = text;
	var desc = text;
	var fakeid = "";
	var openId = "";
	
	$(function() {
		alert("2");
		share(appId, MsgImg, TLImg, url, title, desc, fakeid, openId);
	}