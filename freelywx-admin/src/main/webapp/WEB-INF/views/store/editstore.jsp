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
</style>
</head>
<body>
	<form id="form" method="post">
		<div>
			<input class="mini-hidden" name="store_id" />
			<table style="width: 100%;">
				<tr>
					<td style="width: 80px;">店铺名称 ：</td>
					<td style="width: 150px;"><input name="store_name" class="mini-textbox" required="true" /></td>
					<td style="width: 80px;">address ：</td>
					<td style="width: 150px;"><input name="address" class="mini-textbox" required="true" /></td>
					</td>
				</tr>
				<tr>
					<td style="width: 80px;">tel：</td>
					<td style="width: 150px;"><input name="tel" class="mini-textbox" required="true" /></td>
					<td style="width: 80px;">sort：</td>
					<td style="width: 150px;"><input name="sort" class="mini-textbox" required="true" vtype="int" /></td>
				</tr>
				<tr>
					<td style="width: 80px;">商圈：</td>
					<td style="width: 150px;"><input name="site_id" class="mini-textbox" required="true" /></td>
					<td style="width: 80px;">状态：</td>
					<td style="width: 150px;"><input name="status" url="${ctx}/combox/dict/STATE" class="mini-combobox" required="true" /></td>
				</tr>
				<tr>
					<td
						style="text-align: center; padding-top: 5px; padding-right: 20px;"
						colspan="6"><a class="mini-button" onclick="SaveData()"
						style="width: 60px;">提交</a>&nbsp;&nbsp; <a class="mini-button"
						onclick="onCancel" style="width: 60px;">取消</a></td>
				</tr>
			</table>
		</div>
	</form>
	<script type="text/javascript">
		mini.parse();
		var form = new mini.Form("form");

		function SaveData() {
			form.validate();
			if (form.isValid() == true) {
				var o = form.getData();
				var json = mini.encode(o);
				$.ajax({
					url : "${ctx}/store/save",
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
					url : "${ctx }/store/" + data.store_id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						form.setData(o);
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
		function add() {
			var form = new mini.Form("#addform");
			form.reset();
			addWindow.show();
		}
	</script>
</body>
</html>