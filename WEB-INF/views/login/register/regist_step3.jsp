<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<link rel="stylesheet" href="/hos/resources/css/login/register_step3.css?version=2.0">
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
	<div id="main_div">
		<a id="register_text">회원 가입</a>
			
		<!-- 회원가입 단계 -->
		<table id="register_step" border="1">
			<tr>
				<td id="step1"><a>STEP1</a><br>약관동의</td>
				<td id="step2"><a>STEP2</a><br>회원정보</td>
				<td id="step3"><a>STEP3</a><br>가입완료</td>
			</tr>
		</table>
		
		<!-- 로고 + 설명글 -->
		<div id="expl_div">
			<img src="/hos/resources/images/check_icon.png">
			<a id="title">회원가입 완료</a>
			<a>${ pat_name } 님의 가입이 성공적으로 완료되었습니다.</a>
				
			<a>회원가입 내역 확인 및 수정은 마이페이지 > 회원정보수정에서 가능합니다.</a>
		</div>
		
		<input type="button" value="로그인하러 가기" onclick="location.href='login_page.do'">
		
	</div>
	<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
</body>
</html>