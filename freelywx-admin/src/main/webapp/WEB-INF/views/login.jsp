<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>登录</title>
<link type="text/css" rel="stylesheet" href="${css}/login.css" />
</head>
<body> 

<jsp:include page="/meta.jsp" />

<%-- <div id="loginWindow" class="mini-window" title="用户登录" style="width:350px;height:240px;"  showModal="true" showCloseButton="false"  >

    <div id="loginForm" style="padding:15px;padding-top:10px;">
    --%>

<div class="login">
	<div class="login_main">
		<div class="login_from" id="loginWindow">
			<%-- <form action="${ctx}/login" method="post" id="dialogForm">
	        		<table cellpadding="0" cellspacing="0" border="0" class="login_table">
	                	<tr><td>用户名：</td><td><input type="text" class="login_text" id="username" name="username" /></td></tr>
	                    <tr><td>密 &nbsp;&nbsp;码：</td><td><input type="text" class="login_text" id="password" name="password"/></td></tr>
	                    <tr><td>&nbsp;</td><td class="login_td"><input type="submit" class="login_button" value=""/><input type="reset" value="" class="login_reset" /></td></tr>
	                </table>
                </form> --%>
			<form id="dialogForm" method="post" action="${ctx}/login">
				<table>
					<tr>
						<td><label for="username$text">帐号：</label></td>
						<td><input id="username" name="username"
							onvalidation="onUserNameValidation" class="mini-textbox" value="admin"
							required="true" style="width: 150px; border:1px solid #ccc; visibility: visible;" /></td>
					</tr>
					<tr>
						<td style="width: 60px;"><label for="password$text">密码：</label></td>
						<td><input id="password" name="password"
							onvalidation="onPwdValidation" class="mini-password" value="admin"
							requiredErrorText="密码不能为空" required="true" style="width: 150px;visibility: visible;  border:1px solid #ccc" onenter="onLoginClick" />
						</td>
					</tr>

					<tr>
						<td></td>
						<td style="padding-top: 5px;">
							<a onclick="onLoginClick" class="mini-button" style="width: 60px;">登录</a> 
							<a onclick="onResetClick" class="mini-button" style="width: 60px;">重置</a>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center" style="margin-top: 6px;" >
							<c:choose>
								<c:when
									test="${shiroLoginFailure eq 'com.mowei.rbac.shiro.CaptchaException'}">
									<span id="errorInfo" style="color: red">验证码错误，请重试.</span>
								</c:when>
								<c:when
									test="${shiroLoginFailure eq 'org.apache.shiro.authc.UnknownAccountException'}">
									<span id="errorInfo" style="color: red">该用户不存在.</span>
								</c:when>
								<c:when
									test="${shiroLoginFailure eq 'org.apache.shiro.authc.IncorrectCredentialsException'}">
									<span id="errorInfo" style="color: red">用户或密码错误</span>
								</c:when>
								<%--  <c:when test="${shiroLoginFailure ne null}">  
										                 <div  style="color: red;">登录认证错误，请重试.</div>  
										            </c:when> 
										             --%>
							</c:choose>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	mini.parse();

	function onLoginClick(e) {
		var form = new mini.Form("#loginWindow");

		form.validate();
		if (form.isValid() == false)
			return;
		$("#dialogForm").submit();
		/* loginWindow.hide();
		mini.loading("登录成功，马上转到系统...", "登录成功");
		setTimeout(function () {
		    window.location = "../outlooktree/outlooktree.html";
		}, 1500); */
	}
	function onResetClick(e) {
		var form = new mini.Form("#loginWindow");
		form.clear();
	}
	/////////////////////////////////////
	function isEmail(s) {
		if (s.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
			return true;
		else
			return false;
	}
	function onUserNameValidation(e) {
		if (e.isValid) {
			/* if (isEmail(e.value) == false) {
			    e.errorText = "必须输入邮件地址";
			    e.isValid = false;
			} */
		}
	}
	function onPwdValidation(e) {
		if (e.isValid) {
			if (e.value.length < 5) {
				e.errorText = "密码不能少于5个字符";
				e.isValid = false;
			}
		}
	}
/* 
	function refreshCaptcha() {
		$("#img_captcha").attr("src", "${ctx}/captchaCode?t=" + Math.random());
	} */
</script>
</body>
</html>
