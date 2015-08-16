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
		<span>订单编号：</span><input class="mini-textbox" style="width: 200px;" id="order_id" onenter="onKeyEnter" /> 
		<span>会员编号：</span><input class="mini-textbox" style="width: 200px;" id="member_id" onenter="onKeyEnter" /> 
		<span>会员名称：</span><input class="mini-textbox" style="width: 200px;" id="member_name" onenter="onKeyEnter" /></br>
		<span>收单时间从：</span><input id="create_time_ge" style="width: 200px;" class="mini-datepicker" allowInput="false" showTodayButton="false" format="yyyy-MM-dd H:mm:ss" timeFormat="H:mm:ss" showTime="true" />
		<span>&nbsp;到：</span><input id="create_time_le" style="width: 200px;" class="mini-datepicker" allowInput="false" showTodayButton="false" format="yyyy-MM-dd H:mm:ss" timeFormat="H:mm:ss" showTime="true" ondrawdate="onDrawDate" /> 
		<span>订单状态：</span><input id="order_status" class="mini-combobox" style="width:200px;" textField="text" valueField="id" url="${ctx}/comboBox/dictDetail?dictKey=ORDER_STATUS" value="" showNullItem="true" /></br>
		<span>收货人：</span><input class="mini-textbox" style="width: 200px;" id="shipper" onenter="onKeyEnter" /> 
		<span>收货人手机号：</span><input class="mini-textbox" style="width: 200px;" id="phone" onenter="onKeyEnter" /> 
		<span>收货人邮箱：</span><input class="mini-textbox" style="width: 200px;" id="email" onenter="onKeyEnter" /> 
		<a class="mini-button" onclick="search()">查找</a>
	</div>
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
					<a class="mini-button" iconCls="icon-filter" onclick="detail()">详情</a> 
					<a class="mini-button" iconCls="icon-redo" onclick="send()">发货</a> 
					<a class="mini-button" iconCls="icon-undo" onclick="receive()">收货</a> 
					<a class="mini-button" iconCls="icon-undo" onclick="compute()">计算积分</a> 
				</td>
			</tr>
		</table>
	</div>
	<div class="mini-fit">
		<div id="datagrid1" class="mini-datagrid" iconField="icon_cls" style="width: 100%; height: 100%;"
			url="${ctx}/order/list" idField="order_id">
			<div property="columns">
				<div type="indexcolumn" headerAlign="center">序号</div>
				<div field="order_status" name="order_status" align="center" headerAlign="center" allowSort="true" renderer="onDict">订单状态</div>
				<div field="order_id" name="order_id" align="left" headerAlign="left" allowSort="true">订单编号</div>
				<div field="member_id" name="member_id" align="left" headerAlign="left" allowSort="true">会员编号</div>
				<div field="member_name" name="member_name" align="left" headerAlign="left" allowSort="true">会员名称</div>
				<div field="amount_price" name="amount_price" align="left" headerAlign="left" allowSort="true" renderer="gridPriceRender">总金额</div>
				<div field="integral_price" name="integral_price" align="left" headerAlign="left" allowSort="true" renderer="gridPriceRender">积分支付</div>
				<div field="discount_price" name="discount_price" align="left" headerAlign="left" allowSort="true" renderer="gridPriceRender">优惠金额</div>
				<div field="payment_price" name="payment_price" align="left" headerAlign="left" allowSort="true" renderer="gridPriceRender">支付金额</div>
				<div field="shipper" name="shipper" align="left" headerAlign="left" allowSort="true">收货人</div>
				<div field="phone" align="left" headerAlign="left" allowSort="true">收货人手机号</div>
				<div field="create_time" dateFormat="yyyy-MM-dd HH:mm:ss" align="center" headerAlign="center" allowSort="true">收单时间</div>
				<div field="payment_time" dateFormat="yyyy-MM-dd HH:mm:ss" align="center" headerAlign="center" allowSort="true">支付时间</div>
				<div field="receiver_time" dateFormat="yyyy-MM-dd HH:mm:ss" align="center" headerAlign="center" allowSort="true">收货取货时间</div>
				<div field=integral_num  align="center" headerAlign="center" allowSort="true">积分数量</div>
				<div field="cycle_num"  align="center" headerAlign="center" allowSort="true" renderer="onReturn">返还周期</div>
				<div field="is_computed"  align="center" headerAlign="center" allowSort="true" renderer="onDict">积分任务是否成功</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		
		var orderStatusRenderMap;
		function orderStatusRender(e) {
			if(!orderStatusRenderMap){
				$.ajax({
					data : {dictKey: 'ORDER_STATUS'},
					url : "${ctx}/comboBox/dictDetail",
    	            async:false,		
					success : function(text) {
						orderStatusRenderMap = text;
					},
					error : function() {
					}
				});
			}
            for (var i = 0, l = orderStatusRenderMap.length; i < l; i++) {
                var g = orderStatusRenderMap[i];
                if (g.id == e.value) return g.text;
            }
            return "";
		}
		
		function detail() {
			var row = grid.getSelected();
			if (row) {
				mini.open({
					url : "${ctx}/order/detail/" + row.order_id,
					title : "详情",
					width :1000,
					height : 550
				});
			} else {
				alert("请选中一条记录");
			}
		}

		function send() {
			var row = grid.getSelected();
			if (row) {
				if(row.order_status != '2' && row.order_status != '3') {
					notify("只有状态为已付款的订单才能发货!");
					return;
				}
				mini.open({
					url : "${ctx}/order/send/" + row.order_id,
					title : "详情",
					width : 600,
					height : 210,
					ondestroy : function(action) {
						grid.reload();
					}
				});
			} else {
				alert("请选中一条记录");
			}
		}
		
		function receive() {
			var row = grid.getSelected();
			if (row) {
				if(row.order_status != '3') {
					notify("只有状态为已发货的订单才能收货!");
					return;
				}
				$.post("${ctx}/order/receive/" + row.order_id, function(data) {
					if(data) {
						notify("操作成功!");
					} else {
						notify("操作失败!");
					}
					grid.reload();
				});
			} else {
				alert("请选中一条记录");
			}
		}
		
		function compute() {
			var row = grid.getSelected();
			if (row) {
				if(row.is_return != '1' && row.is_computed =='2') {
					notify("只有送积分且为计算的才可以进行计算!");
					return;
				}
				$.post("${ctx}/order/generateTaskInfo/" + row.order_id, function(data) {
					if(data) {
						notify("操作成功!");
					} else {
						notify("操作失败!");
					}
					grid.reload();
				});
			} else {
				alert("请选中一条记录");
			}
		}
		
		function search() {
			grid.load({
				order_id : mini.get("order_id").getValue(),
				member_id : mini.get("member_id").getValue(),
				member_name : mini.get("member_name").getValue(),
				create_time_le : mini.get("create_time_le").getFormValue(),
				create_time_ge : mini.get("create_time_ge").getFormValue(),
				order_status : mini.get("order_status").getValue(),
				shipper : mini.get("shipper").getValue(),
				mobile : mini.get("phone").getValue(),
				email : mini.get("email").getValue()
			});
		}
		
		function onKeyEnter(e) {
			search();
		}
		
		var dictMap = new Map();
		function onDict(e){
			if (e.column.field=='order_status'){
				return getDict (e,e.column.field,"ORDER_STATUS");
			}else if (e.column.field=='is_computed'){
				return getDict (e,e.column.field,"YESORNO");
			}
		}
		function onReturn(e){
			return "";
		}
		
	</script>
</body>
</html>