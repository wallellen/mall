<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<jsp:include page="/meta.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
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
	  	<input class="mini-hidden" name="menu_id" id="menu_id" />  
		<input class="mini-hidden" name="pid" id="pid" />
		
		
		<table style="width: 100%;">
			<tr>
				<td style="width: 150px;">菜单文本：</td>
				<td style="width: 250px;"><input name="menu_name" id="menu_name"
					class="mini-textbox"  errorMode="border" required="true" /></td>
			</tr>
			<tr>
				<td style="width: 150px;">菜单类型：</td>
				<td style="width: 250px;">
				<input name="type" id="type" onvaluechanged="valueChanged" class="mini-combobox" allowinput="true" textField="text" valueField="id" url="${ctx}/combox/dict/MENU_TYPE">
				</td>
			</tr>
			<tr>
				<td style="width: 150px;">触发的关键词：</td>
				<td style="width: 250px;">
					<input id="keyword_id"  name="keyword_id" class="mini-combobox" style="width:150px;" textField="keyword" valueField="keyword_id" emptyText="请选择..."
   					 url="${ctx}/keyword/list"  allowInput="false" showNullItem="true" nullItemText="请选择..."/>   
				</td>
			</tr>
			<tr>
				<td style="width: 150px;">链接地址：</td>
				<td style="width:250px;">
	                <input id="url" class="mini-textbox"  vtype="url" name="url"  />
	            </td>
			</tr>
				<tr>
				<td style="width: 150px;">排序：</td>
				<td style="width:250px;">
	                <input id="sort" class="mini-textbox"  vtype="int" name="sort"  />
	            </td>
			</tr>
			<tr>
				<td></td>
				<td><a class="mini-button" onclick="SaveData()"
					style="width: 60px;">提交</a>&nbsp;&nbsp; <a class="mini-button"
					onclick="onCancel" style="width: 60px;">取消</a></td>
			</tr>
		</table>
	</form>
		<script type="text/javascript">
		mini.parse();
		var form = new mini.Form("form1");
		
		function SaveData() {
			
			form.validate();
			if (form.isValid() == false)
				return;
			var o = form.getData(true, false);
			console.log(o);
			var json = mini.encode(o);
			$.ajax({
                url: "${ctx}/wxMenu/save",
                type:"POST", 
                dataType:"json",      
                contentType:'application/json;charset=UTF-8',  
                data:json, 
                success: function (text) {
                	if(text){
                		notify("添加 成功");
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
	   	 
		//标准方法接口定义
		function SetData(data) {
			if (data.action == "edit") {
				data = mini.clone(data);
				$.ajax({
					url : "${ctx }/wxMenu/" + data.menu_id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						form.setData(o);
						if( o.menu_type==1){
				//			$("#edit_menu_keyword").show();
				//			$("#edit_menu_url").hide();
						}else{
				//			$("#edit_menu_url").show();
				//			mini.get("edit_menu_url").setValue(o.menu_url);
				//			$("#edit_menu_keyword").hide();
						} 
					}
				});
			}else{
				data = mini.clone(data);
				mini.get("pid").setValue(data.parentId);
				var type = data.type;
				if(type == "leaf"){
				//	$("#edit_menu_keyword").show();
					//$("#edit_menu_url").show();
				}else{
					//$("#edit_menu_keyword").hide();
				//	$("#edit_menu_url").hide();
				}
			}
		}

		function valueChanged(e) {
			if (1 == e.value) {
				$("#edit_menu_keyword").show();
				$("#edit_menu_url").hide();
			} else {
				$("#edit_menu_keyword").hide();
				$("#edit_menu_url").show();
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
		
		
		//验证菜单名称是否已经存在(修改时不验证自身菜单名称)
		function onNmInValidation(e) {
			if (e.isValid) {
				var menu_name = mini.get("menu_name").getValue();
				if (menu_name != e.value) {
					$.ajax({
						url : '${ctx}/wxMenu/checkName/' + e.value,
						async : false,
						type : "post",
						success : function(text) {
							if (!text) {
								alert("该名称已经存在,已自动清除!");
							    mini.get("mname").setValue("");
							}
						},
						error : function() {
							alert("表单加载错误");
							// e.errorText = "密码不能少于5个字符";
							e.isValid = false;
						}
					});
				}

			}
		}
		
		function onKeywordEditValidation(e) {
			var edit_type = mini.get("edit_type").getValue();
			if (edit_type == "1") {
				if (e.isValid) {
					$.ajax({
						url : '${ctx}/keyword/checkKeyword/' + e.value,
						async : false,
						type : "post",
						success : function(flag) {
							if (flag == true) {
								alert("不存在的关键词!");
							}
						},
						error : function() {
							notify("表单加载错误");
							e.isValid = false;
						}
					});
				}
			}
		}
		</script>
</body>
</html>