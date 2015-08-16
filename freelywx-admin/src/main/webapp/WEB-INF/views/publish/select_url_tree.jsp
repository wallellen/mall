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
    <title>图文列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" /><link href="../demo.css" rel="stylesheet" type="text/css" />
    <script src="../../scripts/boot.js" type="text/javascript"></script> 
    
    <style type="text/css">
    body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }    
    .header
    {
        background:url(../header.gif) repeat-x 0 -1px;
    }
    .Note
    {
        background:url(Notes_Large.png) no-repeat;width:32px;height:32px;
    }
    .Reports
    {
        background:url(Reports_Large.png) no-repeat;width:32px;height:32px;
    }
    </style>    
</head>
<body >   
  
<ul id="leftTree" class="mini-tree" url="${ctx}/templatelist/list" style="width:300px;margin-top: 10px;" 
	        showTreeIcon="true" textField="titleName" parentField="pid" idField="id"    onrowdblclick="onRowDblClick"
			expandOnLoad="true" resultAsTree="false" onnodeselect="onItemSelect">        
	     </ul>
    
    
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">确定</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
    
</body>
</html>
    
    <script type="text/javascript">
        mini.parse(); 
        var tree = mini.get("leftTree");  
   
        
        /*
        function onItemSelect(e) {
            var node = tree.getSelectedNode();
            
            if("2"==node.type)	//如果是文章详情结点
        	{ 
            	$.ajax({
    				url : "${ctx }/tempinfolist/" + node.selfid,
    				cache : false,
    				success : function(text) {
    					var o = mini.decode(text);
    					form.setData(o);
    					
    					mini.getbyName("temp_info_id").setValue(o.temp_info_id);
    					
    					
    					//用模板的ID得到模板的名字
						$.ajax({
							url : "${ctx }//tempinfo/" + o.temp_info_id,
							cache : false,
							success : function(text)
							{
								var data4 = mini.decode(text);
								mini.getbyName("temp_info_id").setText(data4.info_name);
		    					
							}
						});
						
    					
    					
    					
    				}
    			});
        	}
        	
        }
    */    
        
        
        
        function GetData() {
    		var node = tree.getSelectedNode();
            return node;
        }

        
        function onRowDblClick(e) {
            onOk();
        }
        //////////////////////////////////
        function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }

        function onOk() {
            CloseWindow("ok");
        }
        function onCancel() {
            CloseWindow("cancel");
        }

        
    </script>
