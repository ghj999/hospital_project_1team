<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료진 찾기</title>

<link rel="stylesheet"
	href="/hos/resources/css/Search/professor_search.css">

</head>
<body>
	<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp" />

	<div class="content">
		<div id="fix_content">
			<div class="title" id="title" onclick="location.href='searchMain.do'">의료진
				찾기</div>
			<div class="search_container">
				<form id="searchForm" method="post" action="searchProfessor.do">
					<select id="searchType" name="searchType">
						<option value="all">전체보기</option>
						<option value="pro_name">이름</option>
						<option value="dept_name">소속 부서</option>
						<option value="pro_field">전공 분야</option>
						<option value="search_all">이름+소속+전공</option>
					</select> <input type="text" id="keyword" name="keyword"
						placeholder="검색어를 입력하세요">
					<button type="submit" style="background-color: #12B8BA;">검색</button>
				</form>
			</div>
		</div>

		<div class="search_info" id="search_info">
			<img
				src="${pageContext.request.contextPath}/resources/images/magnifying-glass.png"
				alt="돋보기">
			<p>
				의료진을 빠르게 찾으실 수 있습니다.<br> 이름, 소속 부서, 전공 분야를 입력해 검색하세요.
			</p>
		</div>
	</div>
</body>
</html>