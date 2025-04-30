<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 상세보기</title>
		
		<link rel="stylesheet" href="resources/css/info/hos_notice_view.css">
		
	</head>
	
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="container">
			<p>공지사항</p>
			
			<hr class="line1">
			
			<div id="title">
				<p>${vo.not_title}</p>
			</div>
			
			<hr class="line2">
			
			<div id="date">
				<p>작성일 : ${fn:split(vo.not_date, ' ')[0] }</p>
			</div>
			
			<hr class="line2">
			
			<div id="content">
				<pre>${vo.not_content}</pre>
			</div>
			
			<div id="img">
				<!-- 첨부된 이미지가 있는 경우에만 img태그를 사용 -->
				<c:if test="${ vo.not_file ne 'no_file' }">
					<img src="${pageContext.request.contextPath}/resources/upload/${vo.not_file}" style="max-width: 200px;">
				</c:if>
			</div>
			
			<div id="pre_next_div">
				<table>
					<tr>
						<th>이전글</th>
						<td>
							<c:if test="${preNotice ne null}">
								<a href="info_notice_view.do?not_idx=${preNotice.not_idx}&page=${param.page}">${preNotice.not_title}</a>						
							</c:if>
							
							<c:if test="${preNotice eq null }">
								<a>이전 글이 존재하지 않습니다.</a>
							</c:if>
						</td>
					</tr>
					
					<tr>
						<th>다음글</th>
						<td>
							<c:if test="${nextNotice ne null}">
								<a href="info_notice_view.do?not_idx=${nextNotice.not_idx}&page=${param.page}">${nextNotice.not_title}</a>							
							</c:if>
							
							<c:if test="${nextNotice eq null}">
								<a>다음 글이 존재하지 않습니다.</a>
							</c:if>
						</td>
					</tr>
				</table>
			</div>
			
			<div id="btn_div">			
				<input type="button" id="back_btn" value="목록으로"
					   onclick="location.href='info_notice_list.do?page=${param.page}'">
			</div>
			
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
		
	</body>
</html>