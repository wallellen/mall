<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport">
<meta content="telephone=no" name="format-detection">
<title>发表新话题</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css">
<link type="text/css" rel="stylesheet" href="${css}/zyUpload.css">
<script src="${js}/zyFile.js"></script>
<script src="${js}/zyUpload.js"></script>
<script src="${js}/zyFileInit.js"></script>
<script type="text/javascript">
	$(function() {

		$('#button').click(function() {
			var topic_title = $('#topic_title').val().trim();
			var topic_cont = $('#topic_cont').val().trim();
			if (topic_title == ""){
				alert("标题不可为空");
				return;
			}
			if (topic_cont == ""){
				alert("内容不可为空");
				return;
			}
			
			var imgNum = 0;
			imgNum = $("input[name='imgfile']").length;
			var imgUrl = "";
			$("input[name='imgfile']").each(function(){
				imgUrl = imgUrl + "," + $(this).val();
			})

			var is_band = "${is_band}";
			var prod_id = "${prod_id}";
			var is_show = $("#is_show").val();
			var xx = $("#lng").val();
			var yy = $("#lat").val();
			$.post("${ctx}/tribe/adding", {
				"topic_title" : topic_title,
				"topic_cont" : topic_cont,
				"is_band" : is_band,
				"prod_id" : prod_id,
				"is_show" : is_show,
				"xx" : xx,
				"yy" : yy,
				"imgNum" : imgNum,
				"imgUrl" : imgUrl,
			}, function(text) {
				if (text == -1){
					alert("已存在该商品的系统贴");
				}else if (text > 0 && text != "") {

					/* if($("input[name='imgfile']").length > 0){
						$("input[name='imgfile']").each(function(){
							$.post("${ctx}/tribe/bind", {
								"id" : text,
								"url" : $(this).val(),
							}, function(){
								
							})
						})
					} */
					
					//$('#topic_id').val(text);
					//$('.upload_btn').click();
					//alert("发表成功");
					$('#topic_title').val("");
					$('#topic_cont').val("");
					location.href = "${ctx}/tribe/get?id=" + text;
				}
			});
		});
		
		$('#topic_cont').keypress(function() {
			var max = 500;
			var val = $(this).val();
			if (val.length > max)
				$(this).val(val.substring(0, max))
		})

	});
</script>
</head>

<body>
<input type="hidden" id="is_show" value="2">
<input type="hidden" id="lng" value="0">
<input type="hidden" id="lat" value="0">
<input type="hidden" id="topic_id" value="0">

	<c:if test="${is_band==1}">
	<div class="buy_product">
        <div class="shoop_xq clearfix">
            <img src="${pic_url}" width="85" height="85" class="fl" />
            <div class="shoop_model">
                <p class="title_product" style="margin-top:0px;">${prod.prod_name}</p>
                <p>原价：<span><fmt:formatNumber value="${prod.retail_price/100}" type="currency" pattern="￥ 0.00"/></span></p>
                <p>酷魔方价：<span style="color:#e76d6f;"><fmt:formatNumber value="${prod.sale_price/100}" type="currency" pattern="￥ 0.00"/></span></p>
                <p>颜色：<c:if test="${empty colorArray}">无</c:if><c:if test="${not empty colorArray}"><c:forEach items="${colorArray}" var="color">${color}&nbsp;&nbsp;</c:forEach></c:if></p>
                <p>月销量：<span>${sCount}</span></p>
                <p>评论：<span>${tCount}</span></p>
            </div>
   		 </div>
    </div>
    </c:if>
    
	<div class="p_content">
		<div class="p_title">
			<input type="text" id="topic_title" placeholder="帖子标题" style="height: 30px;margin-bottom: 5px;font-size: 12px" maxlength="100">
			<textarea id="topic_cont" placeholder="发表一个新话题"></textarea>
		</div>
		<div class="p_file">
			<div id="demo" class="demo"></div>
			<div class="clear"></div>
			<p class="max_file">最多可上传4张照片<span style=" font-size: 12px">(大小:2M以下、格式:png jpg jpeg)</span></p>
		</div>
	</div>
	<div class="p_upload" style="text-align: right">
		<input type="button" value="发表" id="button">
	</div>
	<div class="p_address">
		<img src="${img}/address.png" width="18" height="24" /><span id="address">定位中...</span>
	</div>

	<script type="text/javascript">
		var lastLat = 0;
		var lastLong = 0;
		if (navigator.geolocation) {
			navigator.geolocation.watchPosition(success, error);
		}

		function success(position) {
			var latitude = position.coords.latitude;//纬度
			var longitude = position.coords.longitude;//经度
			var accuracy = position.coords.accuracy;//精度

			if(lastLat != latitude || lastLong != longitude){
				lastLat = latitude;
				lastLong = longitude;
				$.post("${ctx}/tribe/geolocation", {
					"lng" : longitude,
					"lat" : latitude
				}, function(text) {
					var obj = JSON.parse(text);
					$("#lng").val(obj.lng);
					$("#lat").val(obj.lat);
					$("#address").text(obj.address);
					$("#is_show").val("1");
				});
			}
		}

		function error(error) {
			$("#is_show").val("2");
			switch (error.code) {
			case 0:
				$("#address").text("尝试获取您的位置信息时发生错误");
				break;
			case 1:
				$("#address").text("用户拒绝了获取位置信息请求");
				break;
			case 2:
				$("#address").text("浏览器无法获取您的位置信息");
				break;
			case 3:
				$("#address").text("获取您位置信息超时");
				break;
			}
		}
	</script>
	
<jsp:include page="/foot.jsp" />
</body>
</html>
