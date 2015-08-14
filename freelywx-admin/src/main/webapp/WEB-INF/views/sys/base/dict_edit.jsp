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
	        <table style="width:100%;">
	        	<tr>
	                <td style="width:80px;">字典编号：</td>
	                <td style="width:200px;">
	                	<input name="dict_id" class="mini-textbox" onvalidation="onNmValidation" required="true" />
	                </td>
	            </tr>
	            <tr>
	                <td style="width:80px;">字典名称：</td>
	                <td style="width:200px;"><input name="dict_name"  class="mini-textbox" required="true"/></td>
	            </tr>
	            <tr>
	                <td style="width:80px;">字典描述：</td>
	                <td style="width:200px;"><input name="dict_desc"   class="mini-textarea" required="true"/></td>
	            </tr>
	         <%--    <tr>
	                <td style="width:80px;">字典类型：</td>
	                <td style="width:200px;"><input name="dict_type" url="${ctx }/combox/dict/dict_type" class="mini-combobox" required="true"/></td>
	            </tr> --%>
	            <tr>
	                <td style="width:80px;">字典状态：</td>
	                <td style="width:200px;"><input name="dict_status" url="${ctx }/combox/dict/STATE" class="mini-combobox" required="true"/></td>
	            </tr>
	            <tr>
	                <td style="text-align:right;padding-top:5px;padding-right:20px;" colspan="6">
	                   <a class="mini-button" onclick="SaveData()"
						style="width: 60px;">提交</a>&nbsp;&nbsp; 
					   <a class="mini-button"
						onclick="onCancel" style="width: 60px;">取消</a> 
	                </td>                
	            </tr>
	        </table>
	    </div>
	</form>
    <script type="text/javascript">
    	mini.parse();
		var form = new mini.Form("form");
        var defaultId = "";
        var type = "1";  //1、增加；2、修改
		function SaveData() {
	        form.validate();
	        if (form.isValid() == true) {
	        	var o = form.getData();
	            var json = mini.encode(o);
	            $.ajax({
	                url: "${ctx}/sys/dict/save/"+type,
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
					url : "${ctx }/sys/dict/" + data.dict_id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						form.setData(o);
						defaultId = data.dict_id;
						type = "2";
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
        function onNmValidation(e) {
            if (e.isValid) {
            	$.ajax({
                    url: '${ctx}/sys/dict/check',
                    async : false, 
                    data:{dictId:e.value,defaultId:defaultId},
                    success: function (text) {
                   	 if(text){
                   		e.errorText = "该名称已经存在!";
                        e.isValid = false; 
                   	 }
                    },
                    error: function () {
                   	    notify("表单加载错误");
                     e.isValid = false;
                    }
                });	
            }
        }

    </script>
</body>
</html>