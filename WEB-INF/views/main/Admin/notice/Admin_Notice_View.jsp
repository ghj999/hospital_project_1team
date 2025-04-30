<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 상세보기</title>
		<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
		<link rel="stylesheet" href="/hos/resources/css/admin/notice/notice_view.css">
	</head>
	
	
	<body>
		<!-- 헤더,사이드바 -->
		<jsp:include page="/WEB-INF/views/main/Admin/Admin_Header.jsp"/>
		
		<!-- 콘텐츠 영역 -->
		<div class="admin-content-container">
			<div class="admin-content" id="admin-content">	
				<div class="scroll_container">
				<div id="container">
					<p>병원뉴스</p>
					
					<hr>
					
					<div id="title">
						<p>${vo.not_title}</p>
					</div>
					
					<hr>
					
					<div id="date">
						<p>작성일 : ${fn:split(vo.not_date, ' ')[0] }</p>
					</div>
					
					<hr>
					
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
										<a href="admin_notice_view.do?not_idx=${preNotice.not_idx}&page=${param.page}">${preNotice.not_title}</a>						
									</c:if>
									
									<c:if test="${preNotice eq null }">
										이전 글이 존재하지 않습니다.
									</c:if>
								</td>
							</tr>
							
							<tr>
								<th>다음글</th>
								<td>
									<c:if test="${nextNotice ne null}">
										<a href="admin_notice_view.do?not_idx=${nextNotice.not_idx}&page=${param.page}">${nextNotice.not_title}</a>							
									</c:if>
									
									<c:if test="${nextNotice eq null}">
										다음 글이 존재하지 않습니다.
									</c:if>
								</td>
							</tr>
						</table>
					</div>
					
					<div>			
						<input type="button" id="back_btn" value="목록으로"
							   onclick="location.href='admin_notice_list.do?page=${param.page}'">
					</div>
					
				</div>
			</div>
			</div>
		</div>
	</body>
</html>


