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
	        <input class="mini-hidden" name="user_id"/>
	        <table style="width:100%;">
	            <tr>
	                <td style="width:80px;">登录名称：</td>
	                <td style="width:150px;">
	                	<input name="login_id" class="mini-textbox" required="true" />
	                </td>
	            </tr>
	          <tr>
	                <td style="width:80px;">真实姓名：</td>
	                <td style="width:150px;"><input name="user_name" class="mini-textbox" required="true"/></td>
	            </tr>
	            <tr id="pwdsTr">
	                <td style="width:80px;">登录密码：</td>
	                <td style="width:150px;"><input id="pwds" onvalidation="onPwdsValidation" class="mini-password" required="true"/></td>
	            </tr>
	            <tr id="pwdTr">
	                <td style="width:80px;">确认密码：</td>
	                <td style="width:150px;"><input name="pwd" onvalidation="onPwdValidation" class="mini-password" required="true"/></td>
	            </tr>
	            <tr>
	                <td style="width:80px;">用户类型：</td>
	                <td style="width:150px;"><input name="user_type" url="${ctx}/combox/dict/USER_TYPE" class="mini-combobox" required="true"/></td>
	            </tr>
	            <tr>
	                <td style="width:80px;">用户状态：</td>
	                <td style="width:150px;"><input name="user_status" url="${ctx}/combox/dict/STATE" class="mini-combobox" required="true"/></td>
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
	
	function SaveData() {
        form.validate();
        if (form.isValid() == true) {
        	var o = form.getData();
            var json = mini.encode(o);
            $.ajax({
                url: "${ctx}/sys/user/save",
                type:"POST", 
                dataType:"json",      
                contentType:'application/json;charset=UTF-8',  
                data:json, 
                success: function (text) {
                	if(text){
                		notify("添加用户成功");
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
				url : "${ctx }/sys/user/" + data.userId,
				cache : false,
				success : function(text) {
					var o = mini.decode(text);
					form.setData(o);
					
					$("#pwdsTr").hide();
					$("#pwdTr").hide();
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
	function edit() {
   	 	var row = grid.getSelected();
        if (row) {
            editWindow.show();
            var form = new mini.Form("#editform");
            form.clear();
            form.loading();
            $.ajax({
                url: '${ctx}/sys/user/' + row.user_id,
                success: function (text) {
                    form.unmask();
                    var o = mini.decode(text);
                    form.setData(o);
                },
                error: function () {
                    alert("表单加载错误");
                    form.unmask();
                }
            });
        }else{
       	 alert("请选中一条记录");
        }
   }    
   
   function onPwdValidation(e) {
       if (e.isValid) {
       	var pwds = mini.get("pwds").getValue();
           if (e.value != pwds) {
               e.errorText = "两次输入密码不一致";
               e.isValid = false;
           }
       }
   }
   
   function onPwdsValidation(e) {
       if (e.isValid) {
           if (e.value.length < 5) {
               e.errorText = "密码不能少于5个字符";
               e.isValid = false;
           }
       }
   }
        
       



    </script>
</body>
</html>