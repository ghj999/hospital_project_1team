<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>작성글 관리</title>
		
		<link rel="stylesheet" href="/hos/resources/css/mypage/managing_posts.css">
		
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<div id="main_div">
			<p id="post_text">작성글 관리</p>

			<table>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>카테고리</th>
				</tr>
				
				<c:forEach var="vo" items="${ list }">
				<tr>
					<td>${ vo.board_idx }</td>
					<td class="title_td">
						<a href="mypage_detail_post.do?board_idx=${vo.board_idx}&pat_idx=${param.pat_idx}">
							${ vo.board_title }
						</a>
					</td>
					<td>${ vo.board_date }</td>
					<td>
						<c:if test="${ vo.board_type eq 'thanks' }"><a class="thanks">감사합니다</a></c:if>
						<c:if test="${ vo.board_type ne 'thanks' }"><a class="suggest">건의합니다</a></c:if>
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>