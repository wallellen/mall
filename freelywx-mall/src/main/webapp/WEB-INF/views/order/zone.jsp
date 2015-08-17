<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<c:if test="${empty zone}">
	<c:if test="${nid==1}"><option value="0">--选择省份--</option></c:if>
	<c:if test="${nid==2}"><option value="0">--选择市区--</option></c:if>
</c:if>
<c:if test="${not empty zone}">
	<c:forEach items="${zone}" var="zone">
		<option value="${zone.zone_code}">${zone.zone_name}</option>
	</c:forEach>
</c:if>

<script type="text/javascript"></script>