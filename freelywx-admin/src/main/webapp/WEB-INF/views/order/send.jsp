<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp" %>
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
	<div class="mini-fit">
	 <form id="form1" method="post">
     <input name="order_id" id="order_id" class="mini-hidden" value="${order.order_id }"/>
	<table style="width: 100%;">
		<tr>
			<td align="right" width="30%">订单编号：</td>
			<td width="70%">${order.order_id }</td>
		</tr>
		<tr>
			<td align="right" width="30%">送货地点：</td>
			<td width="70%">${order.address }</td>
		</tr>
		<tr>
			<td align="right" width="30%">联系人：</td>
			<td width="70%">${order.shipper }</td>
		</tr>
		<tr>
			<td align="right" width="30%">联系电话：</td>
			<td width="70%">${order.phone }</td>
		</tr>
	</table>
	</form>
	</div>
        <div style="text-align:center;padding:10px;">               
            <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">发货</a>       
            <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>  
	<script type="text/javascript">
	    mini.parse();
	    var form = new mini.Form("form1");
        function SaveData() {
            var o = form.getData();            
            form.validate();
            var json = mini.encode(o);
            json = json.replace(/T00:00:00/g,' 00:00:00');
            if (form.isValid() == false) return;
            $.ajax({
				url : "${ctx}/order/sendSave",
				type : "POST",
				dataType : "json",
				contentType : 'application/json;charset=UTF-8',
				data : json,
				success : function(text) {
					if (text) {
						CloseWindow("save");
						notify("操作成功!");
					} else {
						alert("服务器繁忙，请稍后重试");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("服务器繁忙，请稍后重试");
				}
			});
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
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();            
        }
        function onOk(e) {
            SaveData();
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }
        
	</script>
</body>
</html>