<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="res" value="${ctx}/static" />
<c:set var="css" value="${res}/css" />
<c:set var="img" value="${res}/images" />
<c:set var="js" value="${res}/js" />

<script type="text/javascript" src="${js}/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${js}/JSUtil.js"></script> 

<script type="text/javascript" src="${js}/JSBridge.js"></script>
<script type="text/javascript">
	var serverurl = "120.24.73.10";
	var href = encodeURIComponent(window.location.href);
	var text = "Mobile Fun " + document.title;
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
		share(appId, MsgImg, TLImg, url, title, desc, fakeid, openId);
	});

</script>