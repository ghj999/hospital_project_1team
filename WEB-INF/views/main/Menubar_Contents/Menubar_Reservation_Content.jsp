<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<link rel="stylesheet" href="/hos/resources/css/menubar_user.css">
		
	</head>
	<body>
		<!-- 메뉴바:왼쪽 -->
		<jsp:include page="/WEB-INF/views/main/Menubar_Contents/Menubar_Left_Box.jsp"/>
		
		<div id="content_hr">
		    <!-- 진료예약/안내 -->
		    <div class="section-header">
		        <p class="content_main_p">진료예약/안내 ></p>
		    </div>
		
		    <!-- 예약안내, 진료예약, 예약조회 -->
		    <div class="section-reservation">
		        <a class="content_sub_p"
		           href="reservation_info_page.do">예약안내</a>
		        <a class="content_sub_p"
		           href="step1.do?pat_idx=${sessionScope.patient.pat_idx}">진료예약</a><br>
		        <a class="content_sub_p"
		           href="mypage_reservation_list.do?pat_idx=${sessionScope.patient.pat_idx}">예약조회</a>
		    </div>
		
		    <!-- 증명서발급, 온라인 진료비 결제 -->
		    <div class="section-other">
		        <a class="content_sub_p"
		           href="mypage_certificates_print.do?pat_idx=${sessionScope.patient.pat_idx}">증명서 발급</a><br>
		        <a class="content_sub_p" 
		        	href="mypage_payment_page.do?pat_idx=${sessionScope.patient.pat_idx}">온라인 진료비 결제</a>
		    </div>
		</div>
	</body>
</html>




