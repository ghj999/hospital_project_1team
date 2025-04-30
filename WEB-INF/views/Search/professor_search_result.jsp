<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료진 찾기</title>

<link rel="stylesheet" href="/hos/resources/css/Search/professor_search_result.css">

</head>
<body>
    <jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp" />
    
    <div class="content">	     	
		<div id="fix_content">
			<div class="title" id="title" onclick="location.href='searchMain.do'">의료진 찾기</div>
			<div class="search_container">	           
			    <form id="searchForm" method="post" action="searchProfessor.do">
			    	<select id="searchType" name="searchType">
				        <option value="all">::: 전체보기 :::</option>
				        <option value="pro_name">이름</option>
				        <option value="dept_name">소속 부서</option>
				        <option value="pro_field">전공 분야</option>
				        <option value="search_all">이름+소속+전공</option>
			    	</select>
			    	<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요">
			    	<button type="submit" style="background-color: #12B8BA;">검색</button>
			    </form>
			</div>
		</div>

		<div id="search_result">
			<!-- 검색 결과가 있는 경우 -->
			<c:if test="${hasResult}">
				<div id="dynamic_content">
					<div id="search_display">
						<table class="professor_table">
							<thead>
								<tr>
									<th>교수 이미지</th>
									<th>교수 이름</th>
									<th>소속 부서</th>
									<th>전공 분야</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="vo" items="${list}">
									<tr>
										<td>
											<!-- 첨부된 이미지가 있는 경우에만 img태그를 사용 -->
											<c:if test="${ vo.pro_file ne 'no_file' }">
											    <img src="${pageContext.request.contextPath}/resources/upload/${vo.pro_file}"
											    alt="교수 이미지">
											</c:if>
											<c:if test="${ vo.pro_file eq 'no_file' }">
											    <img src="/hos/resources/images/MEDICOMPILE LOGO_sample.png"
											    alt="교수 이미지">
											</c:if>
										</td>
										<td>${vo.pro_name}</td>
										<td>${vo.dept_name}</td>
										<td>${vo.pro_field}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="page_menu" style="margin: 0 auto;">${pageMenu}</div>
				</div>
			</c:if>

			<!-- 검색 결과가 없는 경우 -->
			<c:if test="${!hasResult}">
				<div class="alert_warning" id="alert_warning">검색 결과가 없습니다.</div>
			</c:if>
		</div>
	</div>
</body>
</html>