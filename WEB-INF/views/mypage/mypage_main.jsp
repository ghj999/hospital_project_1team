<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>마이페이지</title>
        
        <link rel="stylesheet" href="/hos/resources/css/mypage/mypage_main.css?v=1.0">
    	
    	<script>
    		function withdrawal() {
				if(confirm("탈퇴하시겠습니까?")){
					if(confirm("· 회원 탈퇴 시\n    MediCompile 홈페이지에서 온라인 서비스를 이용하실 수 없습니다.\n\n"
							+ "· 회원 탈퇴 시\n    회원님의 회원정보가 모두 삭제되며 복구할 수 없습니다.")){
						location.href='mypage_withdrawal.do?pat_idx=' + ${param.pat_idx};
					}
				}
			}
    	</script>
    </head>
    <body>
    	<c:if test="${not empty success}">
		    <script>
		        alert("${success}");
		    </script>
		</c:if>
		
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<div id="main_div">
		
			<p id="mypage_title">마이페이지</p><br>
			
			<!-- 회원정보 및 회원정보수정칸 -->
	        <div id="patient_info_div">
	        
	            <a id="welcome_text">${sessionScope.patient.pat_name}</a><span>( 환자번호 : ${sessionScope.patient.pat_idx} )</span>
	            <hr>
	            <table id="patient_table">
	                <tr>
	                    <th>연락처</th>
	                    <td>&emsp;${sessionScope.patient.pat_phone}</td>
	                </tr>
	                <tr>
	                    <th>이메일</th>
	                    <td>&emsp;${sessionScope.patient.pat_email}</td>
	                </tr>
	                <tr>
	                    <th>주소</th>
	                    <td>&emsp;${sessionScope.patient.pat_address_road},<br>
	                        &emsp;${sessionScope.patient.pat_address_detail}</td>
	                </tr>
	            </table>

	            <input type="button" id="container1_btn1" value="회원정보 수정" class="mypage_btn"
	             onclick="location.href='mypage_update_form.do?pat_idx=${sessionScope.patient.pat_idx}'">
	            <input type="button" id="container1_btn2" value="회원 탈퇴" class="mypage_btn"
	             onclick="withdrawal();">
	        </div>
	        
	        <!-- 예약내역 -->
        	<div id="res_info_div" >
        		<a>예약내역조회</a><input class="mypage_btn" type="button"value="+" onclick="location.href='mypage_reservation_list.do?pat_idx=${sessionScope.patient.pat_idx}'">
        		<hr>
       			<c:choose>
        			<c:when test="${empty list}">
        				<p>예약내역이 존재하지 않습니다.</p>
        			</c:when>
        			<c:otherwise>
			       		<div id="res_ul_div">
			        		<ul>
				        		<c:forEach var="res" items="${ list }">
									<li>${ res.res_time } | ${ res.dept_name } (${ res.pro_name } 교수)</li>
				        		</c:forEach>
			        		</ul>
		       			</div>
	       			</c:otherwise>
       			</c:choose>
        	</div>
	        
	        <!-- 증명서 발급, 진료비결제, 작성글관리 등 -->
			<div id="etc_div">
			    <div class="container_cert" id="cert_div">
			        <a id="cert_text">증명서 발급 안내</a>
			        <hr>
			        <ul class="container_ul">
			            <li>진료 사실 확인서</li>
			            <li>진료비 납입 확인서</li>
			            <li>진료비 계산서, 영수증</li>
			            <li>처방전 사본</li>
			            <li>진단서 사본</li>
			        </ul>
			        <input type="button" class="container2_buttons" value="증명서 발급" class="mypage_btn"
			         onclick="location.href='mypage_certificates_print.do?pat_idx=${sessionScope.patient.pat_idx}'">
			    </div>
			    
			    <div class="container2">
					<a>온라인 진료비 결제</a>
					<hr>
					<p>수납창구 방문 없이<br> 온라인으로 진료비를 결제할 수 있습니다.</p>
			        <input type="button" class="container3_a" value="진료비결제" onclick="location.href='mypage_payment_page.do?pat_idx=${sessionScope.patient.pat_idx}'">
			    </div>
			    
			    <div class="container2">
					<a>나의 작성글 관리</a>
					<hr>
					<p>게시판에 작성한 글을<br> 수정, 삭제할 수 있습니다.</p>
			        <input type="button" class="container3_a" value="작성글관리" onclick="location.href='mypage_managing_posts.do?pat_idx=${sessionScope.patient.pat_idx}'">
			    </div>
			</div>
	        
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
    </body>
</html>




