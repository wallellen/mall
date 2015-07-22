<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>商户公众号默认设置信息</title>
<jsp:include page="/meta.jsp" />
</head>
<body>
	<!-- 搜索栏 -->
	<div style="padding-bottom: 5px;">
		<table>
			<tr>
				<td>公众号编号：</td>
				<td><input type="text" id="search_public_id" /></td>
				<td>公众号类型：</td>
				<td><input type="text" id="search_public_type" /></td>
				<td><input type="button" value="查找" onclick="search()" /></td>
				<td><input type="button" value="重置" onclick="reset()" /></td>
			</tr>
		</table>
	</div>
	<!--工具栏  -->
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
					<c:if test="${userType=='system'}">
						<a class="mini-button" iconCls="icon-add" onclick="add()">新增信息</a> 
						<a class="mini-button" iconCls="icon-edit" onclick="edit()">修改信息</a> 
						<a class="mini-button" iconCls="icon-edit" onclick="deletes()">删除信息</a>
					</c:if>
					<c:if test="${userType=='seller'}">
						<a class="mini-button" iconCls="icon-edit" onclick="edit()">修改信息</a> 
					</c:if>
				</td>
			</tr>
		</table>
	</div>
	<!-- 展示栏 ，展示所有模板信息-->
	<div class="mini-fit">
		<div id="mercahntDategrid" class="mini-datagrid"
			style="width: 100%; height: 100%;" allowResize="true"
			url="${ctx}/merchant/info/list" idField="public_id"
			multiSelect="true">
			<div property="columns">
				<div type="indexcolumn"></div>
				<!-- <div type="checkcolumn"></div> -->
				<div field="user_id" headerAlign="center" allowSort="true">用户编号</div>
				<div field="public_name" headerAlign="center" allowSort="true">公众号名称</div>
				<div field="original_id" headerAlign="center" allowSort="true">原始公众号</div>
				<div field="wx_number" headerAlign="center" allowSort="true">微信号</div>
				<div field="app_id" headerAlign="center" allowSort="true">app_id</div>
				<div field="app_secret" headerAlign="center" allowSort="true">app_secret</div>
				<!-- <div field="matching" headerAlign="center" allowSort="true">匹配</div>
				<div field="lbs" headerAlign="center" allowSort="true">lbs</div> -->
				<div field="token" headerAlign="center" allowSort="true">token</div>
				<!-- <div field="portrait_url" headerAlign="center" allowSort="true">portrait_url</div> -->
				<div field="port_url" headerAlign="center" allowSort="true">port_url</div>
				<!-- <div field="public_type" headerAlign="center" allowSort="true">公众号类型</div>
				<div field="qr_url" headerAlign="center" allowSort="true">qr_url</div>
				<div field="ur_text" headerAlign="center" allowSort="true">ur_text</div> -->
			</div>
		</div>
	</div>
	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("mercahntDategrid");
		grid.load();

		function search() {
			grid.load({
				public_id : $("#search_public_id").val(),
				public_type : $("#search_public_type").val(),
			});
		}
		//重置
		function reset() {
			$("#search_public_id").val("");
			$("#search_public_type").val("");
		}

		var addWindow = mini.get("addWindow");
		var editWindow = mini.get("editWindow");

		//add，添加
		function add() {
			var data = { action : "new"  };
			mini.open({
				url : "${ctx }/merchant/info/edit",
				title : "新增",
				width : 650,
				height : 500,
				onload : function() {
					var iframe = this.getIFrameEl();
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}

		/*编辑方法 */
		function edit() {
			var row = grid.getSelected();
			if (row) {
				var data = { action : "edit", user_id : row.user_id  };
				mini.open({
					url : "${ctx }/merchant/info/edit",
					title : "编辑",
					width : 650,
					height : 500,
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

		function deletes() {
			var row = grid.getSelected();
			if (row) {
				//删除之前验证所选记录是否存在
				$.post('${ctx}/merchant/info/delCheckExits/'
						+ row.public_id, function(checkmsg) {
					if (checkmsg) {
						if (confirm("确定删除？")) {
							//删除
							$.post('${ctx}/merchant/default/delete/'
									+ row.public_id, function(data) {
								if (data) {
									notify('删除成功!');
									grid.reload();
								} else {
									notify('删除失败!');
								}
							});
						}

					} else {
						notify('所选记录不存在');
					}
				});
			} else {
				alert("请选中一条记录");
			}
		}
	</script>
</body>
</html>