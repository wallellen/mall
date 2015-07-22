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
}
#allmap {width: 100%;height: 100%;overflow: hidden;margin:5;font-family:"微软雅黑";}
</style>
<link href="${res}/uploadify/uploadify.css" rel="stylesheet"	type="text/css" />
<script src="${res}/uploadify/jquery.uploadify.js"	type="text/javascript"></script>

<script type="text/javascript" charset="utf-8"	src="${res }/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"	src="${res }/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8"	src="${res }/ueditor/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet"	href="${res}/ueditor/themes/default/css/ueditor.css" type="text/css" />
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=xjHrhcd3ZUrV79HKwZwBEuE8"></script>
</head>
<body>
	<div class="mini-fit">
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<div>
				<form id="form1" method="post">
					<input name="info_id" id="info_id" class="mini-hidden" />
					<input name="longitude" id="longitude" class="mini-hidden" />
					<input name="latitude" id="latitude" class="mini-hidden" />
					<table style="table-layout: fixed; width: 100%">
						<tr>
							<td style="width: 100px;">景区分类：</td>
							<td>
								<!-- <input name="category_name" class="mini-textBox" url=""/> -->
								<input name="type_id" id="type_id"
								class="mini-treeselect" url="${ctx}/scenicType/listTree"
								multiSelect="false" valueFromSelect="false"
								textField="type_name" parentField="parId"
								valueField="type_id" allowInput="false"    showFolderCheckBox="false"
								popupWidth="200" width="250px" />
							</td>
							<td style="width: 100px;">景区名称：</td>
							<td><input name="info_name" class="mini-textbox"
								required="true"    width="250px" /></td>
						</tr>
						<tr>
							<td>地址：</td>
							<td><input name="address" class="mini-textbox"	required="true" width="250px" /></td>
							<td style="width: 100px;">电话：</td>
							<td><input id="phone" name="phone" class="mini-textbox"  required="true" width="250px" />  
						</tr>
						<tr>
							<td>排序：</td>
							<td colspan="3"><input name="sort" class="mini-textbox"
								vtype="int"   required="true" width="250px" /></td>
						</tr>
						<tr>
							<td style="width: 100px;">区域：</td>
							<td colspan="3">
								省/自治区：<input id="province" name="province"   class="mini-combobox"  required="true" width="250px"
								textField="zone_name" valueField="zone_code" 
								onvaluechanged="onProvinceChanged" url="${ctx}/zone/province"
								 />
								市：<input id="city" name="city"   class="mini-combobox"  required="true" width="250px" 
								textField="zone_name" valueField="zone_code" 
								onvaluechanged="onCityChanged"
								/>
								区：<input id="district" name="district"   class="mini-combobox"   width="250px" 
								textField="zone_name" valueField="zone_code" 
								/>
							</td>
						</tr>
						<tr>
							<td style="width: 100px;">景区简介：</td>
							<td colspan="3">
							<input id="description"	name="description" class="mini-textarea"	style="width: 800px; height: 100px;" required="true" /> 
							 
							</td>
						</tr>
						<tr>
							<td style="width: 100px;">景区描述：</td>
							<td colspan="3"><input id="longdesc" name="longdesc" class="mini-hidden" required="true" /> 
							<script id="editor" charset="UTF-8" type="text/plain" style="width: 800px; height: 300px;"></script>
							</td>
						</tr>
						<tr>
							<td style="width: 100px;">地图标示图标：</td>
							<td  >
							<span>
							<input name="icon" id="h_imgUpload1" class="mini-hidden  hidinput" /> 
							<img id="showUrl" name="pic1" src="${img}/noPic.jpg" alt=""		width="130px" height="90px" />
							 </span>
							 <p>
							 <input type="file" id="imgUpload1" class="fileUploadClass" />
							 <div class="divDeleClass uploadify-button " style="background-image: url('${res}/images/browse-btn-del.png'); text-indent: -9999px; height: 26px; line-height: 26px; width: 100px;">
								 <span class="uploadify-button-text">删除图片</span>
							 </div>					
							</td>
							
							<td style="width: 100px;">封面：</td>
							<td >
							<span>
							<input name="cover" id="h_imgUpload2" class="mini-hidden  hidinput" /> 
							<img id="showUrl" name="pic2" src="${img}/noPic.jpg" alt=""	 width="130px" height="90px" />
							 </span>
							 <p>
							 <input type="file" id="imgUpload2" class="fileUploadClass" />
							 <div class="divDeleClass uploadify-button " style="background-image: url('${res}/images/browse-btn-del.png'); text-indent: -9999px; height: 26px; line-height: 26px; width: 100px;">
								 <span class="uploadify-button-text">删除图片</span>
							 </div>					
							</td>
						</tr>
					</table>
				</form>
				
				<div style="width:100%;height: 500px;margin-top: 10px;">
					<div style="padding-bottom:5px;">
						<input type="button" value="设置景点区域" onclick="setPolygon()"/>
						<input type="button" value="设置景点标志点" onclick="setCenterPoint()"/>
						<input type="button" value="清空景点区域" onclick="removePolygon()"/>
						<input type="button" value="清空景点标志点" onclick="removeCenterPoint()"/>
					</div>
					<div style="padding-bottom:5px;">
						<div id="r-result">请输入:<input type="text" id="suggestId" size="20" value="百度" style="width:150px;" /></div>
						<div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
					</div>
					<div id="allmap"></div>
				</div>
				<div style=" margin-top: 70px">
					<a class="mini-button" onclick="onOk"
						style="width: 60px; margin-right: 20px;">确定</a> <a
						class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
     	var editor = UE.getEditor('editor');
        mini.parse();
        var province = mini.get("province");
        var city = mini.get("city");
        var district = mini.get("district");
        function onProvinceChanged(e) {
            var id = province.getValue();
            city.setValue("");
            var url = "${ctx}/zone/city/" + id
            city.setUrl(url);
            city.select(0);
        }
        function onCityChanged(e) {
            var id = city.getValue();
            district.setValue("");
            var url = "${ctx}/zone/district/" + id
            district.setUrl(url);
            district.select(0);
        }
        
        var form1 = new mini.Form("form1");
        //默认为server_url 赋值
         $('.fileUploadClass').each(function(){
    		var obj = $(this).parent().parent(); 
    		var id = $(this).attr("id");
    		$("#"+id).uploadify({
    		    buttonImage:"${res}/images/browse-btn.png",
    	        swf           : '${res}/uploadify/uploadify.swf',  // uploadify.swf在项目中的路径 
    	        uploader      : '${ctx}/file/upload;jsessionid=<%=session.getId()%>', // 后台UploadController处理上传的方法
    	        formData : {
					path : 'scenic_base' ,
					key  :id
				},
				queueID : true,
				fileObjName : 'file', // The name of the file object to use in your server-side script  
				fileSizeLimit : '10MB',
				height : 26,
				width : 100,
				fileTypeExts : '*.gif; *.jpg; *.png;*.jpeg',
				onUploadSuccess : function(
						file, data, response) {
					var jsonOjb = eval("("+ data + ")");
					if (jsonOjb.status == '1') {
						//obj.find("#picur").val(	jsonOjb.url);
						mini.get("h_"+jsonOjb.key).setValue(jsonOjb.url);
						obj.find("#showUrl").attr("src",jsonOjb.previewUrl);
					} else {
						alert("服务器异常，请稍后重试!");
					}
				},
				onUploadError : function(file,
						errorCode, errorMsg,
						errorString) {
					//alert('文件: ' + file.name + ' 上传失败，原因: ' + errorString);
					alert("服务器异常，请稍后重试!");
				},
				onCancel : function(file) {
					alert('文件： ' + file.name+ ' 取消上传');
				}
			});								
		});
		$('.divDeleClass').live("click", function() {
			var obj = $(this).parent().parent();
			var id = obj.find(".hidinput").attr("id");
			if (id) {
				mini.get(id).setValue("");
				obj.find("#showUrl").attr("src", "${img}/noPic.jpg");
			} else {
				alert("请先上传图片");
			}
		});
		function SaveData() {
			mini.get("#longdesc").setValue(editor.getContent());
			var o1 = form1.getData(true, false);
			form1.validate();
			if(mapArr.length <= 0){
				alert("请在地图标注景区区域!");
			}else if(jQuery.isEmptyObject(centerPoint)){
				alert("请在地图选择标志点！");
			}else if(!form1.isValid() ){
				alert("输入信息有误！");
			}else{
				if (o1.cover == "") {
					alert("请至少上传一张产品封面图片!");
				} else if(o1.desc == ''){
					alert("请输入景区的描述信息");
				}else {	
					var json  = mini.encode(o1);
					var positonStr = "";
					//.lng, e.point.lat
					for(var i = 0 ;i< mapArr.length ;i++){
						var str = mapArr[i].lng+"_"+mapArr[i].lat+",";
						positonStr += str;
					}
					$.ajax({
		                url: "${ctx}/scenic/saveAll",
		                type:"POST", 
		                data:{
							infoStr : json,
							positonStr : positonStr
							 
						},
		                success: function (text) {
		                	if(text){
		                		notify("添加类型成功");
		                		 CloseWindow("save");
		                	}else{
		                		notify("服务器繁忙，请扫后重试");
		                	}
		                },
		                error: function (jqXHR, textStatus, errorThrown) {
		                	notify("服务器繁忙，请扫后重试");
		                }
		            });  
				}
			}
		}
		function timeOutFun() {
			editor.setContent(mini.get("#longdesc").getValue());
		}
		//标准方法接口定义
		function SetData(data) {
			if (data.action == "edit") {
				//跨页面传递的数据对象，克隆后才可以安全使用
				data = mini.clone(data);
				//商品基本信息
				$.ajax({
					url : "${ctx}/scenic/" + data.id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						var url = "${ctx}/zone/city/" + o.province ;
				        city.setUrl(url);
				        var url = "${ctx}/zone/district/" + o.city;
			            district.setUrl(url);
			            
			            district.select(0);
			            
			            
						form1.setData(o);
						var url = ("${server_url}"+o.icon).replace("\"","");
						var url1 = ("${server_url}"+o.cover).replace("\"","");
						$("img[name='pic1']").attr('src', url);
						$("img[name='pic2']").attr('src', url1);
						form1.setChanged(false);
						initPolygon(o.positionList);
						initCenterPoint(o.longitude,o.latitude);
					}
				});
				setTimeout("timeOutFun()", 500);
			} else {
				mini.get("type_id").setValue(data.type_id);
				mini.get("type_id").disable();
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
	var makerArr1 = new Array();    
	var makerArr2  ;  
	
  	function addMarker(point,type){
	  var marker = new BMap.Marker(point);
	  map.addOverlay(marker);
	  if(type=='1'){
		  makerArr1.push(marker);
	  }else{
		  makerArr2 = marker ;
	  }
	}
	  
	var mapArr = new Array();    //景点区域的坐标数组
	var centerPoint ={};    			 //景点标志点 坐标
	var polygon ; 				 //地图的多边形
	function showPolygon(e){
        var point = new BMap.Point(e.point.lng, e.point.lat);
        addMarker(point,'1');
      	mapArr.push(point);
      	if(mapArr.length >2){
          	map.removeOverlay(polygon); 
        	polygon = new BMap.Polygon(mapArr,{strokeColor:"blue", strokeWeight:1, strokeOpacity:1});  //创建多边形
			map.addOverlay(polygon);   //增加多边形
      	} 
	}
	function showCenterPoint(e){
		removeCenterPoint();
        var point = new BMap.Point(e.point.lng, e.point.lat);
        addMarker(point,'2');
        centerPoint = point ;
        mini.get("longitude").setValue(point.lng);
        mini.get("latitude").setValue(point.lat);
	}
	
	function setPolygon(){
		map.removeEventListener("click", showCenterPoint);
		map.removeEventListener("click", showPolygon);
		map.addEventListener("click", showPolygon);
	}
	
	function setCenterPoint(){
		map.removeEventListener("click", showPolygon);
		map.removeEventListener("click", showCenterPoint);
		map.addEventListener("click", showCenterPoint);
	}
	
	function removePolygon(){
		map.removeOverlay(polygon); 
		for(var i = 0 ; i<makerArr1.length;i++ ){
			map.removeOverlay(makerArr1[i]);
		}
		makerArr1  = [];
		mapArr= [];
	}
	
	function removeCenterPoint(){
		map.removeOverlay(makerArr2);
		centerPoint = {};
	}
	
	function initPolygon(posiList){
		for(var i =0 ;i<posiList.length;i++){
			var point = new BMap.Point(posiList[i].longitude, posiList[i].latitude);
	        addMarker(point,'1');
	      	mapArr.push(point);
		}
      	if(mapArr.length >2){
          	//map.removeOverlay(polygon); 
        	polygon = new BMap.Polygon(mapArr,{strokeColor:"blue", strokeWeight:1, strokeOpacity:1});  //创建多边形
			map.addOverlay(polygon);   //增加多边形
      	} 
	}

	function initCenterPoint(lng,lat){
		removeCenterPoint();
        var point = new BMap.Point(lng, lat);
        addMarker(point,'2');
        centerPoint = point ;
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
			}
			var local = new BMap.LocalSearch(map, { //智能搜索
			  onSearchComplete: myFun
			});
			local.search(myValue);
		}
	</script>
</body>
</html>