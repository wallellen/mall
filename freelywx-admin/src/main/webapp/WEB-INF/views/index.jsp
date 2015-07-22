<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>自由数字微信管理系统</title>
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

body .header .topNav {
	position: absolute;
	right: 20px;
	top: 10px;
	font-size: 14px;
	color: #fff;
	line-height: 25px;
}

.header .topNav a {
	text-decoration: none;
	color: #222;
	font-weight: normal;
	font-size: 12px;
	line-height: 25px;
	margin-left: 3px;
	margin-right: 3px;
}

.header .topNav a:hover {
	text-decoration: underline;
	color: Blue;
}

.mini-layout-region-south img {
	vertical-align: top;
}

.logo {
	background: url("${img}/logo.jpg") no-repeat left top;
	height: 78px;
}

.logo_bj {
	background: url("${img}/logo_bj.jpg") repeat-x;
	height: 78px;
	width: 100%;
}
</style>
</head>
<body>
	<div class="mini-layout" style="width: 100%; height: 100%;">
		<div title="north" region="north" class="header" bodyStyle="overflow:hidden;" height="80" showHeader="false" showSplit="false">
			<div class="logo_bj">
				<div class="logo"></div>
			</div>
			<div class="topNav">
				欢迎你：
				<shiro:principal type="com.freelywx.admin.shiro.ShiroUser" property="login_id" />
			</div>

			<div
				style="position: absolute; right: 30px; bottom: 5px; font-size: 12px; line-height: 25px; font-weight: normal;">
				<a href="javascript:changePwd()">修改密码 </a> 
				<a href="javascript:logout();">退出系统</a>
			</div>
		</div>
		<div showHeader="false" region="south" style="border: 0; text-align: center;" height="25" showSplit="false">
			Copyright © 武汉自由数字科技有限公司</div>
		<div region="west" title="功能菜单" showHeader="true" bodyStyle="padding-left:1px;" showSplitIcon="true" width="230" minWidth="100" maxWidth="350">
			<ul id="menuTree" class="mini-tree" textField="text" idField="id"
				showTreeIcon="true" style="width: 100%; height: 100%;"
				enableHotTrack="true" onbeforeexpand="onBeforeExpand"
				onnodeclick="onNodeSelect">
			</ul>
		</div>
		<div title="center" region="center" style="border: 0;">
			<div id="mainTabs" class="mini-tabs" activeIndex="0" style="width: 100%; height: 100%;" onactivechanged="onTabsActiveChanged">
				<div title="首页">
					<iframe id="codeframe" frameborder="0" name="code"
						style="width: 100%; height: 100%;" border="0"></iframe>
				</div>
			</div>
		</div>
	</div>
	<div id="changePwdWin" class="mini-window" title="修改密码" style="width: 400px; height: 200px;" showModal="true" showCloseButton="true">
		<div id="loginForm" style="padding: 15px; padding-top: 10px;">
				<input class="mini-hidden" name="user_id" />
				<table>
					<tr>
						<td style="width: 100px;"><label for="pwd$text">新密码：</label></td>
						<td>
							<input id="pwd" name="pwd" onvalidation="onPwdValidation" class="mini-password" requiredErrorText="密码不能为空" required="true" style="width: 150px;" />
							<input id="userId" name="userId" class="mini-hidden"/>
						</td>
					</tr>
					<tr>
						<td><label for="pwd$text">确认新密码：</label></td>
						<td>
							<input id="pwds" name="pwds" onvalidation="onPwdValidation" class="mini-password" requiredErrorText="密码不能为空" required="true" style="width: 150px;" />
						</td>
					</tr>
					<tr>
						<td></td>
						<td style="padding-top: 5px;">
							<a onclick="onSubmitClick" class="mini-button" style="width: 60px;">确认</a> 
							<a onclick="onCancleClick" class="mini-button" style="width: 60px;">取消</a>
						</td>
					</tr>
				</table>
			</div>
		</div>		
	<script type="text/javascript">
		mini.parse();
		var data = <shiro:principal type="com.freelywx.admin.shiro.ShiroUser" property="menuData" />
		var tree3 = mini.get("menuTree");
		var changePwdWin = mini.get("changePwdWin");
		tree3.loadData(data);
		function showTab(node) {
			var tabs = mini.get("mainTabs");
	
			var id = "tab$" + node.id;
			var tab = tabs.getTab(id);
			if (!tab) {
				tab = {};
				tab._nodeid = node.id;
				tab.name = id;
				tab.title = node.text;
				tab.showCloseButton = true;
				//这里拼接了url，实际项目，应该从后台直接获得完整的url地址
				tab.url = "${ctx}" + node.url;
				tabs.addTab(tab);
			}else{
				tabs.reloadTab(tab);
			}
			tabs.activeTab(tab);
		}
	
		function onTabsActiveChanged(e) {
			var tabs = e.sender;
			var tab = tabs.getActiveTab();
			if (tab && tab._nodeid) {
				var node = tree3.getNode(tab._nodeid);
				if (node && !tree3.isSelectedNode(node)) {
					//tree3.selectNode(node);
				}
			}
		}
	
		function onNodeSelect(e) {
			var node = e.node;
			var isLeaf = e.isLeaf;
			if (isLeaf) {
				showTab(node);
			}
		}
	
		function onBeforeExpand(e) {
			var tree = e.sender;
			var nowNode = e.node;
			var level = tree.getLevel(nowNode);
			var root = tree.getRootNode();
			tree.cascadeChild(root, function(node) {
				if (tree.isExpandedNode(node)) {
					var level2 = tree.getLevel(node);
					if (node != nowNode && !tree.isAncestor(node, nowNode)
							&& level == level2) {
						tree.collapseNode(node, true);
					}
				}
			});
		}
		function onTabsActiveChanged(e) {
		/* 	var tree = e.sender;
			var nowNode = e.node;
			var level = tree.getLevel(nowNode);
			var root = tree.getRootNode();
			tree.cascadeChild(root, function(node) {
				if (tree.isExpandedNode(node)) {
					var level2 = tree.getLevel(node);
					if (node != nowNode && !tree.isAncestor(node, nowNode)
							&& level == level2) {
						tree.collapseNode(node, true);
					}
				}
			}); */
		}
		//注销用户
		function logout() {
			var url = '${ctx}/logout';
			window.parent.location = url;
		}
	
		
		function onCancleClick(e) {
			changePwdWin.hide();
		}
	
		function changePwd(e) {
			mini.get("userId").setValue(<shiro:principal type="com.freelywx.admin.shiro.ShiroUser" property="user_id" />);
			changePwdWin.show();
		}
	
		function onPwdValidation(e) {
			var preValue = mini.get("pwd").value;
			if (e.isValid) {
				if (e.value != preValue) {
					e.errorText = "密码必须相同";
					e.isValid = false;
				}
			}
		}
	
		function onSubmitClick(e) {
			var form = new mini.Form("#loginForm");
			form.validate();
			if (form.isValid() == false)
				return;
			
			var data = mini.decode(form.getData());
			$.post("${ctx}/rbac/user/updatePwd", data, function() {
				form.reset();
				mini.get("changePwdWin").hide();
				alert("操作成功,请重新登录!");
				logout();
			});
		}
	</script>
</body>
</html>

