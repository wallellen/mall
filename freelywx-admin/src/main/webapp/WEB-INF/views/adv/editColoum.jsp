<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
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
        <input name="coloum_id" id="coloum_id" class="mini-hidden" />
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:100px;">栏目名称：</td>
                    <td style="width:150px;">    
                        <input name="coloum_name" class="mini-textbox" required="true" emptyText="请输入栏目名称"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">栏目编码：</td>
                    <td style="width:150px;">    
                        <input name="coloum_code" class="mini-textbox" required="true" emptyText="请输入栏目编码"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">所属类型：</td>
                    <td style="width:150px;">    
                        <input name="type" id="type" class="mini-comboBox" url="${ctx}/combox/dict/COLOUM_TYPE" required="true"  />
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">状态：</td>
                    <td style="width:150px;">    
                        <input name="status" id="status" class="mini-comboBox" url="${ctx}/combox/dict/STATE" required="true"  />
                    </td>
                </tr>
                <tr>
                    <td>描述：</td>
                    <td>    
                        <input name="desciption"  class="mini-textArea"  style="width: 300px;"  />
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
        
        function SaveData() {
            var o = form.getData();            
            form.validate();
            if (form.isValid() == false) return;
            var json = mini.encode(o);
            $.ajax({
				url : "${ctx}/adv/coloum/save",
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
                    url: "${ctx}/adv/coloum/editData?coloum_id=" + data.id,
                    cache: false,
                    success: function (text) {
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