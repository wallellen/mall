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
        <span>名称：</span>
		<input id="member_name" name="member_name" class="mini-textbox" emptyText="请输入会员名称"   /> 
		<span>电话号码：</span>
		<input id="mobile" name="member_name" class="mini-textbox" emptyText="请输入电话号码"   /> 
		<span>问题：</span>
		<input id="title" name="title" class="mini-textbox" emptyText="请输入问题"   /> 
        <input type="button" value="查找" onclick="search()"/>
    </div>
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
					<!-- <a class="mini-button" iconCls="icon-reload" onclick="reloadLevel()">订单详情</a>  -->
					<!-- <a class="mini-button" iconCls="icon-edit" onclick="edit()">编辑</a>  -->
				</td>
			</tr>
		</table>
	</div>
	<div class="mini-fit">

		<div id="datagrid1" class="mini-datagrid"   style="width: 100%; height: 100%;" allowResize="true"
			url="${ctx}/service/list" idField="service_id" multiSelect="true">
			<div property="columns">
				<div type="indexcolumn" headerAlign="center">序号</div>
				<div field="member_name" align="left" headerAlign="left" allowSort="true" width="50">会员名称</div>
				<div field="title" align="center" headerAlign="center" allowSort="true"  width="100">故障信息</div>
				<div field="mobile" align="center" headerAlign="center" allowSort="true"  width="50">联系电话</div>
				<div field="email" align="center" headerAlign="center" allowSort="true"  width="50">邮箱</div>
				<div field="create_time" align="center" headerAlign="center" allowSort="true" width="50" >创建时间</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		mini.parse();

		var grid = mini.get("datagrid1");
		grid.load();

		function search() {
			grid.load({
				member_name : mini.get("member_name").getValue(),
				member_name : mini.get("mobile").getValue(),
				member_name : mini.get("title").getValue()
			});
		}
	 
		
        var dictMap = new Map();
		function onDict(e){
			if (e.column.field=='member_sex'){
				return datagridDictJson (e,e.column.field,"SEX");
			}
		}
		
		
		
		function edit() {
			var row = grid.getSelected();
			if (row) {
				mini.open({
					url : "${ctx}/member/edit/"+row.member_id,
					title : "编辑",
					width : 600,
					height : 360,
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