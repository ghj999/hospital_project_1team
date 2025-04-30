<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Admin Page</title>
		
		<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
		<script src="/hos/resources/js/httpRequest.js"></script>
		
	</head>
	<body>
		<!-- 헤더,사이드바 -->
		<jsp:include page="/WEB-INF/views/main/Admin/Admin_Header.jsp"/>
		
		<!-- 콘텐츠 영역 -->
		<div class="admin-content-container">
			<p style="font-size: 40px; color: #d8d8d8">이곳에 선택된 컨텐츠가 표시됩니다.</p>
		</div>
	</body>
</html>






