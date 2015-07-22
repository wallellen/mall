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
        <span>劵名称：</span>
		<input id="key" name="coupon_name" class="mini-textbox" emptyText="请输入劵名称" style="width: 150px;" onenter="onKeyEnter" /> 
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
		<div id="datagrid1" class="mini-datagrid"  style="width: 100%; height: 100%;" allowResize="true"
			url="${ctx}/coupon/use/list" idField="coupon_2_member" multiSelect="true">

			<div property="columns">
				<div type="indexcolumn" headerAlign="center">序号</div>
				<div field="coupon_2_member" name="name" align="left" headerAlign="left" allowSort="true" width="80">劵编号</div>
				<div field="coupon_name" align="left" headerAlign="left" allowSort="true" width="80">劵名称</div>
				<div field="coupon_type" align="center" headerAlign="center" allowSort="true" renderer="onDict" width="50">劵类型</div>
				<div field="coupon_value" align="center" headerAlign="center" allowSort="true" width="80" renderer="gridPriceRender" >面额(元)</div>
				<div field="cash_coupon_start_time" align="center" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd"  width="180">有效开始时间</div>
				<div field="cash_coupon_end_time" align="center" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd"  width="180">有效结束时间</div>
				<div field="member_name" align="center" headerAlign="center" allowSort="true" width="80">拥有者</div>
				<div field="coupon_state_new" align="center" headerAlign="center" allowSort="true" renderer="onDict" width="50">状态</div>
				<div field="bind_time" align="center" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss"  width="180">拥有时间</div>
				<div field="use_time" align="center" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss"  width="180">使用时间</div>
				<div field="coupon_desc" align="left" headerAlign="left" allowSort="true" width="280">备注</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		mini.parse();

		var grid = mini.get("datagrid1");
		grid.load(null,function(){
			grid.frozenColumns(0,3);
		});

		function search() {
			var key = mini.get("key").getValue();
			grid.load({
				coupon_name : key
			});
		}
		function onKeyEnter(e) {
			search();
		}
		
        var dictMap = new Map();
		function onDict(e){
			if (e.column.field=='coupon_type'){
				return datagridDictJson (e,e.column.field,"COUPON_TYPE");
			}else if (e.column.field=='coupon_state_new'){
				return datagridDictJson (e,e.column.field,"COUPON_STATE");
			}
		}
	</script>
</body>
</html>