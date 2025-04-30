<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     
    
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	</head>
	<body>
		<!-- 로그인을 안 한 경우 -->
		<c:if test="${empty sessionScope.patient}">
			<div id="content_login_before">
				<p id="login_message">
					로그인 하시면<br>
					더욱 다양한 혜택을<br>
					이용하실 수 있습니다.
				</p>	
				<div style="margin-left: 330px;">
					<input type="button" class="login_buttons" value="로그인" 
						style="width: 200px; margin-top: 30px;" onclick="location.href='login_page.do'"><br>
					<input type="button" class="login_buttons" value="회원가입" 
						style="width: 200px;  margin-top: 5px;" onclick="location.href='register_page.do'">	
				</div>
			</div>
		</c:if>
			
		<!-- 로그인을 한 경우 -->
		<c:if test="${not empty sessionScope.patient}">
			<div id="content_login_after">
				<p id="welcome_message" style="font-size: 24px; display: inline-block;">
				${sessionScope.patient.pat_name}</p>님 환영합니다.<br>
				<p style="margin-left: 330px;">방문해 주셔서 감사합니다.</p>
				<div style="margin-left: 330px;">
					<input type="button" class="login_buttons" value="로그아웃" 
						style="width: 200px; margin-top: 30px;" onclick="logout(${param.pat_idx});"><br>
					<input type="button" class="login_buttons" value="예약확인" 
						style="width: 200px;  margin-top: 5px;" 
							onclick="location.href='mypage_reservation_list.do?pat_idx=${sessionScope.patient.pat_idx}'">
				</div>
			</div>	
		</c:if>
	</body>
</html>