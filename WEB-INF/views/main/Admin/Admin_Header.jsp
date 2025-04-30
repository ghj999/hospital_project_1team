<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 헤더 -->
	<div class="admin-header" style="border-bottom: 3px solid #23507B; z-index: 100;">
		<div class="logo">
			<img src="/hos/resources/images/MEDICOMPILE LOGO_white.png"
				style="width: 80px; margin-right: 20px;"> 
				<span style="font-size: 24px;">MEDICOMFILE ADMIN</span>
		</div>

		<!-- 오른쪽 전체 nav 묶음 -->
		<div class="nav-container">
			<div class="nav">
				<img src="/hos/resources/images/profile2.png">
				<div>
					<p>${sessionScope.patient.pat_name}</p>
					<p>${sessionScope.patient.pat_email}</p>
				</div>
			</div>
			<div class="nav" onclick="location.href='login_page.do'">
				<p>로그인 화면으로 이동</p>
			</div>
		</div>
	</div>

	<!-- 사이드바 -->
	<div class="admin-sidebar">
		<ul>
			<p>컨텐츠</p>
			<hr style="margin-bottom: 10px; border: 1px solid white;">
			<li onclick="location.href='admin_notice_list.do'">공지사항 게시글 관리</li>
			<li onclick="location.href='admin_volunteer_list.do?pat_idx=${sessionScope.patient.pat_idx}'">자원봉사 게시글 관리</li>
			<li onclick="location.href='admin_calling_list.do'">상담예약 관리</li>
			<li onclick="location.href='admin_reservation_list.do'">진료예약 관리</li>
			<li onclick="location.href='admin_professor_list_before.do'">의료진 관리</li>
			<li onclick="location.href='admin_banner_list.do'">배너 관리</li>
		</ul>
	</div>

</body>
</html>


