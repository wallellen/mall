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
        <span>会员名称：</span>
		<input id="key" name="member_name" class="mini-textbox" emptyText="请输入会员名称" style="width: 150px;" onenter="onKeyEnter" /> 
        <input type="button" value="查找" onclick="search()"/>
    </div>
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;"></td>
			</tr>
		</table>
	</div>
	<div class="mini-fit">

		<div id="datagrid1" class="mini-datagrid" iconField="icon_cls"	 style="width: 100%; height: 100%;" allowResize="true"
			url="${ctx}/interal/log/list" idField="member_id" multiSelect="true">

			<div property="columns">
				<div type="indexcolumn" headerAlign="center">序号</div>
				<div field="interal_rule_name" name="name" align="left" headerAlign="left" allowSort="true">规则名称</div>
				<div field="interal_rule_value" align="center" headerAlign="center" allowSort="true">积分数量</div>
				<div field="member_id" align="left" headerAlign="left" allowSort="true" width="50">会员编号</div>
				<div field="member_name" align="left" headerAlign="left" allowSort="true" width="50">会员名称</div>
				<div field="create_time" align="center" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss"  width="80">积分变动时间</div>
				<div field="interal_change_type" align="center" headerAlign="center" allowSort="true" renderer="onDict" width="50">状态</div>
				<div field="interal_rule_desc" align="left" headerAlign="left" allowSort="true">备注</div>
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
				member_name : key
			});
		}
		function onKeyEnter(e) {
			search();
		}
		
        var dictMap = new Map();
		function onDict(e){
			if (e.column.field=='interal_change_type'){
				return datagridDictJson (e,e.column.field,"INTERAL_CHANGE");
			}
		}
	</script>
</body>
</html>