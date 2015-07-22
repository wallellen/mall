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
        <span>栏目名称：</span><input id="key" name="coloum_name" class="mini-textbox" emptyText="请输入栏目名称" style="width: 150px;" onenter="onKeyEnter" />
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
		<div id="datagrid1" class="mini-datagrid"
						style="width: 100%; height: 100%;" allowResize="true"
						url="${ctx }/adv/coloum/list" idField="coloum_id" multiSelect="true">
						<div property="columns">
							<div type="indexcolumn"></div>
							<div type="checkcolumn"></div>
							<div field="coloum_name" width="120" headerAlign="center" align="center" allowSort="true">栏目名称</div>
							<div field="coloum_code" width="120" headerAlign="center" align="center" allowSort="true">栏目编码</div>
							<div field="type" width="160" headerAlign="center" renderer="onDict"  align="center" allowSort="true">所属类型</div>
							<div field="desciption" width="160" headerAlign="center" align="center" allowSort="true">描述</div>
							<div field="status" width="120" headerAlign="center" renderer="onDict" align="center" allowSort="true">状态</div>
							
							<!-- <div name="action" width="120" headerAlign="center" align="center"	renderer="onActionRenderer" cellStyle="padding:0;">操作</div> -->
						</div>
					</div>
	</div>

	<script type="text/javascript">
		mini.parse();
    	var grid = mini.get("datagrid1");
    	grid.load();
		function add() {
			mini.open({
				url : "${ctx}/adv/coloum/edit",
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
					url : "${ctx}/adv/coloum/edit",
					title : "编辑",
					width : 600,
					height : 450,
					onload : function() {
						var iframe = this.getIFrameEl();
						var data = {
							action : "edit",
							id : row.coloum_id
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
						url : "${ctx}/adv/coloum/delete?coloum_id=" + row.coloum_id,
						success : function(text) {
							if(text.status == "0"){
								alert("服务器繁忙，请稍后重试");
							}else if(text.status == "1"){
								alert("栏目关联有广告，请删除关联关系后再进行操作");
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
				coloum_name : key
			});
		}
		function onKeyEnter(e) {
			search();
		}
		
		var dictMap = new Map();
		function onDict(e){
			if (e.column.field=='status'){
				return getDict (e,e.column.field,"STATE");
			}
			if (e.column.field=='type'){
				return getDict (e,e.column.field,"COLOUM_TYPE");
			}
		}
	</script>
</body>
</html>