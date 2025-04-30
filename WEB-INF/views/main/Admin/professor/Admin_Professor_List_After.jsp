<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
		<link rel="stylesheet" href="/hos/resources/css/admin/professor/professor_list_after.css">
		<script src="/hos/resources/js/httpRequest.js"></script>
		
		<script>
			function professor_delete(pro_idx) {
				if(!confirm("해당 의료진의 정보를 삭제하시겠습니까?")){
					return;
				}
				
				let url = "admin_professor_delete.do";
				let param = "pro_idx=" + pro_idx;
				
				sendRequest(url, param, deleteFn, "POST");
			}
			
			function deleteFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if (json[0].result == "succ") {
			            alert("삭제가 완료되었습니다.");
			            location.href="admin_professor_list.do";
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
					<p>의료진관리</p>
					</center>
					
					<div class="content">		
						<div id="fix_content">
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
						</div>
				
						<div id="search_result">
							<!-- 검색 결과가 있는 경우 -->
							<c:if test="${not empty list}">
							    <div id="dynamic_content">
							        <div id="search_display">
							            <table class="professor_table">
							                <thead>
							                    <tr style="background-color: #f2f2f2">
							                        <th>교수 이미지</th>
							                        <th>교수 이름</th>
							                        <th>소속 부서</th>
							                        <th>전공 분야</th>
							                        <th>비고</th>
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
							                            <td>
							                            	<input type="button" value="정보삭제하기" class="btn_delete"
							                            		onclick="professor_delete(${vo.pro_idx});">
							                            </td>
							                        </tr>
							                    </c:forEach>
							                </tbody>
							            </table>
							        </div>
							        <div class="page_menu" style="margin: 0 auto;">
							            ${pageMenu}
							        </div>
							    </div>
							</c:if>
							
							<!-- 검색 결과가 없는 경우 -->
							<c:if test="${empty list}">
							    <div class="alert_warning" id="alert_warning">검색 결과가 없습니다.</div>
							</c:if>
							
							   
							<input type="button" value="의료진추가" class="btn_under"
								onclick="location.href='admin_professor_insert_form.do'">
							<input type="button" value="뒤로가기" class="btn_under" 
								style="background-color: white; color: #3086C9;"
									onclick="history.back();">  
						</div>
					</div>
					
				</div>
			</div>
			</div>
		</div>
	</body>
</html>