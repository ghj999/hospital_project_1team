<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 찾기</title>
	
	<link rel="stylesheet" href="/hos/resources/css/login/find_id_page.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
	<div id="main_div">
		<hr>
	 	<p>아이디를 확인하신 후 로그인 해주시기 바랍니다.</p>
	 	<a>아이디 : <b>${ param.pat_id }</b></a>
	 	<input id="main_btn" type="button" value="메인으로 이동" onclick="location.href='main.do'">
	 	<input id="login_btn" type="button" value="로그인" onclick="location.href='login_page.do'">
		<hr>
	</div>
	
	<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
</body>
</html>