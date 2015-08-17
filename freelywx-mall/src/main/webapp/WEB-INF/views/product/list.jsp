<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
<meta content="telephone=no" name="format-detection"/>
<title>智能穿戴商城</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript">
	$(function() {
		var count = $(".tab_ul a").length;
		$(".tab_ul  a").click(function() {
			for (var i = 0; i < count; i++) {
				$(".tab_ul a").removeClass("a_hover_bj");
			}
			$(this).addClass("a_hover_bj");
		});
		$(".shoop:last").css("border", "0");
		
		$('#mallA').click(function(){
			location.href = "${ctx}/";
		});
		$('#tribeA').click(function(){
			location.href = "${ctx}/tribe";
		});
		
		var lock = false;
		window.scrollTo(0, 0);
		pageTTT();
		function pageTTT() {
			$.post("${ctx}/pageProd", {
				"pageIndex" : $('#pageIndex').val() * 1 + 1
			}, function(text) {
				$('.list').append(text);
				lock = true;
			});
		}

		new NeuF.ScrollPage(window, function(offset) {
			if (offset > 0) {
				if(lock){
					lock = false;
					setTimeout(function() {
						var pageIndex = $('#pageIndex').val() * 1 + 1;
						var pageTotal = $('#pageTotal').val() * 1 + 1;
						if (pageIndex < pageTotal) {
							pageTTT();
						}
					}, 1000);
				}
			}
		});
	});
</script>
</head>

<body>
	<input type="hidden" value="-1" id="pageIndex" />
	<input type="hidden" value="0" id="pageTotal" />
	
<div class="tab_ul clearfix">
    <div class="w_half"><div class="b_r"><a href="javascript:void(0)" class="a_hover_bj" id="mallA"><span class="span">智能穿戴商城</span></a></div></div>
    <div class="w_half"><a href="javascript:void(0)" id="tribeA"><span>社区</span></a></div> 	
</div>

<c:if test="${not empty advertise.pic_url}">
	<ul><li><a href="${advertise.link_url}"><img src="${advertise.pic_url}" width="100%" /></a></li></ul>
	<div class="introduce">${advertise.desciption}</div>
</c:if>

<div class="list"></div>

<jsp:include page="/foot.jsp" />
</body>
</html>
