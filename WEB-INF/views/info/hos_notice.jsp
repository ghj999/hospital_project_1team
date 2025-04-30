<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항</title>
		
		<link rel="stylesheet" href="/hos/resources/css/info/hos_notice.css">
		
		<script src="resources/js/info/hos_notice.js"></script>
	</head>
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="container">
		
			<p>공지사항</p>
		
			<div id="search_div">			
				<select id="search" onchange="clearText()">
					<option value="all">전체보기</option>
					<option value="not_title">제목</option>
					<option value="not_content">내용</option>
					<option value="title_content">제목+내용</option>
				</select>
						
				<input id="search_text">
				<input id="search_btn" type="button" value="검색" onclick="search();">
			</div>
			
			<div id="notice_div">
				<table>
				
					<colgroup>
						<col width="80px" />
						<col width="460px" />
						<col width="220px" />
						<col width="140px" />
						<col width="100px" />
					</colgroup>
				
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>파일</th>
					</tr>
					
					<c:forEach var="vo" items="${list}" varStatus="count">
						<tr>
							<td>${startIndex - count.index}</td>
							<td class="title_td">
								<a href="info_notice_view.do?not_idx=${vo.not_idx}&page=${param.page}">${vo.not_title}</a>
							</td>
							<td class="date_td">${fn:split(vo.not_date, ' ')[0] }</td>
							<td class="hit_td">${vo.not_hits}</td>
							<td>
								<c:if test="${vo.not_file ne null}">
										<img src="/hos/resources/images/file.png">							
								</c:if>
							</td>
						</tr>
					</c:forEach>
					
				</table>
			</div>
			
			<div id="page">
				${ pageMenu }
			</div>
			
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>