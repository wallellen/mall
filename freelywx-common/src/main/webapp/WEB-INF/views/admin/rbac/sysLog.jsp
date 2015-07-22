<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title></title>
<jsp:include page="/meta.jsp" />
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
	<div style="padding-bottom: 5px;">
		<span>操作用户id：</span><input type="text" id="search_eq_userId" /> <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		<!-- <span>操作时间从：</span> <input id="search_gt_oper_time" class="mini-datepicker" format="yyyy-MM-dd"/>&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;
			<input id="search_lt_oper_time" class="mini-datepicker" format="yyyy-MM-dd"/>  -->
			<input type="button" value="搜索" onclick="search()" /> <span>&nbsp;</span> 
			<input type="button" value="清空" onclick="reset()" />
	</div>
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;"><a class="mini-button"
					iconCls="icon-remove" onclick="ClearExcel()">清空日志</a> <a
					class="mini-button" iconCls="icon-customers" onclick="ExportExcel()">导出日志</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="mini-fit" >
	<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="true" url="${ctx}/admin/sysLog/list" idField="log_id" multiSelect="true">
		<div property="columns">
			<div type="indexcolumn"></div>
			<div field="user_id" width="120" headerAlign="center" allowSort="true">操作用户id</div>
			<div field="oper_time" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort="true">操作时间</div>
			<div field="url" width="120" headerAlign="center" allowSort="true">功能地址</div>
			<div field="param" width="120" headerAlign="center" allowSort="true">参数</div>
		</div>
	</div>

	<form id="excelForm" action="${ctx}/admin/sysLog/exportSysLog" method="post" target="excelIFrame"></form>



	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		//对"oper_time"字段，进行降级排序
		grid.sortBy("oper_time", "desc");

		function ClearExcel() {
			if (confirm("确定清空日志？")) {
				$.post('${ctx}/admin/sysLog/delete/', function(data) {
					if (data) {
						notify('日志删除成功!');
						grid.reload();
					} else {
						notify('删除失败');
					}
				});
			}
		}

		function ExportExcel() {
			if (confirm("确定导出日志？")) {
				var url = '${ctx}/admin/sysLog/exportSysLog';
				$("#excelForm").attr('action', url);
				$("#excelForm").submit();
			}
		}
		
		function search() {
			var search_eq_userId = $("#search_eq_userId").val();
			/* var search_gt_oper_time = mini.get("search_gt_oper_time").getValue();
			var search_lt_oper_time = mini.get("search_lt_oper_time").getValue(); */
			
			grid.load({
				user_id : search_eq_userId
				/* start_time : search_gt_oper_time,
				end_time : search_lt_oper_time */
			});
		}

		function reset() {
			$("#search_eq_userId").val("");
			/* mini.get("search_lt_oper_time").setValue("");
			mini.get("search_gt_oper_time").setValue(""); */
		}
	</script>
</body>
</html>
