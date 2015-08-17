<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
<meta content="telephone=no" name="format-detection" />
<title>社区</title>
<link type="text/css" href="${css}/public.css" rel="stylesheet" />
<script type="text/javascript">
	$(function() {
		var count = $(".tab_ul a").length;
		$(".tab_ul  a").click(function() {
			for ( var i = 0; i < count; i++) {
				$(".tab_ul a").removeClass("a_hover_bj");
			}
			$(this).addClass("a_hover_bj");
		});
		$(".shoop:last").css("border", "0");

		$('.mallA').click(function() {
			location.href = "${ctx}/";
		});
		$('.tribeA').click(function() {
			location.href = "${ctx}/tribe";
		});
		$('.addA').click(function() {
			location.href = "${ctx}/tribe/add?is_band=2";
		});
		$('.upA').click(function() {
			goTop();
		});

		var lock = false;
		window.scrollTo(0, 0);
		pageTTT();
		function pageTTT() {
			$.post("${ctx}/tribe/pageTTT", {
				"pageIndex" : $('#pageIndex').val() * 1 + 1
			}, function(text) {
				$('#content').append(text);
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
		<div class="w_half">
			<div class="b_r">
				<a href="javascript:void(0)" class="mallA"><span class="span">智能穿戴商城</span></a>
			</div>
		</div>
		<div class="w_half">
			<a href="javascript:void(0)" class="a_hover_bj" class="tribeA"><span>社区</span></a>
		</div>
	</div>

	<div class="bottom_fixed" id="content"></div>

	<div class="s_bottom clearfix">
		<div class="update">
			<a href="javascript:void(0)" class="tribeA"><img src="${img}/update.jpg" width="26" height="26" /></a>
		</div>
		<div class="s_title">
			<a href="javascript:void(0)" class="addA"><img src="${img}/title.jpg" width="26" height="26" /><span>发表话题</span></a>
		</div>
		<div class="s_up">
			<a href="javascript:void(0)" class="upA"><img src="${img}/up.jpg" width="26" height="26" /></a>
		</div>
	</div>

<jsp:include page="/foot.jsp" />
</body>
</html>