<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title></title>
<jsp:include page="/meta.jsp" />
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}
#allmap {width: 100%;height: 100%; margin:5;font-family:"微软雅黑";}
</style>
<script type="text/javascript"	src="http://api.map.baidu.com/api?v=2.0&ak=xjHrhcd3ZUrV79HKwZwBEuE8"></script>
</head>
<body>
	<form id="form" method="post">
		<div>
			<input class="mini-hidden" name="site_id" id="site_id"/>
			<input class="mini-hidden" name="build_id"  id="build_id"/>
			<input name="longitude" id="longitude" class="mini-hidden" />
			<input name="latitude" id="latitude" class="mini-hidden" />
			<table style="width: 100%;">
				<tr>
					<td style="width: 80px;">名称 ：</td>
					<td style="width: 150px;"><input name="build_name" class="mini-textbox" required="true" /></td>
					</td>
				</tr>
				<tr>
					<td style="width: 80px;">状态：</td>
					<td style="width: 150px;"><input name="status" id="status"	class="mini-comboBox"	url="${ctx}/combox/dict/STATE"	required="true"  width="250px"/></td>
					</td>
				</tr>
				<tr>
					<td style="width: 80px;">是否有店铺：</td>
					<td style="width: 150px;"><input name="has_site" id="has_site"	class="mini-comboBox"	url="${ctx}/combox/dict/YESORNO"	required="true"  width="250px"/></td>
					</td>
				</tr>
				<tr>
					<td style="width: 80px;">排序 ：</td>
					<td style="width: 150px;"><input name="sort" class="mini-textbox" required="true" vtype="int"/></td>
					</td>
				</tr>
				<tr>
					<td style="width: 100px;">店铺简介：</td>
					<td colspan="3">
						<input id="description"	name="description" class="mini-textarea"	style="width: 800px; height: 100px;" required="true" /> 
							 
					</td>
				</tr>		
			</table>
		</div>
	</form>
	<div style="width:100%;height: 500px;margin-top: 10px;">
				<div style="padding-bottom:5px;">
					<input type="button" value="设置景点标志点" onclick="setCenterPoint()"/>
					<input type="button" value="清空景点标志点" onclick="removeCenterPoint()"/>
				</div>
				<div style="padding-bottom:5px;">
					<div id="r-result">请输入:<input type="text" id="suggestId" size="20" value="百度" style="width:150px;" /></div>
					<div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
				</div>
				<div id="allmap"></div>
			</div>
			<div style=" margin-top: 70px">
				<a class="mini-button" onclick="SaveData()"
						style="width: 60px; margin-right: 20px;">确定</a> <a
						class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
			</div>
	<script type="text/javascript">
		mini.parse();
		var form = new mini.Form("form");

		function SaveData() {
			form.validate();
			if (form.isValid() == true) {
				if( mini.get("longitude").getValue() == ''){
					alert("请在地图设置店铺位置！");
					return false;
				}
				var o = form.getData();
				var json = mini.encode(o);
				$.ajax({
					url : "${ctx}/build/save",
					type : "POST",
					dataType : "json",
					contentType : 'application/json;charset=UTF-8',
					data : json,
					success : function(text) {
						if (text) {
							notify("添加用户成功");
						} else {
							notify("服务器繁忙，请扫后重试");
						}
						CloseWindow("save");
					},
					error : function(jqXHR, textStatus, errorThrown) {
						notify("服务器繁忙，请扫后重试");
					}
				});
			}
		}

		//标准方法接口定义
		function SetData(data) {
			if (data.action == "edit") {
				data = mini.clone(data);
				$.ajax({
					url : "${ctx }/build/" + data.build_id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						form.setData(o);
						initCenterPoint(o.longitude,o.latitude);
					}
				});
			}else{
				data = mini.clone(data);
				mini.get("site_id").setValue(data.site_id);
			}
		}

		function GetData() {
			var o = form.getData();
			return o;
		}
		function CloseWindow(action) {
			if (action == "close" && form.isChanged()) {
				if (confirm("数据被修改了，是否先保存？")) {
					return false;
				}
			}
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}
		function onOk(e) {
			SaveData();
		}
		function onCancel(e) {
			CloseWindow("cancel");
		}
		function add() {
			var form = new mini.Form("#addform");
			form.reset();
			addWindow.show();
		}
	</script>
	
	
	<script>
	var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
	var top_right_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}); //右上角，仅包含平移和缩放按钮
	// 百度地图API功能
	var map = new BMap.Map("allmap");
	map.centerAndZoom("武汉",15);  
	map.addControl(top_left_control);        
	map.addControl(top_left_navigation);     
	map.addControl(top_right_navigation);   
	
	var makerArr2  ;  
	
  	function addMarker(point ){
	  var marker = new BMap.Marker(point);
	  map.addOverlay(marker);
	  makerArr2 = marker ;
	}
	  
	var centerPoint ={};    			 //景点标志点 坐标
	function showCenterPoint(e){
		removeCenterPoint();
        var point = new BMap.Point(e.point.lng, e.point.lat);
        addMarker(point);
        mini.get("longitude").setValue(point.lng);
        mini.get("latitude").setValue(point.lat);
	}
	function setCenterPoint(){
		map.removeEventListener("click", showCenterPoint);
		map.addEventListener("click", showCenterPoint);
	}
	
	function removeCenterPoint(){
		map.clearOverlays();  
		mini.get("longitude").setValue("");
	    mini.get("latitude").setValue("");
	}

	function initCenterPoint(lng,lat){
		var point = new BMap.Point(lng, lat); 
		map.centerAndZoom(point, 18);
		map.addOverlay(new BMap.Marker(point));    //添加标注
	}
	
	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
			{"input" : "suggestId"
			,"location" : map
		});

		ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
		var str = "";
			var _value = e.fromitem.value;
			var value = "";
			if (e.fromitem.index > -1) {
				value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			}    
			str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
			
			value = "";
			if (e.toitem.index > -1) {
				_value = e.toitem.value;
				value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			}    
			str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
			document.getElementById("searchResultPanel").innerHTML = str;
		});

		var myValue;
		ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
		var _value = e.item.value;
			myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			document.getElementById("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
			
			setPlace();
		});

		function setPlace(){
			map.clearOverlays();    //清除地图上所有覆盖物
			function myFun(){
				var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
				map.centerAndZoom(pp, 18);
				map.addOverlay(new BMap.Marker(pp));    //添加标注
				mini.get("longitude").setValue(pp.lng);
			    mini.get("latitude").setValue(pp.lat);
			}
			var local = new BMap.LocalSearch(map, { //智能搜索
			  onSearchComplete: myFun
			});
			local.search(myValue);
		}
	</script>
</body>
</html>