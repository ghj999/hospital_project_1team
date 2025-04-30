<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
	</head>
	<body>
		<center>
			<div id="div_depth">
				<p id="div_depth_title">예약 서비스 및 진료과/의료진</p>
				<p id="div_depth_contents">정확하고 빠른 예약 시스템과 진료과,의료진 검색 서비스를 제공 받으실 수 있습니다.</p>	
				<div class="div_depth_div" style="background-color: #3086C9;"
					onclick="location.href='step1.do?pat_idx=${param.pat_idx}'">
					<img src="/hos/resources/images/메인_예약.png">
					<h6>진료예약</h6>
					<hr>
					<p>빠르고 쉬운 진료예약</p>
				</div>				
				<div class="div_depth_div" style="background-color: #12B8BA;"
					onclick="location.href='searchMain.do'">
					<img src="/hos/resources/images/메인_의료진.png">
					<h6>의료진 보기</h6>
					<hr>
					<p>메디컴파일의 의료진을 상세히 확인</p>
				</div>		
				<div class="div_depth_div" style="background-color: #3086C9;"
					onclick="location.href='mypage_certificates_print.do?pat_idx=${param.pat_idx}'">
					<img src="/hos/resources/images/메인_증명서.png">
					<h6>증명서 발급</h6>
					<hr>
					<p>증명서 발급 안내 및 발급</p>
				</div>
			</div>
		</center>		
	</body>
</html>