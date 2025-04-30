<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
    
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
	<link rel="stylesheet" href="/hos/resources/css/admin/volunteer/volunteer_list.css">
	<script src="/hos/resources/js/httpRequest.js"></script>
	
	<script>
		window.onload = function(){
			let search = document.getElementById("search");
			let search_text = document.getElementById("search_text");
				
			let search_arr = ['all', 'vol_title', 'vol_content', 'title_content'];
				
			for( let i = 0; i < search_arr.length; i++ ){
				if( '${param.search}' === search_arr[i] ){
					search[i].selected = true;
					search_text.value = '${param.search_text}';
					break;
				}
			}
		}
		//=======================================================================
		//검색
		function search( pat_idx ){
			let search = document.getElementById("search").value;
			
			let search_text = document.getElementById("search_text").value;
			
			if( search != 'all' && search_text === '' ){
				alert("검색할 내용을 입력하세요.");
				return;
			}
			location.href="admin_volunteer_list.do?search="+search+
					  "&search_text="+encodeURIComponent(search_text)+
					  "&page=1";
		}
		//전체보기 선택 시 텍스트 비우기
		function clearText(){
			let search = document.getElementById("search").value;
			let search_text = document.getElementById("search_text");
			
			if( search === 'all' ){
				search_text.value = '';
			}
		}
		//================================================================
		function volunteer_delete(vol_idx) {
			if(!confirm("해당 게시글의 정보를 삭제하시겠습니까?")){
				return;
			}
			
			let url = "admin_volunteer_delete.do";
			let param = "vol_idx=" + vol_idx;
			
			sendRequest(url, param, deleteFn, "POST");
		}
		
		function deleteFn() {
			if(xhr.readyState == 4 && xhr.status == 200){
				let data = xhr.responseText;
				let json = ( new Function('return '+data) )();
				
				if (json[0].result == "succ") {
		            alert("삭제가 완료되었습니다.");
		            location.href="admin_volunteer_list.do";
		        } else {
		            alert("삭제 중 오류가 발생했습니다.");
		        }
				
			}
		}
	</script>
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
						<p>자원봉사</p>
						</center>
						
						<div id="search_div">
							<input type="button" value="자원봉사 공지 추가" class="buttons" 
								style="width: 150px; height: 40px; margin-right: 480px;"
									onclick="location.href='admin_volunteer_insert_form.do'">	
							
							<select id="search" onchange="clearText()">
								<option value="all">전체보기</option>
								<option value="vol_title">제목</option>
								<option value="vol_content">내용</option>
								<option value="title_content">제목+내용</option>
							</select>
									
							<input id="search_text">
							<input id="search_btn" type="button" value="검색" onclick="search(${param.pat_idx});">
						</div><br>
						
						<!-- 검색 결과가 없는 경우 -->
						<c:if test="${empty list}">
							<div class="alert_warning">검색 결과가 없습니다.</div>
						</c:if>
						
						<c:if test="${!empty list}">
							<div id="volunteer_div">
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
										<th>등록일</th>
										<th>조회수</th>
										<th>비고</th>
									</tr>
									
									<c:forEach var="vo" items="${list}" varStatus="count">
										<tr>
											<td>${startIndex - count.index}</td>
											<td class="title_td">
												<a href="admin_volunteer_view.do?vol_idx=${vo.vol_idx}&page=${param.page}">${vo.vol_title}</a>
											</td>
											<td class="date_td">${fn:split(vo.vol_date, ' ')[0]}</td>
											<td class="hit_td">${vo.vol_hits}</td>
											<td>
												<input type="button" value="삭제하기" class="btn_delete"
							                    	onclick="volunteer_delete(${vo.vol_idx});">
											</td>
										</tr>
									</c:forEach>
								</table>
							</div>
							
							<div id="page">
								${pageVol}
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		
	</body>
</html>


