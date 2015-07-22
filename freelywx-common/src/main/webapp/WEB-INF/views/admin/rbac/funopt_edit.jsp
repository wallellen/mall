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
	        <input class="mini-hidden" name="fun_opt_id" id="fun_opt_id"/>
	        <input class="mini-hidden" name="parent_fun_opt_id"/>
	        <table style="width:100%;">
	            <tr>
	                <td style="width:80px;">功能操作名称：</td>
	                <td style="width:150px;">
	                	<input name="fun_opt_nm" class="mini-textbox" onvalidation="onNmValidation"   required="true" />
	                </td>
	            </tr>
	            <tr>
	                <td style="width:80px;">URL前缀：</td>
	                <td style="width:150px;">
	                	<input name="url" class="mini-textbox" onvalidation="onUrlValidation"  required="true" />
	                </td>
	            </tr>
	            <tr>
	                <td style="width:80px;">备注：</td>
	                <td style="width:150px;"><input name="remarks" class="mini-textarea" /></td>
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
		var type = "1"; // 1、增减；2、编辑
        
		function SaveData() {
	        form.validate();
	        if (form.isValid() == true) {
	        	var o = form.getData();
	            var json = mini.encode(o);
	            $.ajax({
	                url: "${ctx}/admin/funopt/save",
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
					url : "${ctx }/admin/funopt/getFunopt/" + data.fun_opt_id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						form.setData(o);
						 type = "2";
					}
				});
			} else{
				data = mini.clone(data);
				if(data.parent_fun_opt_id){
					mini.getbyName("parent_fun_opt_id").setValue(data.parent_fun_opt_id);
				}
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
                    url: '${ctx}/admin/funopt/check',
                    async : false, 
                    data:{fun_opt_nm:e.value,fun_opt_id:mini.get("fun_opt_id").getValue()},
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
        function onUrlValidation(e) {
            if (e.isValid) {
            		$.ajax({
                        url: '${ctx}/rbac/funopt/checkUrl',
                        async : false, 
                        data:{url:e.value,fun_opt_id:mini.get("fun_opt_id").getValue()},
                        success: function (text) {
                       	 if(!text){
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