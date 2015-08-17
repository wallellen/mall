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
			<input class="mini-hidden" name="keyword_id" id="keyword_id"/> 

			<table style="width: 100%;">

				<tr>
					<td style="width: 80px;">关键词：</td>
					<td style="width: 150px;"><input name="keyword"	class="mini-textbox" required="true" /> </td>


					<td style="width: 80px;">备注：</td>
					<td style="width: 150px;">
					<input name="remarks"		class="mini-textbox" required="true" />
					</td>
				</tr>
				<tr>
					<td style="width: 80px;">回复类型 ：</td>
					<td style="width: 150px;"> 
						<input name="reply_type" id="reply_type" onvaluechanged="valueChanged" class="mini-combobox" allowinput="true" textField="text" valueField="id" url="${ctx}/combox/dict/REPLY_TYPE">
					</td>
					<td style="width: 80px;">回复消息：</td>
					<td style="width: 150px;"> 
						<input name="reply_id" id="reply_id"  class="mini-combobox" allowinput="true" textField="title" valueField="id"  ">
					</td>
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
		var replyCombo = mini.get("reply_type");
        var replyIdCombo = mini.get("reply_id");

		function valueChanged(){
			 var id = replyCombo.getValue();
			 if(id =="1"){
				  var url = "${ctx}/reply/text/listAll";
				  replyIdCombo.setUrl(url);
				  replyIdCombo.select(0);
			 }else if(id =="2"){
				 var url = "${ctx}/reply/img/listAll";
				 replyIdCombo.setUrl(url);
				 replyIdCombo.select(0);
			 }else if(id =="3"){
				 var url = "${ctx}/reply/imgmulti/listAll";
				 replyIdCombo.setUrl(url);
				 replyIdCombo.select(0);
			 }
		}
		
		//标准方法接口定义
		function SetData(data) {
			if (data.action == "edit") {
				data = mini.clone(data);
				$.ajax({
					url : "${ctx }/keyword/" + data.id,
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
                url: "${ctx}/keyword/save",
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