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

	<div style="padding-bottom: 5px;">
		<span>商品名称：</span><input id="key" name="prod_name"
			class="mini-textbox"  style="width: 150px;"
			onenter="onKeyEnter" /> <input type="button" value="查找"
			onclick="search()" />
	</div>
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
				<a class="mini-button" iconCls="icon-add" onclick="add()">编辑</a> 
				<!-- <a class="mini-button" iconCls="icon-remove" onclick="remove()">删除</a> -->
				<a class="mini-button" iconCls="icon-undo" onclick="reback()">返回</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="mini-fit">
		<div id="datagrid1" class="mini-datagrid"
			style="width: 100%; height: 100%;" allowResize="true"	url="${ctx }/prodType/listSelect" idField="prod_id" multiSelect="true">
			<div property="columns">
				<div type="indexcolumn"></div>
				<div field="prod_name" width="120" headerAlign="center" align="center" allowSort="true">商品名称</div>
				<div field="prod_code" width="120" headerAlign="center" align="center" allowSort="true">商品编号</div>
				<div field="brandName" width="120" headerAlign="center" align="center" allowSort="true">商品品牌</div>
				<div field="origin" width="120" headerAlign="center" align="center" allowSort="true">产地</div>
				<div field="sale_price" width="120" headerAlign="center" align="center" renderer="gridPriceRender" allowSort="true">商品价格</div>
				<div field="descripton" width="120" headerAlign="center" align="center" allowSort="true">商品描述</div>
				<div field="create_time" width="100" dateFormat="yyyy-MM-dd HH:mm:ss" align="center" headerAlign="center">创建时间</div>
				<!-- <div field="free_shipping" width="120" headerAlign="center" align="center" allowSort="true">是否免运费</div> -->
				<div field="freigh_price" width="120" headerAlign="center" renderer="gridPriceRender"
					align="center" allowSort="true">运费</div> 

				<!-- <div name="action" width="120" headerAlign="center" align="center"	renderer="onActionRenderer" cellStyle="padding:0;">操作</div> -->
			</div>
		</div>
	</div>


	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load({prod_type_id:${prod_type_id}});

		function add() {
			mini.open({
				url : "${ctx}/prodType/bind/add" ,
				title : "商品绑定",
				width : 800,
				height : 450,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
							action : "new",
							id : ${prod_type_id}
						};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
			/* mini.open({
					url : "${ctx}/prodType/band/add" ,
					title : "绑定商品",
					width : 800,
					height : 500,
					onload : function() {
						var iframe = this.getIFrameEl();
						var data = {
							action : "new",
							id : ${prod_type_id}
						};
						iframe.contentWindow.SetData(data);
					},
					ondestroy : function(action) {
						grid.reload();
					}
				}); */
		}
		function remove() {
			var row = grid.getSelected();
			if (row) {
				if (confirm("确定删除选中记录？")) {
					grid.loading("操作中，请稍后......");
					$.ajax({
						url : "${ctx}/prodType/bind/delete?recommend_id=" + row.recommend_id,
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
		function search() {
			var key = mini.get("key").getValue();
			grid.load({
				prod_name : key
			});
		}
		function onKeyEnter(e) {
			search();
		}
		
		function reback(){
			window.location.href = "${ctx}/prodType/index";
		}
		
	</script>
</body>
</html>