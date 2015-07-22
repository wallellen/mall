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
	<div style="padding-bottom:5px;">
        <span>品牌名称：</span><input id="key" name="brand_name" class="mini-textbox" emptyText="请输入品牌名称" style="width: 150px;" onenter="onKeyEnter" />
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
		<div id="datagrid1" class="mini-datagrid" iconField="icon_cls"	 style="width: 100%; height: 100%;"
			url="${ctx}/prodBrand/list"   idField="brand_id" >
			<div property="columns">
				<div type="indexcolumn" headerAlign="center">序号</div>
				<div field="brand_name"   align="left" headerAlign="center" allowSort="true">品牌名称</div>
				<div field="brand_name_en"   align="left" headerAlign="center" allowSort="true">英文名称</div>
				<div field="display_order"   align="left" headerAlign="center" allowSort="true">品牌排序</div>
				<div field="description" align="center" headerAlign="center" allowSort="true">标签说明</div> 
				<div field="create_time" dateFormat="yyyy-MM-dd HH:mm:ss" align="center" headerAlign="center" allowSort="true">创建时间</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		mini.parse();
    	var grid = mini.get("datagrid1");
    	grid.load();
		function add() {
			mini.open({
				url : "${ctx}/prodBrand/edit",
				title : "新增",
				width : 600,
				height : 450,
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
					url : "${ctx}/prodBrand/edit",
					title : "编辑",
					width : 600,
					height : 450,
					onload : function() {
						var iframe = this.getIFrameEl();
						var data = {
							action : "edit",
							id : row.brand_id
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
						url : "${ctx}/prodBrand/delete?brandId=" + row.brand_id,
						success : function(text) {
							if(text.status == "0"){
								alert("服务器繁忙，请稍后重试");
							}else if(text.status == "1"){
								alert("品牌关联有商品，请删除关联关系后再进行操作");
							}else if(text.status == "2"){
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
			var key = mini.get("key").getValue();
			grid.load({
				brand_name : key
			});
		}
		function onKeyEnter(e) {
			search();
		}
	</script>
</body>
</html>