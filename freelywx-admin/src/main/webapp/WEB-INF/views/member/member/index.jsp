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
		<input id="member_name" name="member_name" class="mini-textbox" emptyText="请输入会员名称" style="width: 150px;" onenter="onKeyEnter" /> 
        <input type="button" value="查找" onclick="search()"/>
    </div>
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
					<a class="mini-button" iconCls="icon-reload" onclick="reloadLevel()">手动刷新会员等级</a> 
					<!-- <a class="mini-button" iconCls="icon-edit" onclick="edit()">编辑</a>  -->
				</td>
			</tr>
		</table>
	</div>
	<div class="mini-fit">

		<div id="datagrid1" class="mini-datagrid" iconField="icon_cls"	 style="width: 100%; height: 100%;" allowResize="true"
			url="${ctx}/member/list" idField="member_id" multiSelect="true">

			<div property="columns">
				<div type="indexcolumn" headerAlign="center">序号</div>
				<div field="member_id" name="name" align="left" headerAlign="left" allowSort="true" width="50">会员卡号</div>
				<div field="member_name" align="left" headerAlign="left" allowSort="true" width="50">会员名称</div>
				<div field="member_img" align="center" headerAlign="center" allowSort="true" renderer="onImgRenderer" width="50">用户图像</div>
				<div field="payment_price" align="center" headerAlign="center" allowSort="true" width="50" renderer="gridPriceRender" >会员总消费</div>
				<div field="member_level" align="center" headerAlign="center" allowSort="true"  renderer="onLevel" width="50">会员等级</div>
				<div field="member_sex" align="center" headerAlign="center" allowSort="true" renderer="onDict" width="50">性别</div>
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
			});
		}
		function onKeyEnter(e) {
			search();
		}
		
        var dictMap = new Map();
		function onDict(e){
			if (e.column.field=='member_sex'){
				return datagridDictJson (e,e.column.field,"SEX");
			}
		}
		
		
		function onImgRenderer(e){
            var grid = e.sender;
            var record = e.record;
            var rowIndex = e.rowIndex;
            var s =  '<img src="'+record.member_img+'" alt="用户图像"  width="50" height="50" />';
            return s;
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