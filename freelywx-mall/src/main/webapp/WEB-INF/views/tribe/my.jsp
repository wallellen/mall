<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport"/>
<meta name="format-detection" content="telephone=no"/>
<title>个人主页</title>
<link type="text/css" rel="stylesheet" href="${css}/public.css"/>
<script type="text/javascript">
	$(function(){
		$("li").click(function(){
			var type = $(this).attr("id");
			location.href = "${ctx}/tribe/list?type=" + type;
		})
	})
</script>
</head>

<body>
<div class="talk_bj_a">
	<div class="home">
		<img src="${img}/grzx_banner.png" width="100%" height="100"/>
    	<table cellpadding="0" cellspacing="0"  class="home_c">
        	<tr>
            	<td>
            		<c:if test="${empty member.member_img}"><img src="${img}/grzx2.png" width="80" height="80" /></c:if>
            		<c:if test="${not empty member.member_img}"><img src="${member.member_img}" width="80" height="80" /></c:if>
            	</td>
            	<td class="home_font">
                	<p class="a_1">
						<c:if test="${not empty fn:trim(member.member_name)}">${member.member_name}</c:if>
						<c:if test="${empty fn:trim(member.member_name)}">匿名</c:if>
					</p>
    				<p class="a_2">&nbsp;</p>
    			</td>
            </tr>
        </table>
	</div>
	
	<div class="home_list list">
		<ul class="list_ul">
	    	<li id="fb">
	        	<a href="javascript:void(0)">
	        		<span class="title_number_a">${list1}</span>
	        		<span class="left_title talk_ico">发表的话题</span>
	            </a>
	        </li>
	        <li id="hf">
	        	<a href="javascript:void(0)">
	        		<span class="title_number_a">${list2}</span>
	        		<span class="left_title assist_ico">回复的话题</span>
	            </a>
	        </li>
	        <li id="zg">
	        	<a href="javascript:void(0)">
	        		<span class="title_number_a">${list3}</span>
	        		<span class="left_title reply_ico">赞过的话题</span>
	            </a>
	        </li>
	    </ul>
	</div>
</div>

<jsp:include page="/foot.jsp" />
</body>
</html>