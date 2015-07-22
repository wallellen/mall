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
	 <form id="form1" method="post">
        <input name="prod_type_id" id="prod_type_id" class="mini-hidden" />
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:100px;">标签名称：</td>
                    <td style="width:150px;">    
                        <input name="type_name" class="mini-textbox" required="true" onvalidation="checkName" emptyText="请输入名称"/>
                    </td>
                </tr>
               <!--  <tr>
                     <td>排序：</td>
                     <td>    
                         <input name="sort" class="mini-textbox"  vtype="int"  emptyText="请输入排序序号"/>
                     </td>
                </tr> -->
                <tr>
                    <td>标签说明：</td>
                    <td>    
                        <input name="description"  class="mini-textArea"  style="width: 300px;"  />
                    </td>
                </tr> 
            </table>
        </div>
    
        <div style="text-align:center;padding:10px;">               
            <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>       
            <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>
     <script type="text/javascript">
        mini.parse();
        var form = new mini.Form("form1");

        function onDrawCell(e) {
            var item = e.record, field = e.field, value = e.value;
            //组织HTML设置给cellHtml
            e.cellHtml = '<span class="'+e.value+' myiconspan">'+value+'</span>';   
        }
        
        function SaveData() {
            var o = form.getData();            
            form.validate();
            var json = mini.encode(o);
            if (form.isValid() == false) return;
            $.ajax({
				url : "${ctx}/prodType/save",
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
        //标准方法接口定义
        function SetData(data) {
            if (data.action == "edit") {
                //跨页面传递的数据对象，克隆后才可以安全使用
                data = mini.clone(data);
                $.ajax({
                    url: "${ctx}/prodType/prodType?prodTypeId=" + data.id,
                    cache: false,
                    success: function (text) {
                        var o = mini.decode(text);
                        form.setData(o);
                        form.setChanged(false);
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
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();            
        }
        function onOk(e) {
            SaveData();
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }
        function checkName(e){
			if (e.isValid) {
				$.ajax({
                    url: "${ctx}/prodType/check",
                    data : {"typeName":e.value,"typeId":mini.get("prod_type_id").getValue()},
                    cache: false,
                	async: false,
                    success: function (text) {
                    	if(!text){
                    		 e.errorText = "该标签名称已经存在!";
                             e.isValid = false;
                    	}
                    }
                });
            }
		}


    </script>
</body>
</html>