<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항</title>
		<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
		<link rel="stylesheet" href="/hos/resources/css/admin/notice/notice_list.css">
		<script src="/hos/resources/js/httpRequest.js"></script>
		<script>
			window.onload = function(){
				let search = document.getElementById("search");
				let search_text = document.getElementById("search_text");
				
				let search_arr = ['all', 'not_title', 'not_content','title_content'];
				
				for( let i = 0; i < search_arr.length; i++){
					if( '${param.search}' === search_arr[i] ){
						search[i].selected = true;
						search_text.value = '${param.search_text}';
						break;
					}
				}
			} 
			//========================================================================
			// 검색 함수
			function notice_search() {
				let search = document.getElementById("search").value;
				let search_text = document.getElementById("search_text").value;
				let page = 1; // 첫 번째 페이지로 이동
				
				if (search != 'all' && search_text == '') {
					alert("검색할 내용을 입력하세요.");
					return;
				}
				
				// location.href를 사용하여 리다이렉트
				location.href = "admin_notice_list.do?search=" + search +
				    "&search_text=" + encodeURIComponent(search_text) +
				    "&page=" + page;
			}
			//========================================================================
			//공지사항 삭제
			function notice_delete(not_idx) {
				if(!confirm("해당 공지사항을 삭제하시겠습니까?")){
					return;
				}
				
				let url = "admin_notice_delete.do";
				let param = "not_idx=" + not_idx;
				
				sendRequest(url, param, delFn, "GET");
			}
			function delFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					//게시글 삭제 성공 시
					if(json[0].result == "succ"){
						alert("해당 공지사항을 삭제했습니다");
					}else{
						alert("해당 공지사항 삭제에 실패했습니다");
					}
					
					location.href="admin_notice_list.do";
				}
			}
		</script>
	</head>
	<body>
		<!-- 수정 알림 메시지 처리 -->
	    <c:if test="${not empty message}">
	        <script>
	            alert("${message}");
	        </script>
	    </c:if>
	
		<!-- 헤더,사이드바 -->
		<jsp:include page="/WEB-INF/views/main/Admin/Admin_Header.jsp"/>
		
		<!-- 콘텐츠 영역 -->
		<div class="admin-content-container">
			<div class="admin-content" id="admin-content">
				<div class="scroll_container">
				<div id="container">
					<center>
					<p>공지사항</p>
					</center>
					
					<div id="search_div">			
						<input type="button" value="공지사항 추가" class="buttons" style="width: 150px; height: 40px; margin-right: 500px;"
							onclick="location.href='admin_notice_insert_form.do'">	
								
						<select id="search" style="height: 40px;">
							<option value="all">전체보기</option>
							<option value="not_title">제목</option>
							<option value="not_content">내용</option>
							<option value="title_content">제목+내용</option>
						</select>
						<input id="search_text" style="height: 35px;">
						<input id="search_btn" type="button" value="검색" style="height: 45px;" onclick="notice_search();">
					</div>
					
					<!-- 검색 결과가 없는 경우 -->
					<c:if test="${empty list}">
						<div class="alert_warning">검색 결과가 없습니다.</div>
					</c:if>
					
					<c:if test="${!empty list}">
						<div id="notice_div">
							<table>
								<colgroup>
									<col width="5%"/>
									<col width="40%"/>
									<col width="25%"/>
									<col width="20%"/>
									<col width="15%"/>
								</colgroup>
							
								<tr style="background-color: #f4f4f4;">
									<th>번호</th>
									<th>제목</th>
									<th>작성일</th>
									<th>조회수</th>
									<th>비고</th>
								</tr>
								
								<c:forEach var="vo" items="${list}" varStatus="count">
									<tr>
										<td>${startIndex - count.index}</td>
										<td id="title_td">
											<a href="admin_notice_view.do?not_idx=${vo.not_idx}&page=${param.page}">${vo.not_title}</a>
										</td>
										<td>${fn:split(vo.not_date, ' ')[0] }</td>
										<td>${vo.not_hits}</td>
										<td>
											<input type="button" value="수정하기" class="buttons" style="margin-bottom: 5px;"
												onclick="location.href='admin_notice_update_form.do?not_idx=${vo.not_idx}&page=${param.page}'">
												
											<input type="button" value="삭제하기" class="buttons" 
												style="background-color: white; border: 1px solid #3086C9; color: #3086C9;"
													onclick="notice_delete(${vo.not_idx});">
										</td>
									</tr>
								</c:forEach>
								<tr style="margin: 0;">
									<td colspan="6" style="border-bottom: none;">
										${ pageMenu }
									</td>
								</tr>
							</table>
						</div>
					</c:if>
					
				</div>
				</div>
			</div>
		</div>
		
	</body>
</html>




