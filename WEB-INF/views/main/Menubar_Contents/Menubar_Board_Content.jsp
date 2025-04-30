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
		    <!-- 병원게시판 -->
		    <div class="section-header">
		        <p class="content_main_p">병원게시판 ></p>
		    </div>
		
		    <!-- 감사합니다! 전체보기, 글 쓰기 -->
		    <div class="section-reservation">
		        <a class="content_sub_p" href="join_thanks_list.do?pat_idx=${sessionScope.patient.pat_idx}">게시판 전체보기</a>
		        <a class="content_sub_p" href="join_thanks_insert_form.do?pat_idx=${sessionScope.patient.pat_idx}">감사합니다 글 쓰기</a>
		        <a class="content_sub_p" href="join_compl_insert_form.do?pat_idx=${sessionScope.patient.pat_idx}">건의합니다 글 쓰기</a>
		    </div>
		
		    <!-- 건의합니다, 자원봉사 모집공지, 공지사항 보기 -->
		    <div class="section-other">
		        <a class="content_sub_p" href="join_volunteer_list.do?pat_idx=${sessionScope.patient.pat_idx}">자원봉사 모집공지</a>
		        <a class="content_sub_p" href="info_notice_list.do">공지사항 보기</a>
		    </div>
		</div>
	</body>
</html>




