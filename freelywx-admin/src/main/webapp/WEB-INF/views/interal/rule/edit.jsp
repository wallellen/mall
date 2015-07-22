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
        <input name="interal_rule_id" id="interal_rule_id" class="mini-hidden" value="0"/>
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:100px;">积分规则代码：</td>
                    <td style="width:150px;">    
                        <input name="interal_rule_code" class="mini-textbox" required="true"  emptyText="请输入名称" onvalidation="checkName"  maxLength="256"  enabled=false/>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">积分规则名称：</td>
                    <td style="width:150px;">    
                        <input name="interal_rule_name" class="mini-textbox" required="true"  emptyText="请输入名称" onvalidation="checkName"  maxLength="256"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">积分数量：</td>
                    <td style="width:150px;">    
                        <input name="interal_rule_value" class="mini-textbox" required="true"  vtype="int"/>
                    </td>
                </tr>
                <tr>
                    <td>有效时间范围：</td>
                    <td>    
                        <input name="rule_start_time"  class="mini-datepicker"  style="width: 100px;" required="true"  vtype="date:yyyy-MM-dd" />
                        至
                        <input name="rule_end_time"  class="mini-datepicker"  style="width: 100px;" required="true"  vtype="date:yyyy-MM-dd"/>
                    </td>
                </tr>
                <tr>
                    <td>使用时间范围：</td>
                    <td>    
                        <input name="use_start_time"  class="mini-datepicker"  style="width: 100px;" required="true"  vtype="date:yyyy-MM-dd" />
                        至
                        <input name="use_end_time"  class="mini-datepicker"  style="width: 100px;" required="true"  vtype="date:yyyy-MM-dd"/>
                    </td>
                </tr>
                <tr>
                    <td>简介：</td>
                    <td>    
                        <input name="interal_rule_desc"  class="mini-textArea"  style="width: 300px;" maxLength="256"/>
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
            var json = mini.encode(o);
            json = json.replace(/T00:00:00/g,' 00:00:00');
            if (form.isValid() == false) return;
            $.ajax({
				url : "${ctx}/interal/rule/save",
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
                    url: "${ctx}/interal/rule/getEditR?interal_rule_id=" + data.interal_rule_id,
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
                    url: "${ctx}/interal/rule/checkName",
                    data : {"interal_rule_name":e.value,"interal_rule_id":mini.get("interal_rule_id").getValue()},
                    cache: false,
                	async: false,
                    success: function (text) {
                    	if(!text){
                    		 e.errorText = "该名称已经存在!";
                             e.isValid = false;
                    	}
                    }
                });
            }
		}
    </script>
</body>
</html>