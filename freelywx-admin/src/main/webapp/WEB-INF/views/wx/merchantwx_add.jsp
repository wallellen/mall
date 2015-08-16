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
	                <td style="width:80px;">公众号名称 ：</td>
	                <td style="width:150px;">
	                	<input name="public_name" class="mini-textbox" required="true" />
	                </td>
	         </tr>
	            
	         
	         <tr>
	                <td style="width:80px;">公众原始号ID ：</td>
	                <td style="width:150px;">
	                	<input name="original_id" class="mini-textbox" required="true" />
	                </td>
	         </tr>
	           
	           
	          <tr>
	                <td style="width:80px;">微信号：</td>
	                <td style="width:150px;">
	                	<input name="wx_number" class="mini-textbox" required="true" />
	                </td>
	         </tr>
	           
	            
	            
	            <tr>
	                <td style="width:80px;">app_id：</td>
	                <td style="width:150px;">
	                	<input name="app_id" class="mini-textbox" required="true" />
	                </td>
	         </tr>
	           
	          
	            <tr>
	                <td style="width:80px;">token:</td>
	                <td style="width:150px;">
	                	<input name="token" class="mini-textbox" required="true" />
	                </td>
	           </tr>
	           
	           
	           
	           
	            <tr>
	                <td style="width:80px;">encodekey:</td>
	                <td style="width:150px;">
	                	<input name="encodekey" class="mini-textbox" required="true" />
	                </td>
	           </tr>
	           
	           
	           
	           
	           
	            <tr>
	                <td style="width:80px;">app_secrect:</td>
	                <td style="width:150px;">
	                	<input name="app_secrect" class="mini-textbox" required="true" />
	                </td>
	           </tr>
	           
	           
	           
	            
	            <tr>
	                <td style="width:80px;">公众号类型：</td>
	                <td style="width:150px;">
	                	<input name="public_type"  url="${ctx}/combox/dict/PUBLIC_TYPE"  class="mini-combobox" required="true"/></td>
	            
	                </td>
	           </tr>
	           
	           
	            
	            <tr >
	                <td  style="text-align:center;padding-top:5px;padding-right:20px;" colspan="6">
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
	
	
	$.ajax({
        url: "${ctx}/wx/add_getdata",
        type:"POST",  
        contentType:'application/json;charset=UTF-8', 
        success: function (text) {
        	var data = mini.decode(text);   //反序列化成对象
            form.setData(data);             //设置多个控件数据
        },
        error: function (jqXHR, textStatus, errorThrown) {
        	notify("服务器繁忙，请扫后重试");
        }
    });  
	
	
	function SaveData() {
        form.validate();
        if (form.isValid() == true) {
        	var o = form.getData();
            var json = mini.encode(o);
            $.ajax({
                url: "${ctx}/wx/addsubmit",
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