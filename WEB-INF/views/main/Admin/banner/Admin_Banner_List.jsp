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
		<link rel="stylesheet" href="/hos/resources/css/admin/banner/banner_list.css">
		<script src="/hos/resources/js/httpRequest.js"></script>
		
		<script>
			//배너 사용여부 수정
			function updateBanner_chk(banner_idx, isChecked) {
			    // 상태값을 숫자로 변환 (1: 배너사용, 0: 미사용)
			    const status = isChecked ? 1 : 0;
	
			    let url = "admin_banner_update.do";
			    let param = "banner_idx=" + banner_idx + "&banner_chk=" + status;
			    
			    sendRequest(url, param, updateFn, "GET");
			}
			function updateFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if (json[0].result == "fail") {
						alert("수정 중 오류가 발생했습니다.");
			        }//if
				}	
			}
			//======================================================================================
			// 모든 체크박스를 선택/해제하는 함수
			function toggleCheckboxes(masterCheckbox) {
			    const checkboxes = document.querySelectorAll('input[name="banner_idx"]');
			    checkboxes.forEach(checkbox => {
			        checkbox.checked = masterCheckbox.checked;
			    });
			}
			//======================================================================================
			//체크된 상담예약 전체 삭제	
			function delete_banner_check(f) {
				// 체크된 체크박스 가져오기
			    const selectedCheckboxes = Array.from(f.querySelectorAll('input[name="banner_idx"]:checked'));
				
			 	// 유효성 검사: 체크된 체크박스가 없을 경우 경고
			    if (selectedCheckboxes.length == 0) {
			        alert("삭제할 항목을 선택해주세요.");
			        return;
			    }
				
				if(!confirm("정말 삭제하시겠습니까?")){
					return;
				}
				
			 	// 체크된 체크박스의 값 가져오기
			    const selectedValues = selectedCheckboxes.map(checkbox => checkbox.value);
				
				let url = "admin_delete_banner.do";
				let param = "banner_idx=" + selectedValues.join(",");
				
				sendRequest(url, param, delete_checkFn, "GET");	
			}
			function delete_checkFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
			        if (json[0].result == "succ") {
			            alert("삭제가 완료되었습니다.");
			            location.href="admin_banner_list.do";
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
				<center>
					<form>
						<input type="hidden" value="${vo.banner_file}" name="banner_file">
					    <div id="container">
						    <p>배너</p>
						    <table>
						    	<colgroup>
									<col width="10%">
									<col width="40%">
									<col width="10%">
									<col width="40%">
								</colgroup>
						        <thead>
						            <tr>
						                <th><input type="checkbox" onclick="toggleCheckboxes(this)"></th>
						                <th>배너명</th>
						                <th>사용</th>
						                <th>미리보기</th>
						            </tr>
						        </thead>
						        <tbody>
						        	<c:forEach var="vo" items="${list}">
							            <tr>
							                <td><input type="checkbox" name="banner_idx" value="${vo.banner_idx}"></td>
							                
							                <td>${vo.banner_name}</td>
							                
							                <td>
											    <!-- 토글 스위치 -->
											    <label class="toggle-switch">
											        <input type="checkbox" 
											        	onchange="updateBanner_chk(${vo.banner_idx}, this.checked);" 
											               <c:if test="${vo.banner_chk == 1}">checked</c:if>>
											        <span class="slider"></span>
											    </label>
											</td>
							                
							                <td class="image-preview">
							                	<c:if test="${vo.banner_file ne null}">
											        <img src="/hos/resources/upload/${vo.banner_file}" 
											        	alt="배너 이미지">
											    </c:if>
							                </td>
							            </tr>
						        	</c:forEach>
						        </tbody>
						    </table>
							<div class="actions">
								<input type="button" class="add" value="추가"
									onclick="location.href='admin_insert_banner_page.do'">
								<input type="button" class="delete" value="선택 삭제"
									onclick="delete_banner_check(this.form);">
							</div>
						</div>
					</form>
				</center>
			</div>
			</div>
		</div>
		
	</body>
</html>

