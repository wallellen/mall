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
	<div class="mini-toolbar"
		style="text-align: center; line-height: 30px;"
		borderStyle="border-left:0;border-top:0;border-right:0;">
		<label>名称：</label> <input id="key" class="mini-textbox"
			style="width: 150px;" /> <a class="mini-button" style="width: 60px;"
			onclick="search()">查询</a>
	</div>
	<div class="mini-fit">
		<ul id="tree" class="mini-tree" iconField="icon_cls"
			url="${ctx}/prodCate/list" style="width: 100%; height: 100%;"
			showTreeIcon="true" textField="category_name" idField="category_id"
			parentField="parent_category_id" resultAsTree="false"
			showRadioButton="true" onbeforenodeselect="onBeforeNodeSelect"
			showFolderCheckBox="true" expandOnLoad="true">
		</ul>

	</div>
	<div class="mini-toolbar"
		style="text-align: center; padding-top: 8px; padding-bottom: 8px;"
		borderStyle="border-left:0;border-bottom:0;border-right:0;">
		<a class="mini-button" style="width: 60px;" onclick="onOk()">确定</a> <span
			style="display: inline-block; width: 25px;"></span> <a
			class="mini-button" style="width: 60px;" onclick="onCancel()">取消</a>
	</div>
</body>
</html>
<script type="text/javascript">
	mini.parse();
	var tree = mini.get("tree");
	var categroy_id = "${category_id}";
	var category_pid = "${default_category_id}";

	if (category_pid) {
		tree.selectNode(category_pid);
	}
	function GetData() {
		var node = tree.getSelectedNode();
		return node;
	}
	function SetData() {
		var node = tree.getSelectedNode();
		return node;
	}

	function search() {
		var key = mini.get("key").getValue();
		if (key == "") {
			tree.clearFilter();
		} else {
			key = key.toLowerCase();
			tree.filter(function(node) {
				var text = node.category_name ? node.category_name
						.toLowerCase() : "";
				if (text.indexOf(key) != -1) {
					return true;
				}
			});
		}
	}
	//////////////////////////////////

	function onBeforeNodeSelect(e) {
		var tree = e.sender;
		var node = e.node;
		if (categroy_id && node.category_id == categroy_id) {
			e.cancel = true;
		}
	}

	function CloseWindow(action) {
		if (window.CloseOwnerWindow)
			return window.CloseOwnerWindow(action);
		else
			window.close();
	}

	function onOk() {
		CloseWindow("ok");
	}
	function onCancel() {
		CloseWindow("cancel");
	}
</script>