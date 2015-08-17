var dataForWeixin;
function share(appId, MsgImg, TLImg, url, title, desc, fakeid, openId) {
	dataForWeixin = {
		appId : appId,
		MsgImg : MsgImg,
		TLImg : TLImg,
		url : url,
		title : title,
		desc : desc,
		fakeid : fakeid,
		openId : openId,
		callback : function(type,res) {
			if(type == 1){
				if(res && (res.err_msg == 'send_app_msg:ok' || res.err_msg == 'send_app_msg:confirm'))
					shareVisit(type,1);
			}else if(type == 2 ){
				if(res && (res.err_msg == 'share_timeline:ok' || res.err_msg == 'share_timeline:confirm'))
					shareVisit(type,1);
			}
		}
	};
}

function shareVisit(s_type,type){
	$.post("http://"+serverurl+"/wxmall/visit/share",{
		"s_type" : s_type,
		"type" : type,
		"url" : dataForWeixin.url
	},function(text){
		
	});
}

(function () {
    var onBridgeReady = function () {
    	// 发送给好友
        WeixinJSBridge.on('menu:share:appmessage', function (argv) {
            WeixinJSBridge.invoke('sendAppMessage', {
                "appid": dataForWeixin.appId,
                "img_url": dataForWeixin.MsgImg,
                "img_width": "640",
                "img_height": "640",
                "link": dataForWeixin.url,
                "desc": dataForWeixin.desc,
                "title": dataForWeixin.title 
            }, function (res) { 
            	(dataForWeixin.callback)(1,res);
            });
        });
        // 分享到朋友圈
        WeixinJSBridge.on('menu:share:timeline', function (argv) {
            WeixinJSBridge.invoke('shareTimeline', {
                "img_url": dataForWeixin.TLImg,
                "img_width": "640",
                "img_height": "640",
                "link": dataForWeixin.url,
                "desc": dataForWeixin.desc,
                "title": dataForWeixin.title 
            }, function (res) {
            	(dataForWeixin.callback)(2,res);
            });
        });
        // 分享到微博
        WeixinJSBridge.on('menu:share:weibo', function (argv) { // 分享到成功后微博
            WeixinJSBridge.invoke('shareWeibo', {
                "content": dataForWeixin.title ,
                "url": dataForWeixin.url
            }, function (res) { 
            	(dataForWeixin.callback)(3,res);
            });
        });
        // 分享到facebook
        WeixinJSBridge.on('menu:share:facebook', function (argv) {
            WeixinJSBridge.invoke('shareFB', {
                "img_url": dataForWeixin.TLImg,
                "img_width": "120",
                "img_height": "120",
                "link": dataForWeixin.url,
                "desc": dataForWeixin.desc,
                "title": dataForWeixin.title 
            }, function (res) { 
            	(dataForWeixin.callback)(4,res);
            });
        });
    };
    if (document.addEventListener) {
        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
    } else if (document.attachEvent) {
        document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
    }
})();
