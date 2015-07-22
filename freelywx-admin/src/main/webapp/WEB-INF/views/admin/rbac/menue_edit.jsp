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
	        <input class="mini-hidden" name="menue_id" id="menue_id"/>
	        <input class="mini-hidden" name="par_menue_id"/>
	        <table style="width:100%;">
	             <tr>
	                <td style="width:80px;">菜单名称：</td>
	                <td style="width:150px;">
	                	<input name="menue_nm" class="mini-textbox"  onvalidation="onNmValidation"   required="true" />
	                </td>
	            </tr>
	            <tr>
	                <td style="width:80px;">功能操作：</td>
	                <td style="width:150px;">
	                	<input name="fun_opt_id" style="width:150px;" class="mini-treeselect" url="${ctx}/admin/funopt/listAll" multiSelect="false"  valueFromSelect="false" required="true"
					        textField="fun_opt_nm" valueField="fun_opt_id" parentField="parent_fun_opt_id"   allowInput="false"
					        showRadioButton="true" showFolderCheckBox="false"
					    />
	                	<%-- <input name="fun_opt_id" class="mini-combobox" url="${ctx}/admin/funopt/selFunopt"  required="true" textField="text" valueField="id"  /> --%>   
	                </td>
	            </tr>
	            <tr>
	                <td style="width:80px;">菜单排序：</td>
	                <td style="width:150px;">
	                	<input name="menue_order" class="mini-textbox" vtype="int"  required="true" />
	                </td>
	            </tr>
	             <tr>
	                <td style="width:80px;">状态：</td>
	                <td style="width:150px;"><input name="state" url="${ctx}/combox/dict/STATE" class="mini-combobox" required="true"  /></td>
	            </tr>
	            <tr>
	                <td style="width:80px;">备注：</td>
	                <td style="width:180px;">
	                	<input name="remarks" class="mini-textArea"  />
	                </td>
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
	                url: "${ctx}/admin/menue/save",
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
					url : "${ctx }/admin/menue/getMenueById/" + data.menue_id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						form.setData(o);
					}
				});
			} else{
				data = mini.clone(data);
				if(data.par_menue_id){
					mini.getbyName("par_menue_id").setValue(data.par_menue_id);
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
                    url: '${ctx}/admin/menue/check',
                    async : false, 
                    data:{menueNm:e.value,menuId:mini.get("menue_id").getValue()},
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