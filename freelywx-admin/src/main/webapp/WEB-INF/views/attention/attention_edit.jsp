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
            <input class="mini-hidden" name="wx_id"/> 
	        <table style="width:100%;">
	        
	         <tr>
	                <td style="width:80px;">用户ID ：</td>
	                <td style="width:150px;">
	                	<input name="user_id" class="mini-textbox" required="true" />
	                </td>
	                
	                
	                <td style="width:80px;">公众号名称 ：</td>
	                <td style="width:150px;">
	                	<input name="public_name" class="mini-textbox" required="true" />
	                </td>
	            </tr>
	          <tr>
	          
	        
	         
	           <tr>
	                <td style="width:80px;">公众原始号ID：</td>
	                <td style="width:150px;"><input name="original_id" class="mini-textbox" required="true"/></td>
	            
	            
	                <td style="width:80px;">微信号：</td>
	                <td style="width:150px;"><input id="wx_number"   class="mini-password" required="true"/></td>
	            
	            </tr>
	             
	            <tr>
	                <td style="width:80px;">app_id：</td>
	                <td style="width:150px;"><input name="app_id"   class="mini-textbox" required="true"/></td>
	                
	                
	                
	                <td style="width:80px;">app_secret：</td>
	                <td style="width:150px;"><input name="app_secret"   class="mini-textbox" required="true"/></td>
	            </tr>
	             
	            
	            <tr>
	                <td style="width:80px;">消息加密模式 ：</td>
	                <td style="width:150px;"><input name="encodetype" class="mini-textbox" required="true"/></td>
	                
	                
	                <td style="width:80px;">加密密钥：</td>
	                <td style="width:150px;"><input name="encodekey" class="mini-textbox" required="true"/></td>
	            </tr>
	             
	            <tr>
	                <td style="width:80px;">matchinfo：</td>
	                <td style="width:150px;"><input name="matchinfo" class="mini-textbox" required="true"/></td>
	                
	                
	                <td style="width:80px;">地理位置：</td>
	                <td style="width:150px;"><input name="lbs" class="mini-textbox" required="true"/></td>
	                
	            </tr>
	             
	            <tr>
	                <td style="width:80px;">token：</td>
	                <td style="width:150px;"><input name="token" class="mini-textbox" required="true"/></td>
	                
	                
	                <td style="width:80px;">图像地址：</td>
	                <td style="width:150px;"><input name="portrait_url" class="mini-textbox" required="true"/></td>
	                
	            </tr>
	             
	            <tr>
	                <td style="width:80px;">接口地址：</td>
	                <td style="width:150px;"><input name="port_url" class="mini-textbox" required="true"/></td>
	                
	                
	                <td style="width:80px;">公众号类型：</td>
	                <td style="width:150px;"><input name="public_type"  url="${ctx}/combox/dict/PUBLIC_TYPE"  class="mini-combobox" required="true"/></td>
	            
	            </tr>
	             
	            <tr>
	                <td style="width:80px;">二维码地址：</td>
	                <td style="width:150px;"><input name="qr_url" class="mini-textbox" required="true"/></td>
	                
	                
	                <td style="width:80px;">公众号详情说明：</td>
	                <td style="width:150px;"><input name="ur_text" class="mini-textbox" required="true"/></td>
	            
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
	
	function SaveData() {
        form.validate();
        if (form.isValid() == true) {
        	var o = form.getData();
            var json = mini.encode(o);
            $.ajax({
                url: "${ctx}/merchantwx/save",
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
				url : "${ctx }/merchantwx/" + data.wx_id,
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