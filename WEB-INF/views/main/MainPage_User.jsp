<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
   
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>Insert title here</title>
		
		<link rel="stylesheet" href="/hos/resources/css/mainpage-user/mainpage_user.css">
		
	</head>
	<body>
		<!-- 메뉴바 -->
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<!-- 배너 -->
		<jsp:include page="/WEB-INF/views/main/MainBanner.jsp"/>
		
		<!-- 상담예약/로그인/공지사항 -->
		<jsp:include page="/WEB-INF/views/main/Main_Part/Main_Part_1.jsp"/>
		
		<!-- 예약 서비스 및 진료과/의료진 -->
		<jsp:include page="/WEB-INF/views/main/Main_Part/Main_Part_2.jsp"/>
		
		<!-- 지도:오시는 길 -->
		<jsp:include page="/WEB-INF/views/main/Main_Part/Main_Part_3.jsp"/>
		
		<!-- 건강 정보 -->
		<jsp:include page="/WEB-INF/views/main/Main_Part/Main_Part_4.jsp"/>
		
		<!-- 풋터 -->
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
	
</html>
