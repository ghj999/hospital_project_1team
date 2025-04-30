<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
		
		<link rel="stylesheet" href="/hos/resources/css/login/login.css">
		
		<script src="/hos/resources/js/httpRequest.js"></script>
		<script src="/hos/resources/js/login/login.js"></script>
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<!-- 로그인 메인 div -->
		<div id="main_div">
			<div id="login_div">
				<img src="/hos/resources/images/MEDICOMPILE LOGO.png">
				<a id="login_text">로그인</a>
				<a id="login_sub_text">MediCompile 홈페이지의 서비스는<br>로그인 후 이용하실 수 있습니다.</a>
				
				<form id="login_form">
					<input name="pat_id" placeholder="아이디를 입력해주세요" size="30">
					<input name="pat_pwd" type="password" placeholder="비밀번호를 입력해주세요" size="30">
					<input id="login_btn" type="button" value="로그인" onclick="login(this.form);">
				</form>
				
				<div id="btn_div">
					<a class="btn" type="button"onclick="location.href='login_find_id_form.do'">아이디 찾기</a>
					<a>|</a>
					<a class="btn" type="button"onclick="location.href='login_find_pwd_form.do'">비밀번호 찾기</a>
					<a>|</a>
					<a class="btn" type="button" onclick="location.href='register_page.do'">회원가입</a><br>
					
					<div id="naver_login" onclick="location.href='register_step1_naver.do'">
					    <img src="/hos/resources/images/btnW_아이콘사각.png" alt="네이버 아이콘"/>
					    <a>네이버로 간편가입</a>
					</div>
				</div>
				
			</div>  
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>