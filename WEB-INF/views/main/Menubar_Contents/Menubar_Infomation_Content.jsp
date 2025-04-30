<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<!-- 메뉴바:왼쪽 -->
		<jsp:include page="/WEB-INF/views/main/Menubar_Contents/Menubar_Left_Box.jsp"/>
		
		<div id="content_hr">
		    <!-- 병원안내 -->
		    <div class="section-header">
		        <p class="content_main_p">병원안내 ></p>
		    </div>
		
		    <!-- 층별안내, 의료기기 탐색 -->
		    <div class="section-reservation">
		        <a class="content_sub_p" href="way_info.do">오시는 길</a>
		        <a class="content_sub_p" href="floor_info.do">층별안내</a>
		        <a class="content_sub_p" href="device_list.do">의료기기 탐색</a>
		    </div>
		
		    <!-- 주차안내, 진료과/의료진 보기 -->
		    <div class="section-other">
		        <a class="content_sub_p" href="parking_info.do">주차안내</a>
		        <a class="content_sub_p" href="searchMain.do">의료진 보기</a>
	    	</div>
		</div>
	</body>
</html>


