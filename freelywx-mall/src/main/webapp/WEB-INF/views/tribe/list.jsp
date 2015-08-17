<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta name="format-detection" content="telephone=no" />
<title></title>
<link type="text/css" rel="stylesheet" href="${css}/public.css" />
<script type="text/javascript">
	$(function() {
		var type = "${type}";

		var lock = false;
		window.scrollTo(0, 0);
		pageTTT();
		function pageTTT() {
			$.post("${ctx}/tribe/pageMy", {
				"pageIndex" : $('#pageIndex').val() * 1 + 1,
				"type" : type
			}, function(text) {
				$('.talk_bj').append(text);
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
	})
</script>
</head>

<body class="body_bj">
	<input type="hidden" value="-1" id="pageIndex" />
	<input type="hidden" value="0" id="pageTotal" />
	
	<div class="tab_ul ds_list">话题列表
		<a href="javascript:history.go(-1)" class="back_page"><img src="${img}/back.png" width="16" height="25"/></a> 
	</div>
	
	<div class="talk_padding">
		<div class="talk_bj"></div>
	</div>
	
<jsp:include page="/foot.jsp" />
</body>
</html>
