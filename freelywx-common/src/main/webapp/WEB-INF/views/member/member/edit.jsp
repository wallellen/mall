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
        <input name="member_id" id="member_id" class="mini-hidden" value="${memberR.member_id }"/>
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:100px;">会员名称：</td>
                    <td style="width:150px;">    
                    	${memberR.member_name }
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">标签：</td>
                    <td style="width:150px;">    
                        <input name="member_tag" class="mini-textbox" required="true"  maxLength="256" value="${memberR.member_tag }"/>
                    </td>
                </tr>
                <tr>
                    <td>等级简介：</td>
                    <td>    
                        <input name="member_desc"  class="mini-textArea"  style="width: 300px;" maxLength="2000" value="${memberR.member_desc }"/>
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
				url : "${ctx}/member/member/save",
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