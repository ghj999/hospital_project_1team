<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>온라인 진료비 결제</title>
		
		<link rel="stylesheet" href="/hos/resources/css/mypage/payment_page.css">
		
		<script>
			window.addEventListener('message', function(event) {
	            if (event.data === 'paymentSuccess') { // 결제 성공 메시지를 받으면 리스트 갱신 요청
	                location.reload();  // 페이지를 새로 고쳐서 예약 목록을 갱신
	            }
	        });
			
			// 조회버튼 클릭
			function set_period() {
			    let start_day = document.getElementById("start_day").value;
			    let end_day = document.getElementById("end_day").value;

			    if (!start_day || !end_day) {
			        alert("시작일과 종료일을 모두 입력해주세요.");
			        return;
			    }

			    if (start_day > end_day) {
			        alert("종료일은 시작일 이후여야 합니다.");
			        return;
			    }

			    let rows = document.querySelectorAll("#payment_list tr");
			    rows.forEach(row => {
			        let res_time = row.querySelector("td:nth-child(2)")?.innerText.trim() || "";
			        let res_date = res_time.split(" ")[0];

			        if (res_date >= start_day && res_date <= end_day) {
			            row.style.display = "";
			        } else {
			            row.style.display = "none";
			        }
			    });
			}

			// 전체조회버튼 클릭
			function all_period() {
			    document.getElementById("start_day").value = "";
			    document.getElementById("end_day").value = "";

			    let rows = document.querySelectorAll("#payment_list tr");
			    rows.forEach(row => {
			        row.style.display = ""; // 모든 행을 보이도록 설정
			    });
			}
						
			let total = 0;
			function calc_total(checkbox) {
			    let value = parseInt(checkbox.value, 10);

			    if (checkbox.checked) {
			        total += value;
			    } else {
			        total -= value;
			    }

			    let paymentBtn = document.getElementById("payment_btn");
			    paymentBtn.value = total + "원 결제진행";
			}
			
			//전체 선택
			function selectAll(masterCheckbox) {
			    let checkboxes = document.querySelectorAll("#payment_list input[type='checkbox']");
			    checkboxes.forEach(checkbox => {
			        checkbox.checked = masterCheckbox.checked;
			        calc_total(checkbox); // 체크 상태 변경 시 총 결제금액도 업데이트
			    });
			}

			// 결제버튼 클릭
			function payment_btn() {
			    if (isNaN(total) || total <= 0) {
			        alert("결제할 항목을 선택해주세요.");
			        return;
			    }

			    let openUrl = "mypage_payment_popup.do";
			    let popupName = 'paymentPopup';
			    let popupOption = "width=650px, height=900px, top=40px, left=200px, scrollbars=yes";

			    // 팝업 창 열기
			    let paymentWindow = window.open(openUrl, popupName, popupOption);

			    // 결제에 필요한 데이터
			    let paymentDetails = [];
			    let rows = document.querySelectorAll("#payment_list tr");
			    rows.forEach(row => {
			        let checkbox = row.querySelector("input[type='checkbox']");
			        
			        if (checkbox && checkbox.checked) {
			            // 각 항목의 res_idx를 가져옵니다. (숨겨진 첫 번째 td)
			            let res_idx = row.querySelector("td:nth-of-type(1)").innerText.trim(); // 숨겨진 예약번호
			            let res_time = row.querySelector("td:nth-of-type(3)").innerText.trim(); // 진료일
			            let dept_name = row.querySelector("td:nth-of-type(4)").innerText.trim(); // 진료과(담당교수)
			            let dept_payment = parseInt(row.querySelector("td:nth-of-type(5) span").innerText.trim().replace("원", "")); // 진료비
			            // 결제 상세 정보에 예약번호(res_idx) 추가
			            paymentDetails.push({
			            	res_idx: res_idx,
			            	res_time: res_time,
			            	dept_name: dept_name,
			            	dept_payment: dept_payment
			            });
			        }
			    });

			    // 팝업 창이 로드된 후에 데이터를 postMessage로 전달
			    paymentWindow.onload = function() {
			        paymentWindow.postMessage({
			            total: total,
			            paymentDetails: paymentDetails,
			            pat_idx: document.getElementById("pat_idx").value,
			            pat_email: document.getElementById("pat_email").value,
			            pat_name: document.getElementById("pat_name").value,
			            pat_phone: document.getElementById("pat_phone").value
			        }, "*");
			    }
			}
		</script>
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<div id="main_div">
			<div>
				<a id="payment_text">온라인 진료비 결제</a>
				
				<input type="hidden" id="pat_idx" value="${list[0].pat_idx}">
				<input type="hidden" id="pat_email" value="${list[0].pat_email}">
				<input type="hidden" id="pat_name" value="${list[0].pat_name}">
				<input type="hidden" id="pat_phone" value="${list[0].pat_phone}">
				
				<c:choose>
					<c:when test="${ empty list }">
						<div class="no_reservation">
							<hr>
							<a>예약내역이 존재하지 않습니다.</a>
							<input type="button" value="뒤로가기" onclick="history.back();">
						</div>
					</c:when>
				
					<c:otherwise>
						<div id="date_div">
							<a id="start_text">시작일</a>
							<a id="end_text">종료일</a>
			
							<br>
							<form>
								<input id="start_day" type="date">
								<input id="end_day" type="date">
								<input id="date_btn" type="button" value="조회" onclick="set_period(this.form);">
								<input id="all_btn" type="button" value="전체조회" onclick="all_period(this.form);">
							</form>
						
							<table>
								<tr id="result_div">
									<th id="th_none" style="background-color: #12B8BA;">
									    <input type="checkbox" id="select_all" onchange="selectAll(this);">
									</th>

									<th><a class="category">진료일</a></th>
									<th><a class="category">진료과(담당교수)</a></th>
									<th><a class="category">진료비</a></th>
								</tr>
								
								<!-- 지불해야 할 진료비 리스트 -->
								<tbody id="payment_list">
								<c:forEach var="vo" items="${ list }">
									<tr>
										<td style="display:none;">${ vo.res_idx }</td> <!-- 예약번호 표시(숨김) -->
										<td style="background-color: white; text-align: center; padding-left: 0px;">
											<input type="checkbox" id="1" value="${ vo.dept_payment }" onchange="calc_total(this);">
										</td>
										<td>${ vo.res_time }</td>
										<td><a>${ vo.dept_name } (${ vo.pro_name })</a></td>
										<td><a>${ vo.dept_payment }원</a>
											<span style="display:none;">${vo.dept_payment}</span>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							
							<input id="payment_btn" type="button" value="0원 결제진행" onclick="payment_btn();">
						</div>
					</c:otherwise>
						
				</c:choose>
			</div>
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>
