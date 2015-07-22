<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>商户公众号默认设置信息</title>
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
</style>
</head>
<body>
	<form id="form1" method="post">
	<!--新增的操作  -->
	<div  >
			<input class="mini-hidden" name="user_id" />
			<table style="width: 100%;">
				<tr>
					<td style="width: 100px;">公共号名称：</td>
					<td style="width: 300px;"><input name="public_name" class="mini-textbox" required="true" /></td>
				</tr>
				<tr id="original_id">
					<td style="width: 100px;">原始公众号：</td>
					<td style="width: 300px;"><input name="original_id"		class="mini-textbox" required="true" /></td>
				</tr>
				<tr>
					<td style="width: 100px;">微信号：</td>
					<td style="width: 300px;"><input name="wx_number"
						class="mini-textbox" required="true" /></td>
				</tr>
				<tr>
					<td style="width: 100px;">app_id：</td>
					<td style="width: 300px;"><input name="app_id"
						class="mini-textbox" required="true" /></td>
				</tr>
				<tr>
					<td style="width: 100px;">app_secret：</td>
					<td style="width: 300px;"><input name="app_secret"
						class="mini-textbox" required="true" /></td>
				</tr>
				<!-- <tr>
					<td style="width: 100px;">匹配：</td>
					<td style="width: 150px;"><input name="matching"
						class="mini-textbox" required="true" /></td>
				</tr>
				<tr>
					<td style="width: 100px;">lbs：</td>
					<td style="width: 150px;"><input name="lbs"
						class="mini-textbox" required="true" /></td>
				</tr>
				<tr>
					<td style="width: 100px;">token：</td>
					<td style="width: 150px;"><input name="token"
						class="mini-textbox" required="true" /></td>
				</tr>
				<tr>
					<td style="width: 100px;">portrait_url：</td>
					<td style="width: 150px;"><input name="portrait_url"
						class="mini-textbox" required="true" vtype="url" /></td>
				</tr>
				<tr>
					<td style="width: 100px;">port_url：</td>
					<td style="width: 150px;"><input name="port_url"
						class="mini-textbox" required="true" vtype="url" /></td>
				</tr>
				<tr>
					<td style="width: 100px;">public_type：</td>
					<td style="width: 150px;"><input name="public_type"
						class="mini-textbox" required="true" /></td>
				</tr>
				<tr>
					<td style="width: 100px;">qr_url：</td>
					<td style="width: 150px;"><input name="qr_url"
						class="mini-textbox" required="true" vtype="url" /></td>
				</tr>
				<tr>
					<td style="width: 100px;">ur_text：</td>
					<td style="width: 150px;"><input name="ur_text"
						class="mini-textbox" required="true" /></td>
				</tr> -->
				<tr>
					<td style="text-align: right; padding-top: 5px; padding-right: 20px;" colspan="6">
						<a class="mini-button" onclick="SaveData()" style="width: 60px;">提交</a>&nbsp;&nbsp; 
						<a class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
					</td>
				</tr>
			</table>
		</div>
	</form>
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("form1");
	
	function SaveData() {
		var o = form.getData(true);
		form.validate();
		if (form.isValid() == false)
			return;
		var json = mini.encode(o);
		//alert(json);
		 $.post("${ctx }/merchant/info/save", o, function(result) {
			 CloseWindow("save");
		}); 
	}
	
	//标准方法接口定义
	function SetData(data) {
		if (data.action == "edit") {
			data = mini.clone(data);
			$.ajax({
				url : "${ctx }/merchant/info/getMerchant/" + data.user_id,
				cache : false,
				success : function(text) {
					var o = mini.decode(text);
					form.setData(o);
					$("#original_id").hide();
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
	</script>
</body>
</html>