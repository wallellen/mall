<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<jsp:include page="/meta.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>联系人信息</title>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}
</style>
</head>
<body>
<div style="width:100%;">
    <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="mini-button" iconCls="icon-add" onclick="add()">增加</a>
                    <a class="mini-button" iconCls="icon-edit" onclick="edit()">修改</a>
                    <a class="mini-button" iconCls="icon-remove" onclick="remove()">删除</a>
                </td>
                <td style="white-space:nowrap;">
                    <input id="names" class="mini-textbox" emptyText="请输入姓名" style="width:150px;" onenter="onKeyEnter"/>
                    <input id="open_ids" class="mini-textbox" emptyText="请输入微信标识" style="width:150px;" onenter="onKeyEnter"/>
                    <a class="mini-button" onclick="search()">查询</a>
                    <a class="mini-button" onclick="reset()">重置</a>
                </td>
            </tr>
        </table>           
    </div>
</div>

<div class="mini-fit" >
<div id="datagrid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true" url="${ctx}/merchant/contacts/list"  idField="contacts_id" multiSelect="true" >
    <div property="columns">
        <!-- <div type="indexcolumn"></div> -->
        <div type="checkcolumn"></div>
        <div field="user_id" width="120" headerAlign="center" allowSort="true">商户编号</div>
        <div field="name" width="120" headerAlign="center" allowSort="true">联系人姓名</div>
        <div field="open_id" width="120" headerAlign="center" allowSort="true">微信标识</div>
    </div>
</div>
</div>

<div id="addWindow" class="mini-window" title="添加联系人" style="width: 350px;" showModal="true" allowResize="true" allowDrag="true">
	<div id="addform" class="form">
		<input class="mini-hidden" name="contacts_id" />
		<table style="width: 100%;">
			<%-- <tr>
				<td>所属商户：</td>
				<td><input id="user_id" name="user_id" class="mini-combobox" textField="public_name" valueField="user_id" url="${ctx}/merchant/contacts/getMerchant" value="1" required="true"/></td>
			</tr> --%>
			<tr>
				<td>联系人姓名：</td>
				<td><input id="name" name="name" class="mini-textbox"  required="true" /></td>
			</tr>
			<tr>
				<td>微信标识：</td>
				<td><input id="open_id" name="open_id" class="mini-textbox"  required="true" /></td>
			</tr>
			<tr>
				<td></td>
				<td><input value="提交" type="button" onclick="submitAddForm()" /> &nbsp; <input value="重置" type="button" onclick="resetForm()"/></td>
			</tr>
		</table>
	</div>
</div>

<div id="editWindow" class="mini-window" title="编辑关键字" style="width: 350px;" showModal="true" allowResize="true" allowDrag="true">
	<div id="editform" class="form">
		<input class="mini-hidden" name="contacts_id" />
		<table style="width: 100%;">
			<%-- <tr>
				<td>所属商户：</td>
				<td><input id="user_id" name="user_id" class="mini-combobox" textField="public_name" valueField="user_id" url="${ctx}/merchant//contacts/getMerchant" value="1" required="true"/></td>
			</tr> --%>
			<tr>
				<td>联系人姓名：</td>
				<td><input id="name" name="name" class="mini-textbox"  required="true" /></td>
			</tr>
			<tr>
				<td>微信标识：</td>
				<td><input id="open_id" name="open_id" class="mini-textbox"  required="true" /></td>
			</tr>
			<tr>
				<td></td>
				<td><input value="提交" type="button" onclick="submitEditForm()" /> &nbsp; <input value="重置" type="button" onclick="resetForm()"/></td>
			</tr>
		</table>
	</div>
</div>

<script type="text/javascript">
    mini.parse();
    
    var grid = mini.get("datagrid");
    grid.load();

    var addform = new mini.Form("#addform");
	var addWindow = mini.get("addWindow");
    var editform = new mini.Form("#editform");
	var editWindow = mini.get("editWindow");

    function add() { addWindow.show(); }
    function submitAddForm() {
    	addform.validate();
        if (addform.isValid() == false) return;
        var data = addform.getData(true);
        $.ajax({
            url: "${ctx}/merchant/addContacts",
            type: "post",
            data:data,
            success: function (result) {
            	if(result){
            		notify("新增成功");
            	}else{
            		notify("新增失败");
            	}
            	resetForm();
            	addWindow.hide();
            	grid.load();
            }
        });
    }
   
    function edit() {
		var rows = grid.getSelecteds();
		if (rows.length==1) {
			editWindow.show();
			var form = new mini.Form("#editform");
			form.clear();
			form.loading();
			$.ajax({
				url: "${ctx}/merchant/getOneContacts?id="+rows[0].contacts_id,
				success : function(text) {
					form.unmask();
					var o = mini.decode(text);
					form.setData(o);
				},
				error : function() {
					alert("表单加载错误");
					form.unmask();
				}
			});
		} else {
			alert("请选中一条记录");
		}

	}
    function submitEditForm() {
    	editform.validate();
        if (editform.isValid() == false) return;
        var data = editform.getData(true);
        $.ajax({
            url: "${ctx}/merchant/updContacts",
            type: "post",
            data: data,
            success: function (result) {
            	if(result){
            		notify("修改成功");
            	}else{
            		notify("修改失败");
            	}
            	resetForm();
            	editWindow.hide();
            	grid.load();
            }
        });
    }

    function resetForm() {
    	addform.reset();
    	editform.reset();
    }
    
    function remove() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            if (confirm("确定删除选中记录？")) {
                var ids = [];
                for (var i = 0, l = rows.length; i < l; i++) {
                    var r = rows[i];
                    ids.push(r.contacts_id);
                }
                var id = ids.join(',');
                grid.loading("操作中，请稍后......");
                $.ajax({
                    url: "${ctx}/merchant/delContacts?ids=" +ids,
                    success: function (text) {
                    	if(text){
                        	grid.reload();
                        }else{
                        	notify("删除失败");
                        }
                    },
                    error: function () {
                    	notify("删除失败");
                    }
                });
            }
        } else {
            alert("请最少选中一条记录");
        }
    }
     
    function notify(mes) {
        mini.showMessageBox({
            showModal: false,
            width: 250,
            title: "提示",
            iconCls: "mini-messagebox-warning",
            message: mes,
            timeout: 2000,
            x: "right",
            y: "bottom"
        });
    }
    
    //查询
    function onKeyEnter(e) { search(); }
    function search() {
        var open_ids = mini.get("open_ids").getValue();
        var names = mini.get("names").getValue();
        grid.load({ open_id: open_ids, name : names });
    }
    
    function reset(){
    	mini.get("open_ids").setValue("");
    	mini.get("names").setValue("");
    }
    
</script>

</body>
</html>