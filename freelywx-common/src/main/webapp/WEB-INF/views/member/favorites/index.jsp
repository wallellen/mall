<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/uilibs.jsp"%>
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
			url="${ctx}/member/favorites/list" idField="member_id" multiSelect="true">

			<div property="columns">
				<div type="indexcolumn" headerAlign="center">序号</div>
				<div field="member_id" name="name" align="left" headerAlign="left" allowSort="true">会员编号</div>
				<div field="member_name" name="name" align="left" headerAlign="left" allowSort="true">会员名称</div>
				<div field="prod_name" align="left" headerAlign="left" allowSort="true">商品名称</div>
				<div field="create_time" align="center" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss"  width="50" >收藏时间</div>
				<div field="state" align="center" headerAlign="center" allowSort="true" renderer="onDict">状态</div>
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
			if (e.column.field=='state'){
				return datagridDictJson (e,e.column.field,"SHOPPING_STATE");
			}
		}
	</script>
</body>
</html>