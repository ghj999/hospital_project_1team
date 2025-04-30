<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
		<link rel="stylesheet" href="/hos/resources/css/admin/professor/professor_list_before.css">
		<script src="/hos/resources/js/httpRequest.js"></script>
		
	</head>
	<body>
		<!-- 헤더,사이드바 -->
		<jsp:include page="/WEB-INF/views/main/Admin/Admin_Header.jsp"/>
		
		<!-- 콘텐츠 영역 -->
		<div class="admin-content-container">
			<div class="admin-content" id="admin-content">
				<div class="scroll_container">
				<div id="container">
					<center>
					<p>의료진관리</p>
					</center>
					
					<div class="search_container">
			            <form id="searchForm" method="post" action="admin_professor_list.do">
			                <select id="searchType" name="searchType">
			                    <option value="all">전체보기</option>
			                    <option value="pro_name">이름</option>
			                    <option value="dept_name">소속 부서</option>
			                    <option value="pro_field">전공 분야</option>
			                    <option value="search_all">이름+소속+전공</option>
			                </select>
			                <input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요">
			                <button type="submit" style="background-color: #12B8BA;">검색</button>
			            </form>
			        </div>
			        
			        <div class="search_info" id="search_info">
			            <img src="${pageContext.request.contextPath}/resources/images/magnifying-glass.png" alt="돋보기">
			            <p style="font-size: 18px;">
			            의료진을 빠르게 찾으실 수 있습니다.<br>
			            이름, 소속 부서, 전공 분야를 입력해 검색하세요.
			            </p>
			            <input type="button" value="의료진추가" 
			            	onclick="location.href='admin_professor_insert_form.do'">
			       	</div>	
		       	
		        </div>
			</div>
			</div>
		</div>
	</body>
</html>