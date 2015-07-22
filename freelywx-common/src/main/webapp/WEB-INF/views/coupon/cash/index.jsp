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
	<div style="padding-bottom:5px;">
        <span>现金劵名称：</span>
		<input id="key" name="cash_coupon_name" class="mini-textbox" emptyText="请输入现金劵名称" style="width: 150px;" onenter="onKeyEnter" /> 
        <input type="button" value="查找" onclick="search()"/>
    </div>
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
					<a class="mini-button" iconCls="icon-add" onclick="add()">增加</a> 
					<a class="mini-button" iconCls="icon-edit" onclick="edit()">编辑</a> 
					<a class="mini-button" iconCls="icon-remove" onclick="remove()">删除</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="mini-fit">

		<div id="datagrid1" class="mini-datagrid" iconField="icon_cls"	 style="width: 100%; height: 100%;" allowResize="true"
			url="${ctx}/coupon/cash/list" idField="member_id" multiSelect="true">

			<div property="columns">
				<div type="indexcolumn" headerAlign="center">序号</div>
				<div field="cash_coupon_id" name="name" align="left" headerAlign="left" allowSort="true">现金劵编号</div>
				<div field="cash_coupon_name" align="left" headerAlign="left" allowSort="true">现金劵名称</div>
				<div field="cash_coupon_value" align="center" headerAlign="center" allowSort="true" renderer="gridPriceRender" >面额(元)</div>
				<div field="cash_coupon_sum" align="center" headerAlign="center" allowSort="true">发行量(张)</div>
				<div field="cash_coupon_start_time" align="center" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd"  width="80">有效开始时间</div>
				<div field="cash_coupon_end_time" align="center" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd"  width="80">有效结束时间</div>
				<div field="cash_coupon_desc" align="left" headerAlign="left" allowSort="true">备注</div>
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
				cash_coupon_name : key
			});
		}
		function onKeyEnter(e) {
			search();
		}
		function add() {
			mini.open({
				url : "${ctx}/coupon/cash/edit",
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
					url : "${ctx}/coupon/cash/edit",
					title : "编辑",
					width : 600,
					height : 360,
					onload : function() {
						var iframe = this.getIFrameEl();
						var data = {
							action : "edit",
							cash_coupon_id : row.cash_coupon_id
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
		function remove() {
			var row = grid.getSelected();
			if (row) {
				if (confirm("确定删除选中记录？")) {
					grid.loading("操作中，请稍后......");
					$.ajax({
						url : "${ctx}/coupon/cash/delete?cash_coupon_id=" + row.cash_coupon_id,
						success : function(text) {
							grid.reload();
						},
						error : function() {
						}
					});
				}
			} else {
				alert("请选中一条记录");
			}
		}
	</script>
</body>
</html>