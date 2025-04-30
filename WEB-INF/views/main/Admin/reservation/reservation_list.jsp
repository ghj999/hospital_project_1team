<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
		<link rel="stylesheet" href="/hos/resources/css/admin/reservation/reservation_list.css">
		<script src="/hos/resources/js/httpRequest.js"></script>
		
		<script>
			// 모든 체크박스를 선택/해제하는 함수
			function toggleCheckboxes(masterCheckbox) {
			    const checkboxes = document.querySelectorAll('table td input[type="checkbox"]');
			    checkboxes.forEach(checkbox => {
			        checkbox.checked = masterCheckbox.checked;
			    });
			}
			//====================================================================
			//체크된 진료예약 전체 삭제	
			function delete_reservation_check(f) {
				// 체크된 체크박스 가져오기
			    const selectedCheckboxes = Array.from(f.querySelectorAll('input[name="res_idx"]:checked'));
				
			 	// 유효성 검사: 체크된 체크박스가 없을 경우 경고
			    if (selectedCheckboxes.length === 0) {
			        alert("삭제할 항목을 선택해주세요.");
			        return;
			    }
				
				if(!confirm("정말 삭제하시겠습니까?")){
					return;
				}
				
			 	// 체크된 체크박스의 값 가져오기
			    const selectedValues = selectedCheckboxes.map(checkbox => checkbox.value);
				
				let url = "delete_reservation_check.do";
				let param = "res_idx=" + selectedValues.join(",");
				
				sendRequest(url, param, delete_checkFn, "GET");	
			}
			function delete_checkFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
			        if (json[0].result == "succ") {
			            alert("삭제가 완료되었습니다.");
			            location.href="admin_reservation_list.do";
			        } else {
			            alert("삭제 중 오류가 발생했습니다.");
			        }
				}
			}
			//====================================================================
			//검색
			function search() {
				let search = document.getElementById("search").value;
				let search_text = document.getElementById("search_text").value;
				let page = 1; // 첫 번째 페이지로 이동
				
				if (search != 'all' && search_text == '') {
					alert("검색할 내용을 입력하세요.");
					return;
				}	
				
				// location.href를 사용하여 리다이렉트
				location.href = "admin_reservation_list.do?search=" + search +
				    "&search_text=" + encodeURIComponent(search_text) +
				    "&page=" + page;
			}
			//====================================================================
			window.onload = function(){
				let search = document.getElementById("search");
				let search_text = document.getElementById("search_text");
				
				let search_arr = ['all', 'pat_name', 'pro_name','pat_pro_name'];
				
				for( let i = 0; i < search_arr.length; i++){
					if( '${param.search}' === search_arr[i] ){
						search[i].selected = true;
						search_text.value = '${param.search_text}';
						break;
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
					<p>진료예약</p>
					</center>
					
					<div style="display: inline-block; float: right; margin-bottom: 20px;">
						<select id="search" style="height: 40px;">
							<option value="all">전체보기</option>
							<option value="pat_name">환자명</option>
							<option value="pro_name">교수명</option>
							<option value="pat_pro_name">환자명+교수명</option>
						</select>
						<input id="search_text" style="width: 180px; height: 35px; outline: none;">
						<input type="button" value="검색" class="btn_search" onclick="search();">
					</div>
					<br>
					
					<!-- 검색 결과가 없는 경우 -->
					<c:if test="${empty res_list}">
						<div class="alert_warning">검색 결과가 없습니다.</div>
					</c:if>
					
					<c:if test="${!empty res_list}">
						<form>
							<table id="reservation_table">
								<colgroup>
									<col width="5%">
									<col width="10%">
									<col width="15%">
									<col width="25%">
									<col width="20%">
									<col width="12.5%">
									<col width="12.5%">
								</colgroup>
							
								<tr>
									<th><input type="checkbox" onclick="toggleCheckboxes(this)"></th>
									<th>예약번호</th>
									<th>환자이름</th>
									<th>교수이름(진료과)</th>
									<th>예약날짜</th>
									<th>예약여부</th>
									<th>결제여부</th>
								</tr>
								<c:forEach var="vo" items="${res_list}">
									<tr>
										<td><input type="checkbox" name="res_idx" value="${vo.res_idx}"></td>
										<td>${vo.res_idx}</td>				
										<td>${vo.pat_name}</td>				
										<td>${vo.pro_name}<br>(${vo.dept_name})</td>				
										<td>${vo.res_time.substring(0, 10)}<br>
										${vo.res_time.substring(10, 16)}</td>
										
										<!-- 예약 여부 -->
										<c:if test="${vo.res_chk eq 1}">
											<td style="color: #12B8BA;">예약완료</td>
										</c:if>	
										<c:if test="${vo.res_chk eq 0}">
											<td style="color: #d2d2d2;">예약취소</td>
										</c:if>	
										
										<!-- 결제 여부 -->
										<c:if test="${vo.pay_chk eq 1}">
											<td style="color: #12B8BA;">결제완료</td>
										</c:if>	
										<c:if test="${vo.pay_chk eq 0}">
											<td style="color: red;">결제미완료</td>
										</c:if>		
									</tr>
								</c:forEach>
								
								<tr>
								    <td colspan="7" style="border: none; text-align: center; position: relative;">
								        <div style="display: inline-block;">
								            ${pageMenu}
								        </div>
								        <input type="button" value="선택삭제" id="btn_delete" onclick="delete_reservation_check(this.form);"
								               style="position: absolute; right: 0; top: 50%; transform: translateY(-50%);">
								    </td>
								</tr>
							</table>
						</form>
					</c:if>
					
					
				</div>
			</div>
			</div>
		</div>	
		
	</body>
</html>


