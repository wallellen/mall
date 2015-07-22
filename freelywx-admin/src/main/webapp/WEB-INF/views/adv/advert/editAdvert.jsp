<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title></title>
<jsp:include page="/meta.jsp" />
<style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%; 
    }    
</style>
<link href="${res}/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script src="${res}/uploadify/jquery.uploadify.js" type="text/javascript"></script>
</head>
<body>
	<input name="server_url" id="server_url" class="mini-hidden"	value="${server_url }" />
	<form id="form1" method="post">
		<input name="ad_id" id="ad_id" class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table style="table-layout: fixed;">
				<tr>
					<td style="width: 100px;">广告名称：</td>
					<td  ><input name="ad_name" id="ad_name"
						class="mini-textbox" required="true" 
						emptyText="请输入广告名称" width="250px"/></td>
				</tr>
				<tr>
					<td style="width: 100px;">广告栏目：</td>
					<td  ><input name="coloum_id"
						id="coloum_id" required="true" class="mini-combobox"
						textField="coloum_name" valueField="coloum_id"  width="250px" /></td>
				</tr>
				<tr>
					<td>图片：</td>
					<td><input name="pic_url" id="pic_url" class="mini-hidden" />
						<img id="pic" src="${img}/noPic.jpg" alt="" width="130px"
						height="90px" style="margin-bottom: 10px;" /> <input type="file"
						multiple="true" id="imgUpload" /></td>
				</tr>
				<tr>
					<td style="width: 100px;">链接：</td>
					<td  ><input name="link_url" id="link_url"
						class="mini-textbox" 
						emptyText="请输入链接地址"  width="250px"/></td>
				</tr>
				<tr>
					<td style="width: 100px;">状态：</td>
					<td  ><input name="status" id="status"
						class="mini-comboBox"
						url="${ctx}/combox/dict/STATE"
						required="true"  width="250px"/></td>
				</tr>
				<tr>
					<td style="width: 80px;">开始时间：</td>
					<td  >
						<input  width="250px" id="start_time" name="start_time"  class="mini-datepicker"   required="true"  vtype="date:yyyy-MM-dd" /></td>
				</tr>
				<tr>
					<td style="width: 80px;">结束时间：</td>
					<td >
						<input  width="250px" id="end_time" name="end_time"  class="mini-datepicker"   required="true"  vtype="date:yyyy-MM-dd" /></td>
				</tr>
				<tr>
					<td>描述：</td>
					<td><input name="desciption" id="desciption" class="mini-textArea"
						style="width: 300px;" /></td>
				</tr>
			</table>
		</div>

		<div style="text-align: center; padding: 10px;">
			<a class="mini-button" onclick="onOk"
				style="width: 60px; margin-right: 20px;">确定</a> <a
				class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
		</div>
	</form>
	<script type="text/javascript">
        mini.parse();
        var form = new mini.Form("form1");
        mini.get("server_url").setValue("${server_url}");
        $(function(){
        	coloumSelect();
        	$("#imgUpload").uploadify({
    		    buttonImage:"${img}/browse-btn.png",
    		    swf           : '${res}/uploadify/uploadify.swf',  // uploadify.swf在项目中的路径 
    	        uploader      : '${ctx}/file/upload;jsessionid=<%=session.getId()%>', // 后台UploadController处理上传的方法
    	        formData : {
					path : 'advertise' 
				},
				queueID : true,
				fileObjName : 'file', // The name of the file object to use in your server-side script  
				fileSizeLimit : '10MB',
				height : 26,
				width : 100,
				fileTypeExts : '*.gif; *.jpg; *.png;*.jpeg',
				onUploadSuccess : function(file, data, response) {
					var jsonOjb = eval("(" + data + ")");
					if (jsonOjb.status == '1') {
						mini.get('pic_url').setValue(	jsonOjb.url);
						$('#pic').attr("src",	jsonOjb.previewUrl);
					} else {
						alert("服务器异常，请稍后重试!");
					}
				},
				onUploadError : function(file, errorCode,
						errorMsg, errorString) {
					//alert('文件: ' + file.name + ' 上传失败，原因: ' + errorString);
					alert("服务器异常，请稍后重试!");
				},
				onCancel : function(file) {
					alert('文件： ' + file.name + ' 取消上传');
				}
			});				
		});

		function SaveData() {
			var o = form.getData();
			form.validate();
			if (form.isValid() == false)
				return;
			if (o.pic_url === "") {
				alert('请上传图片！');
				return;
			}
			var json = mini.encode(o);
			json = json.replace(/T00:00:00/g,' 00:00:00');
			$.ajax({
				url : "${ctx}/adv/advertise/save",
				type : "POST",
				dataType : "json",
				contentType : 'application/json;charset=UTF-8',
				data : json,
				success : function(text) {
					if (text) {
						CloseWindow("save");
						notify("操作成功!");
					} else {
						alert("服务器繁忙，请稍后重试");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("服务器繁忙，请稍后重试");
				}
			});
		}
		//标准方法接口定义
		function SetData(data) {
			if (data.action == "edit") {
				//跨页面传递的数据对象，克隆后才可以安全使用
				data = mini.clone(data);
				$.ajax({
					url : "${ctx}/adv/advertise/editData?ad_id=" + data.id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						form.setData(o);
						var url = (mini.get("server_url").getValue() + o.pic_url)
								.replace("\"", "");
						$("#pic").attr('src', url);
						form.setChanged(false);
					}
				});		
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

		var coloumId = mini.get("coloum_id");
		function coloumSelect(e) {
			coloumId.setValue("");
			var url = "${ctx}/adv/coloum/coloumlist";
			coloumId.setUrl(url);
			coloumId.select(0);
		}
	</script>
</body>
</html>