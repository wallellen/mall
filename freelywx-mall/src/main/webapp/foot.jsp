<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="res" value="${ctx}/static" />
<c:set var="img" value="${res}/images" />

<div class="bg" style="display: none">
	<div class="dialog">
		<p></p>
	</div>
</div>

<div class="shoop_share" style="display: none;position:fixed; width:100%; top:0px; left:0px; right:0px; bottom:0px; background:rgba(0,0,0,0.5); z-index:100;">
	<img src="${img}/share.png" width="100%" />
</div>

<div style="display: none">
	<script type="text/javascript">
		var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
		document.write(unescape("%3Cspan id='cnzz_stat_icon_1253322546'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s9.cnzz.com/z_stat.php%3Fid%3D1253322546' type='text/javascript'%3E%3C/script%3E"));
	</script>
</div>