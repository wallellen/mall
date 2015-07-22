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
        <span>店铺名称：</span><input id="site_name" name="site_name" class="mini-textbox" emptyText="请输入广告名称" style="width: 150px;" onenter="onKeyEnter" />
        <input type="button" value="查找" onclick="search()"/>
    </div>
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
					<a class="mini-button" iconCls="icon-add" onclick="add()">增加</a> 
					<a class="mini-button" iconCls="icon-edit" onclick="edit()">编辑</a> 
					<a class="mini-button" iconCls="icon-remove" onclick="remove()">删除</a>
					<a class="mini-button" iconCls="icon-detail" onclick="remove()">详情</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="mini-fit">
		<div id="datagrid1" class="mini-datagrid"
						style="width: 100%; height: 100%;" allowResize="true"
						url="${ctx }/site/list" idField="site_id" multiSelect="true">
						<div property="columns">
							<div type="indexcolumn"></div>
							<div type="checkcolumn"></div>
							<div field="site_name" width="120" headerAlign="center" align="center" allowSort="true">商圈</div>
							<div field="provincename" width="160" headerAlign="center" align="center" allowSort="true">省份</div>
							<div field="cityname" width="160" headerAlign="center" align="center" allowSort="true">城市</div>
							<div field="districtname" width="160" headerAlign="center" align="center" allowSort="true">区</div>
							<div field="address" width="160" headerAlign="center"  align="center" allowSort="true">地址</div>
							<div field="description" width="160" headerAlign="center" align="center" allowSort="true">描述</div>
							<div field="sort" width="160" headerAlign="center" align="center" allowSort="true">sort</div>
						</div>
					</div>
	</div>

	<script type="text/javascript">
		mini.parse();
    	var grid = mini.get("datagrid1");
    	grid.load();
		function add() {
			mini.open({
				url : "${ctx}/site/edit",
				title : "新增",
				width : "100%",
				height : "100%",
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
					url : "${ctx}/site/edit",
					title : "编辑",
					width : "100%",
					height : "100%",
					onload : function() {
						var iframe = this.getIFrameEl();
						var data = {
							action : "edit",
							site_id : row.site_id
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
						url : "${ctx}/site/delete/" + row.site_id,
						success : function(text) {
							if(!text){
								alert("服务器繁忙，请稍后重试");
							}else{
								notify("操作成功");
							}
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
		function search() {
			var store_name = mini.get("site_name").getValue();
			grid.load({
				site_name : site_name
			});
		}
		function onKeyEnter(e) {
			search();
		}
	</script>
</body>
</html>