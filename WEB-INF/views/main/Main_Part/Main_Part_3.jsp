<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div id="div_come">
			<p id="div_come_title" style="color: black;">오시는 길</p>
			<p class="div_come_content">메디컴파일로 오시는 길을 알려드립니다.</p>	
			<div class="div_come_div" onclick="location.href='floor_info.do'">
				<img src="/hos/resources/images/메인_층별안내.png">
				<p>층별안내</p>
			</div>
			<div class="div_come_div" onclick="location.href='parking_info.do'">
				<img src="/hos/resources/images/메인_주차안내.png" style="max-width: 90%; max-height: 90%;">
				<p>주차안내</p>
			</div>
				
			<center>
				<div id="div_come_map">
					<jsp:include page="/WEB-INF/views/main/ComeMap.jsp"/>
				</div>
				<p class="div_come_content">서울특별시 강남구 테헤란로 10길 9 그랑프리빌딩</p>
			</center>
		</div>
	</body>
</html>