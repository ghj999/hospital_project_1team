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
		<link rel="stylesheet" href="/hos/resources/css/admin/professor/professor_insert_form.css">
		<script src="/hos/resources/js/httpRequest.js"></script>
		
		<script>
			document.addEventListener("DOMContentLoaded", function () {
			    const deptButtons = document.querySelectorAll(".btn_dept");
			    const weekdayButtons = document.querySelectorAll(".btn_weekday");
			    const weekdaysInput = document.getElementById("weekdays");
			    
			    // 진료과 버튼 하나만 선택되도록 설정
			    deptButtons.forEach(button => {
			        button.addEventListener("click", function () {
			            deptButtons.forEach(btn => btn.classList.remove("active")); // 기존 선택 해제
			            this.classList.add("active"); // 클릭한 버튼 활성화
			            // hidden input에 dept_idx 값을 설정
			            document.getElementById("dept_idx").value = this.value;
			        });
			    });
	
			    // 진료 가능 요일 버튼 여러 개 선택 가능하도록 설정
			    weekdayButtons.forEach(button => {
			        button.addEventListener("click", function () {
			            this.classList.toggle("active"); // 선택 상태를 toggle
			            const selectedWeekdays = Array.from(weekdayButtons)
			                                          .filter(btn => btn.classList.contains("active"))
			                                          .map(btn => btn.value);
			            weekdaysInput.value = selectedWeekdays.join(","); // 선택된 요일 값을 문자열로 설정
			        });
			    });
			});
			//====================================================================================
			function professor_insert(f) {
			    let selectedDept = document.querySelector(".btn_dept.active");
			    let pro_name = document.querySelector("input[name='pro_name']");
			    let pro_field = document.querySelector("input[name='pro_field']");
			    let selectedWeekdays = document.querySelectorAll(".btn_weekday.active");

			    if (!selectedDept) {
			        alert("진료과를 선택하세요");
			        return;
			    }
			    if (!pro_name.value.trim()) {
			        alert("의료진의 이름을 입력하세요");
			        return;
			    }
			    if (!pro_field.value.trim()) {
			        alert("전공 분야를 입력하세요");
			        return;
			    }
			    if (selectedWeekdays.length === 0) {
			        alert("진료가능 요일을 선택하세요");
			        return;
			    }

			    // 선택된 요일 값을 배열로 저장
			    let weekdays = [];
			    selectedWeekdays.forEach(btn => {
			        weekdays.push(btn.value);
			    });
				
			    f.method = "post";
				f.action = "admin_professor_insert.do";
				f.submit();
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
					<p>의료진추가</p>
					</center>
					
					<form enctype="multipart/form-data">
						<input type="hidden" name="dept_idx" id="dept_idx">
						<input type="hidden" name="weekdays" id="weekdays">
						<table>
							<colgroup>
								<col width="10%"/>
								<col width="10%"/>
								<col width="80%"/>
							</colgroup>
							
						    <tr>
						        <th rowspan="4">진료과 선택</th> 
						    </tr>
						    <c:set var="categories" value="일반,내과,외과"/>
						    <c:forEach var="category" items="${fn:split(categories, ',')}">
						        <tr>
						            <th>${category}</th>
						            <td>
						                <c:forEach var="vo" items="${list}">
										    <c:if test="${vo.dept_category == category}">
										        <button type="button" class="btn_dept" name="dept_name"
										        	value="${vo.dept_idx}">${vo.dept_name}</button>
										    </c:if>
										</c:forEach>
						            </td>
						        </tr>
						    </c:forEach>
						    
						    <tr>
						    	<th colspan="2">의료진 이름</th>
						    	<td>
						    		<input placeholder="의료진의 이름을 입력하세요" 
						    			class="pro_table_input" name="pro_name">
						    	</td>
						    </tr>
						    <tr>
						    	<th colspan="2">전공 분야</th>
						    	<td>
						    		<input placeholder="의료진의 전공을 입력하세요" 
						    			class="pro_table_input" name="pro_field">
						    	</td>
						    </tr>
						    <tr>
						    	<th colspan="2">의료진 사진</th>
						    	<td>
						    		<input type="file" name="photo" class="pro_table_input">
						    	</td>
						    </tr>
						    <tr>
						    	<th colspan="2">진료가능요일</th>
						    	<td>
						    		<button type="button" class="btn_weekday" name="weekday" value="2">월요일</button>
						    		<button type="button" class="btn_weekday" name="weekday" value="3">화요일</button>
						    		<button type="button" class="btn_weekday" name="weekday" value="4">수요일</button>
						    		<button type="button" class="btn_weekday" name="weekday" value="5">목요일</button>
						    		<button type="button" class="btn_weekday" name="weekday" value="6">금요일</button>
						    		<button type="button" class="btn_weekday" name="weekday" value="0">토요일</button>
						    		<button type="button" class="btn_weekday" name="weekday" value="1">일요일</button>
						    	</td>
						    </tr>
						    
						    <tr>
						    	<td colspan="3" align="center" style="border: none;">
						    		<input type="button" value="의료진추가" class="btn_under"
						    			onclick="professor_insert(this.form);">
						    		<input type="button" value="취소하기" class="btn_under" 
						    			style="background-color: white; color: #12B8BA;"
						    				onclick="history.back();">
						    	</td>
						    </tr>
						</table>
					</form>

				</div>
			</div>	
			</div>
		</div>
		
	</body>
</html>