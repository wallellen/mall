<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>商户信息</title>
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
 <!-- 搜索栏 -->
	<div style="padding-bottom: 5px;">
		<table>
			<tr>
				<td>用户编号：</td>
				<td><input type="text" id="search_user_id" /></td>
				<td>商户编码：</td>
				<td><input type="text" id="search_m_code" /></td>
				<td><input type="button" value="查找" onclick="search()" /></td>
				<td><input type="button" value="重置" onclick="reset()" /></td>
			</tr>
		</table>
	</div> 

<!-- 展示栏 ，展示所有模板信息-->
	<div class="mini-fit">
		<div id="merchantDategrid" class="mini-datagrid"
			style="width: 100%; height: 100%;" allowResize="true"
			url="${ctx}/merchant/list" idField="merchant_id" multiSelect="true">
			<div property="columns">
				<div type="indexcolumn"></div>
				<!-- <div type="checkcolumn"></div> -->
				<div field="login_id" headerAlign="center" allowSort="true">用户登录名</div>
				<div field="user_name" headerAlign="center" allowSort="true">用户名称</div>
				<div field="m_code" headerAlign="center" allowSort="true">商户编码</div>
				<div field="m_secret" headerAlign="center" allowSort="true">密码</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	 mini.parse();
	 var grid = mini.get("merchantDategrid");
	grid.load();
	
	function search() {
		grid.load({
			user_id : $("#search_user_id").val(),
			m_code : $("#search_m_code").val()
			
		});
	}
	//重置
	function reset() {
		$("#search_user_id").val("");
		$("#search_m_code").val("");
	}


	/* 取消窗口 */
 	function cancel() {
		grid.reload();
		addWindow.hide();
		editWindow.hide();
	} 
	
	</script>
	
</body>
</html>