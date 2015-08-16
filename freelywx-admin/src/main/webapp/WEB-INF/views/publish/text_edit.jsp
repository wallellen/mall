<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp" %>
<!doctype html>
<html>
<head>
<title></title>
<jsp:include page="/meta.jsp" />
<style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }    
    </style>
</head>
<body>
	<form id="form" method="post">
    <div>
	    <input name="id" id="id" class="mini-hidden" />
		<table style="width: 100%;">
			<tr>
				<td> 匹配类型：</td>
				<td><input id="type" name="type" url="${ctx}/combox/dict/MATCH_TYPE" class="mini-combobox" required="true"  width="250"/></td>
			</tr>
			
			
			<tr>
				<td>关键字：</td>
				<td><input id="keyword" name="keyword" class="mini-textarea"  required="true" width="250"  onvalidation="onKeyValidation"/></td>
			</tr>
			
			<tr>
				<td>内容：</td>
				<td><input id="content" name="content" class="mini-textarea" errorMode="border" required="true" width="250"/></td>
			</tr>
			<tr> <td style="text-align:right;padding-top:5px;padding-right:20px;" colspan="6">
	                   <a class="mini-button" onclick="SaveData()" style="width: 60px;">提交</a>&nbsp;&nbsp; 
					   <a class="mini-button" onclick="onCancel" style="width: 60px;">取消</a> 
	             </td>                
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
	                url: "${ctx}/reply/text/save",
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
		}
		//标准方法接口定义
		function SetData(data) {
			if (data.action == "edit") {
				data = mini.clone(data);
				$.ajax({
					url : "${ctx }/reply/text/getText/" + data.id,
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
		function onKeyValidation(e){
	    	if (e.isValid) {
	        	$.ajax({
		            url: "${ctx}/reply/text/check",
		            type: "post",
		            data: { keyword: e.value ,id:mini.get("id").getValue()},
		            success: function (result) {
		           		if(!result){
	                   	   e.errorText = "该名称已经存在!";
	                       e.isValid = false; 
	                    }
	                },
	                error: function () {
	                  	notify("表单加载错误");
	                   	// e.errorText = "密码不能少于5个字符";
	                    e.isValid = false;
	               }
		       }); 
	        }
	    }

    </script>
</body>
</html>