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
	<!-- <div style="padding-bottom:5px;">
        <span>规则名称：</span>
		<input id="key" name="interal_rule_name" class="mini-textbox" emptyText="请输入规则名称" style="width: 150px;" onenter="onKeyEnter" /> 
        <input type="button" value="查找" onclick="search()"/>
    </div> -->
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
					<a class="mini-button" iconCls="icon-add" onclick="add()">增加</a> 
					<a class="mini-button" iconCls="icon-edit" onclick="edit()">编辑</a> 
				</td>
			</tr>
		</table>
	</div>
	<div class="mini-fit">

		<div id="datagrid1" class="mini-datagrid" iconField="icon_cls"	 style="width: 100%; height: 100%;" allowResize="true"
			url="${ctx}/integral/type/list" idField="cycle_id" multiSelect="true">

			<div property="columns">
				<div type="indexcolumn" headerAlign="center">序号</div>
				<div field="cycle_name"  align="left" headerAlign="left" allowSort="true">返积分周期类型</div>
				<div field="remark"  align="left" headerAlign="left" allowSort="true">描述</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		mini.parse();

		var grid = mini.get("datagrid1");
		grid.load();

		function search() {
			var key = mini.get("key").getValue();
			grid.load({
				interal_rule_name : key
			});
		}
		function onKeyEnter(e) {
			search();
		}
		
		function add() {
			mini.open({
				url : "${ctx}/integral/type/edit",
				title : "新增",
				width : 600,
				height : 360,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						action : "new"
					};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
		function edit() {
			var row = grid.getSelected();
			if (row) {
				mini.open({
					url : "${ctx}/integral/type/edit",
					title : "编辑",
					width : 600,
					height : 360,
					onload : function() {
						var iframe = this.getIFrameEl();
						var data = {
							action : "edit",
							cycle_id : row.cycle_id
						};
						iframe.contentWindow.SetData(data);
					},
					ondestroy : function(action) {
						grid.reload();
					}
				});
			} else {
				alert("请选中一条记录");
			}
		}
	</script>
</body>
</html>