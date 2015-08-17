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
</head>
<body>
	<form id="form" method="post">
		<div>
			<input class="mini-hidden" name="attention_id" /> 

			<table style="width: 100%;">

				<tr>
					<td style="width: 80px;">关键词：</td>
					<td style="width: 150px;"><input id="keyword_id"  name="keyword_id" class="mini-combobox" style="width:150px;" textField="keyword" valueField="keyword_id" emptyText="请选择..."
   					 url="${ctx}/keyword/listAll"  allowInput="false" showNullItem="true" nullItemText="请选择..." required="true"/>   </td>


					<td style="width: 80px;">标题：</td>
					<td style="width: 150px;"><input name="title"
						class="mini-textbox" required="true" /></td>
				</tr>
				<tr>


					<td style="width: 80px;">开始时间 ：</td>
					<td style="width: 150px;"><input name="start_time"
						 class="mini-datepicker"  /></td>
					<td style="width: 80px;">结束时间：</td>
					<td style="width: 150px;"><input name="end_time"
						 class="mini-datepicker"   /></td>
				</tr>
<%-- 				<tr>
					<td style="width: 80px;">状态 ：</td>
					<td style="width: 150px;"><input name="status"
						class="mini-combobox" errorMode="border" required="true"
					textField="text"    url="${ctx}/combox/dict/STATE" /></td>
				</tr>
				
				
 --%>				
				<tr>
				<td></td>
				<td><a class="mini-button" onclick="SaveData()"
					style="width: 60px;">提交</a>&nbsp;&nbsp; <a class="mini-button"
					onclick="onCancel" style="width: 60px;">取消</a></td>
			</tr>
			
			


			</table>
		</div>
	</form>

	<script type="text/javascript">
		mini.parse();
		var form = new mini.Form("form");
		//标准方法接口定义
		function SetData(data) {
			if (data.action == "edit") {
				data = mini.clone(data);
				$.ajax({
					url : "${ctx }/attention/" + data.id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						form.setData(o);
					}
				});
			} 
		}
		
		function SaveData() {
			var o = form.getData(true);
			form.validate();
			if (form.isValid() == false)
				return;
			var json = mini.encode(o);
			$.ajax({
                url: "${ctx}/attention/save",
                type:"POST", 
                dataType:"json",      
                contentType:'application/json;charset=UTF-8',  
                data:json, 
                success: function (text) {
                	if(text){
                		notify("修改成功");
                	}else{
                		notify("服务器繁忙，请扫后重试");
                	}
                	CloseWindow("save");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	notify("服务器繁忙，请扫后重试");
                }
            });   
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
		function onCancel(e) {
			CloseWindow("cancel");
		}
		
	</script>
</body>
</html>