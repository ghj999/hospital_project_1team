<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


	<title></title>
		<link rel="stylesheet" href="resources/css/reservation/common.css">
		<!-- 3분할 공간 나누기 스타일 -->
		<link rel="stylesheet" href="/hos/resources/css/reservation/step1/step1.css">
		<!-- center영역 스타일 덮개-->
		<link rel="stylesheet" href="resources/css/reservation/step1/member_res.css">
		<!-- 진료과목 선택 드롭다운 메뉴  -->
		<link rel="stylesheet" href="resources/css/reservation/step1/medical_subject.css">
		<script src="/hos/resources/js/reservation/member_res.js"></script>
		<script src="resources/js/reservation/medical_subject.js"></script>
	
	</head>
	<body>
    <!-- 좌측 영역 -->
	    <div id="left">
          <div id="step1" class="left-contanier">
              <h2>회원 정보</h2>
              <hr>
              <div class="pat_name">
              <p>${sessionScope.patient.pat_name} 님</p>
              </div>
              <hr>
              <button onclick="logout(${param.pat_idx});">로그아웃</button>
              <br>
              <button onclick="history.back();">뒤로 가기</button>
              <br>
              <button onclick="location.href='mypage_reservation_list.do?pat_idx=${param.pat_idx}'">예약 현황 조회</button>
              <br>
              <hr>
              <h3>진료 예약</h3>
              <h1>1544-9970</h1>
          </div>
       </div>
	    <!-- 중앙 영역 -->
		<div id="center">
		    <div id="step1" class="center-container">
		            <form id="step1">
		                <div class="original">
		                    <h2>회원예약</h2>
		                    <!-- 본인 정보 입력 -->
		                    <hr>
		                    <div id="member_info">
		                        <b>1. 본인 정보 입력</b>
		                        <br>
		                        <input id="pat_name" name="회원명" value="${sessionScope.patient.pat_name}" disabled="disabled">
		                        <br>
		                        <b>2. 연락처</b>
		                        <br>
		                        <c:set var="phoneNumber" value="${sessionScope.patient.pat_phone}" />
								<c:set var="phoneParts" value="${fn:split(phoneNumber, '-')}" />
		                        <input id="pat_fornt" value="${ phoneParts[0]}" disabled="disabled"> -
		                        <input id="pat_middle" value="${ phoneParts[1]}" disabled="disabled"> -
		                        <input id="pat_back" value="${ phoneParts[2]}" disabled="disabled">
		                    </div>
		                    
		                    <!-- 연락처 입력 -->
		                    <div id="phone">
		                        <p><strong>3. 비상연락처</strong><pre>(예약자 본인이 연락을 받을 수 없는 경우)</pre></p>
		                        <div>
		                            <input name="front" id="front">
		                            -
		                            <input name="middle" id="middle">
		                            -
		                            <input name="back" id="back">
		                        </div>
		                    </div>
		                    
		                    <!-- 개인정보 수집 동의 -->
		                    <div id="agree">
		                        <p><strong>개인정보 수집, 이용 동의</strong></p>
		                        <p>
		                            개인정보는 병원정보 조회를 위해서만 사용합니다.
		                            <br>개인정보 이용에 동의합니다.
		                        </p>
		                    </div>
		                        <div>
		                            <input type="radio" name="check_agree" value="yes"> 동의 합니다.
		                            <input type="radio" name="check_agree" value="no"> 동의하지 않습니다.
		                        </div>
		                    
		                    <!-- 다음 버튼 -->
		                    <hr id="down">
		                    <div id="next">
		                        <input  type="button" value="다음" onclick="check();">
		                    </div>
		                </div>
		            </form>
		    </div>
		</div>


	
	    <!-- 우측 영역 -->
		<div id="right">
			<div id="medical_subject">
				<h2>진료과 선택</h2>
				<hr>
					<div id="box">
					    <ul class="dropdown">
					        <!-- 대분류 반복 -->
					        <c:forEach var="entry" items="${list}">
					            <li class="category">${entry.key} <!-- 대분류 -->
					                <ul class="subcategories">
					                    <!-- 소분류 반복 -->
					                    <c:forEach var="name" items="${entry.value}">
					                        <li data-name="${name}" onclick="goStep2(this);">
					                        ${name}
					                        </li>
					                    </c:forEach>
					                </ul>
					            </li>
					        </c:forEach>
					    </ul>
					</div>
				<hr>
				<input class="before" type="button" value="이전" onclick="hide();">
			</div>
		</div>


	</body>
</html>