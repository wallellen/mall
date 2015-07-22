<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/uilibs.jsp"%>
</head>
<body>
	 <form id="form1" method="post">
        <input name="rule_id" id="rule_id" class="mini-hidden" value="0"/>
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:100px;">会员等级名称：</td>
                    <td style="width:150px;">    
                        <input name="rule_name" class="mini-textbox" required="true"  onvalidation="checkName"  emptyText="请输入名称" maxLength="256"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">消费金额：</td>
                    <td style="width:150px;">    
                        <input name="sale_more_than" class="mini-textbox" required="true"  emptyText="请输入金额" vtype="int"/>
                    </td>
                </tr>
                <tr>
                    <td>等级简介：</td>
                    <td>    
                        <input name="rule_desc"  class="mini-textArea"  style="width: 300px;" maxLength="256"/>
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
            if (form.isValid() == false) return;
            $.ajax({
				url : "${ctx}/member/rule/save",
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
                    url: "${ctx}/member/rule/getEditR?rule_id=" + data.rule_id,
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
                    url: "${ctx}/member/rule/checkName",
                    data : {"rule_name":e.value,"rule_id":mini.get("rule_id").getValue()},
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