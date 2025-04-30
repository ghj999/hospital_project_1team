<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ page session="false" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>예약 내역</title>
		<script src="/hos/resources/js/httpRequest.js"></script>
		<link rel="stylesheet" href="/hos/resources/css/mypage/reservation_list.css">
		
		<script>
			function cancel(res_idx) {
				if(!confirm("예약을 취소하시겠습니까?")){
					return;
				}
				let pat_idx = ${param.pat_idx};
				
				url="res_cancel.do";
				param="pat_idx="+ pat_idx + "&res_idx=" + res_idx;
				
				sendRequest(url, param, result_fn, "post");
				
			}
			
			function result_fn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if(json[0].result == "no"){
						alert("취소에 실패하였습니다.");
						return;
					}else{
						alert("예약이 취소되었습니다.");
						let pat_idx = json[1].pat_idx;
						location.href="mypage_reservation_list.do?pat_idx=" + pat_idx;
					}
				}
			}
			function change(pro_idx, res_idx) {
	            if(!confirm("예약을 변경하시겠습니까?")){
	               return;
	            }else{
	               alert("당일 시간 변경은 불가합니다.");
	               location.href="update_reservation.do?pro_idx="+ pro_idx +"&res_idx="+ res_idx; 
	            }
	         }
		</script>
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="main_div">
			<a id="reservation_text">예약 내역</a>
			<hr id="hr_main">
			
			<div id="sub_div">
				<c:choose>
					<c:when test="${empty list}">
						<div class="no_reservation">
							<a>예약내역이 존재하지 않습니다.</a>
							<input type="button" value="뒤로가기" onclick="history.back();">
						</div>
					</c:when>
					<c:otherwise>
						<!-- 예약내역 출력 -->
						<c:forEach var="vo" items="${list}" >
							<div class="reser_div">
							    <!-- 첨부된 이미지가 있는 경우에만 img태그를 사용 -->
								<c:if test="${ vo.pro_file ne 'no_file' }">
									<img src="${pageContext.request.contextPath}/resources/upload/${vo.pro_file}" style="width: 100px;"
										alt="교수 이미지">
								</c:if>
								<c:if test="${ vo.pro_file eq 'no_file' }">
									<img src="/hos/resources/images/MEDICOMPILE LOGO_sample.png" style="width: 100px;"
										alt="교수 이미지">
								</c:if>
							    <div class="dept_name">
							    	<input type="hidden" value="${vo.pro_idx}" id="pro_idx">
							    	<input type="hidden" value="${vo.res_idx}" id="res_idx">
							        <a class="dept">${vo.dept_name}</a>
							    </div>
							    
							    <table>
							        <tr>
							            <th>교수명</th>
							            <td class="name">${vo.pro_name}</td>
							        </tr>
							        <tr>
							            <th>진료일정</th>
							            <td class="res_time_td">${vo.res_time}</td>
							        </tr>
							        <tr>
							            <th>위치</th>
							            <td>${vo.dept_loc}</td>
							        </tr>
							        <tr>
							            <th>진료비 결제</th>
							            <c:choose>
							            	<c:when test="${vo.pay_chk eq 0}">
							            		<td>X</td>
							            	</c:when>
							            	<c:otherwise>
							            		<td>O</td>
							            	</c:otherwise>
							            </c:choose>
							        </tr>
							    </table>
							    
							    <div class="btn_div">
							        <input type="button" value="예약 취소" onclick="cancel(${vo.res_idx});">
							        <input type="button" value="예약 변경" onclick="change('${vo.pro_idx}', '${vo.res_idx}');">
							    </div>
							</div>
							<hr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>
