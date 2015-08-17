<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<jsp:include page="/meta.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
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
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
				<a class="mini-button" iconCls="icon-add" onclick="add()">增加</a> 
				<a class="mini-button" iconCls="icon-edit" onclick="edit()">修改</a> 
				<a class="mini-button" iconCls="icon-remove" onclick="remove()">删除</a>
				 <a  class="mini-button" onclick="apply()">应用</a>   </td> 
			</tr>
		</table>
	</div>

	<div class="mini-fit">
		<div id="menuTreeGrid" class="mini-treegrid"
			style="width: 100%; height: 100%;" url="${ctx}/wxMenu/list"
			showTreeIcon="true" treeColumn="menu_name" idField="menu_id"
			parentField="pid" resultAsTree="false" allowResize="true"
			expandOnLoad="true">
			<div property="columns">
				<div type="indexcolumn"></div>
				<div name="menu_name" field="menu_name" width="120"	headerAlign="center" allowSort="true">菜单名称</div>
				<div field="type" width="120" headerAlign="center" allowSort="true" renderer="onDict">菜单类型</div>
				<div field="url" width="120" headerAlign="center"	allowSort="true">触发的关键词或链接地址</div> 
				<div field="keyword" width="120" headerAlign="center"	allowSort="true">关键字</div> 
				<!--  <div field="KEYWORD" width="120" headerAlign="center"
					renderer="onStateRenderer" allowSort="true">是否启用</div>
					-->
			</div>
		</div>
	</div>


	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("menuTreeGrid");
		grid.sortBy("menu_id", "asc");
		grid.load();
		
		
		function add() {
			var row = grid.getSelected();
			//查询一级菜单不能超过3个 二级菜单不能超过5个 
			if (row) {
				if (row.pid == -1) { 
					$.post("${ctx}/wxMenu/getChilds/" + row.menu_id, function(result) {
						if (result != null && result.length > 4) {
							alert("每个一级菜单最多包含5个二级菜单");
						} else {
							var data = {
								action : "new",
								parentId : row.menu_id,
								type : "leaf"
							};
							mini.open({
								url : "${ctx}/wxMenu/add",
								title : "新增",
								width : 650,
								height : 350,
								onload : function() {
									var iframe = this.getIFrameEl();
									iframe.contentWindow.SetData(data);
								},
								ondestroy : function(action) {
									grid.reload();
								}
							});
						}
					});
				}
			} else {
				$.post("${ctx}/wxMenu/getMenuSize", function(result) {
					if (result != null && result.length > 3) {
						alert("一级菜单最多为3个");
					} else {
						var data = {
							action : "new",
							parentId : -1,
							type : "root"
						};
						mini.open({
							url : "${ctx }/wxMenu/add",
							title : "新增",
							width : 650,
							height : 350,
							onload : function() {
								var iframe = this.getIFrameEl();
								iframe.contentWindow.SetData(data);
							},
							ondestroy : function(action) {
								grid.reload();
							}
						});
					}
				});
			}
		}

		function edit() {
			var row = grid.getSelected();
			if (row) {
				var data = {
					action : "edit",
					menu_id : row.menu_id
				};
				data.menu_id = row.menu_id;
				mini.open({
					url : "${ctx}/wxMenu/edit",
					title : "编辑",
					width : 650,
					height : 350,
					onload : function() {
						var iframe = this.getIFrameEl();
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

		 //////////// /////////////////////////////////////
        var dictMap = new Map();
		function onDict(e) {
			if (e.column.field == 'type'){
				return getDict(e, e.column.field, "MENU_TYPE");
			} 
				
		}

		var addWindow = mini.get("addWindow");
		var editWindow = mini.get("editWindow");


		//重置窗口
		function reset() {
			addWindow.reset();
		}

		//删除选中记录
		function remove() {
			var row = grid.getSelected();
			if (row) {
				//删除之前验证所选记录是否存在
				$.post("${ctx}/menu/isExits/" + row.menu_id, function(msg) {
					if (msg) {
						//是否存在子节点
						$.post("${ctx}/wxMenu/hasChild/" + row.menu_id, function(
								checkMsg) {
							if (checkMsg) {
								if (confirm("确定删除菜单？")) {
									//删除选中记录
									$.post("${ctx}/wxMenu/delete/" + row.menu_id,
											function(result) {
												if (result) {
													alert('删除成功');
													grid.reload();
												} else {
													alert('删除失败');
												}
											});
								}
							} else {
								alert('不能删除拥有二级菜单的一级菜单');
							}
						});
					} else {
						alert('您选择的记录已经不存在');
					}
				});
			} else {
				alert("请选中一条记录");
			}
		}
		//根据菜单名称查询
		function search() {

			var key = document.getElementById("key").value;
			notify(key);
			grid.load({
				key : key
			});
		}
		$("#key").bind("keydown", function(e) {
			if (e.keyCode == 13) {
				search();
			}
		});
		///////////////////////////////////////////////////////
		//重置查询条件
		function reset() {
			$("#key").val("");
		}

		//////////// /////////////////////////////////////

		//右下角弹出提示信息
		function notify(mes) {
			mini.showMessageBox({
				showModal : false,
				width : 250,
				title : "提示",
				iconCls : "mini-messagebox-warning",
				message : mes,
				timeout : 3000,
				x : "right",
				y : "bottom"
			});
		}

		//菜单的应用
		function apply() {
			$.post("${ctx}/wxMenu/apply", function(result) {
				if (result) {
					notify("菜单应用成功");
				} else {
					notify("菜单应用失败");
				}
			}, 'json');
		}
	</script>
</body>
</html>