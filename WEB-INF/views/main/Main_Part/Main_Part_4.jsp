<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div id="div_health">
			<p id="div_health_title" style="color: black;">건강정보</p>
			<p id="div_health_content" style="color: gray;">자가진단 서비스와 메디컴파일의 의료 시스템을 공개합니다.</p>
			
			<div class="div_health_div" style="padding: 10px;" 
				onclick="location.href='diagnosis_list.do'">
				<img src="/hos/resources/images/기침.PNG">
				<p>자가진단 서비스<br>
				<span style="font-size: 18px;">현재 증상을 확인하고 진료를 예약하세요.</span></p>
			</div>
			
			<div class="div_health_div" style="padding: 10px;"
				onclick="location.href='device_list.do'">
				<img src="/hos/resources/images/의료기기.PNG">
				<p>의료기기 정보<br>
				<span style="font-size: 18px;">의료기기들의 정보를 보실 수 있습니다.</span></p>
			</div>
		</div>
	</body>
</html>