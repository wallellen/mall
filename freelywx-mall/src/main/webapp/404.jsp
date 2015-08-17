<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Nothing found for 404</title>
<style>
body {
	background: #f9fee8;
	margin: 0;
	padding: 20px;
	text-align: center;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	color: #666666;
}

.error_page {
	width: 600px;
	padding: 50px;
	margin: auto;
}

.error_page h1 {
	margin: 20px 0 0;
}

.error_page p {
	margin: 10px 0;
	padding: 0;
}

.error_page a {
	color: #9caa6d;
	text-decoration: none;
}

.error_page a:hover {
	text-decoration: underline;
}
</style>

</head>
<body>
	<div class="error_page">
		<img src="${img}/404.gif" />
		<h1>对不起</h1>
		<p>无法找到您正在浏览的页面</p>
		<p>
			<a href="javascript:history.go(-1)">返回上一页</a>
		</p>
	</div>
</body>
</html>