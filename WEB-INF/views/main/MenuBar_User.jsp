<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	
		<link rel="stylesheet" href="/hos/resources/css/menubar/menubar_user.css">
		<script src="/hos/resources/js/httpRequest.js"></script>
		<script src="/hos/resources/js/menubar_user.js"></script>
		
		<script>
			//로그아웃
			function logout() {
				if(!confirm("로그아웃 하시겠습니까?")){
					return;
				}else{
					location.href="logout.do";
				}
			}//logout
		</script>
		
	</head>
	<body>
		<div id="menubar" onmouseleave="hideMenubarContent()">
			<center>
				<div id="menubar_inner">
					<img src="/hos/resources/images/MEDICOMPILE LOGO.png" style="width: 100px; margin-right: 30px; cursor: pointer;"
						onclick="location.href='main.do?pat_idx=${sessionScope.patient.pat_idx}'">
					 
					<a id="reservation" onmouseover="reservationContent()">진료예약/안내</a>
						
					<a id="board" onmouseover="boardContent()">병원게시판</a>
						
					<a id="introduce" onmouseover="introduceContent()">병원안내</a>
						
					<a id="health" href="diagnosis_list.do"
					onmouseover="healthContent()">건강정보</a>
					
					<!-- 로그인 확인 처리 -->
					<c:if test="${empty sessionScope.patient}">
					    <a id="login" href="login_page.do" 
					       style="font-size: 18px; margin-right: 3px; color: gray;">로그인 |</a>
					    <a id="register" href="register_page.do" 
					       style="font-size: 18px; margin-left: 3px; color: gray;">회원가입</a>
					</c:if>
					
					<c:if test="${not empty sessionScope.patient}">
					    <a id="logout" onclick="logout();" 
					       style="font-size: 18px; margin-right: 3px; color: gray;">로그아웃 |</a>
					    <a id="mypage" onclick="location.href='mypage.do?pat_idx=${sessionScope.patient.pat_idx}'" 
					       style="font-size: 18px; margin-left: 3px; color: gray;">마이페이지</a>
					</c:if>
					
					<img src="/hos/resources/images/삼선.png" id="three_line">
					<img src="/hos/resources/images/X표시.png" id="X_image" style="display: none;">
					
					<div class="underline"></div>
				</div>
				<hr style="margin-top: 5px; border: 1px solid #d8d8d8;">	
			</center>
			
			<!-- 진료예약/안내 호버 시 -->	
			<div id="reservation_content">
				<jsp:include page="/WEB-INF/views/main/Menubar_Contents/Menubar_Reservation_Content.jsp"/>
			</div>
			
			<!-- 병원게시판 호버 시 -->	
			<div id="board_content">
				<jsp:include page="/WEB-INF/views/main/Menubar_Contents/Menubar_Board_Content.jsp"/>
			</div>
			
			<!-- 병원안내 호버 시 -->	
			<div id="introduce_content">
				<jsp:include page="/WEB-INF/views/main/Menubar_Contents/Menubar_Infomation_Content.jsp"/>
			</div>
			
			<!-- 건강정보 호버 시 -->	
			<div id="health_content" style="margin-top: 20px;"></div>
		</div>
		
		<!-- 빠른 메뉴 찾기 -->
		<div id="fast_menubar">
			<jsp:include page="/WEB-INF/views/main/Menubar_Contents/Menubar_Fast.jsp"/>
		</div>
		
	</body>
	<script>
		// 메뉴 항목(몇몇제외)과 underline 요소 선택
		var menuItems = document.querySelectorAll("#menubar_inner a:not(#login):not(#register):not(#logout):not(#mypage)");
		var underline = document.querySelector(".underline");
		
		// 각 메뉴 항목에 마우스 오버 이벤트 추가
		menuItems.forEach(function(item) {
		  item.addEventListener("mouseover", function(e) {
		 	
		    var rect = e.target.getBoundingClientRect();
		    var menuLeft = document.querySelector("#menubar_inner").getBoundingClientRect().left;
		
		    // underline의 크기와 위치 변경
		    underline.style.width = "80px";
		    underline.style.transform =
		        "translateX(" + (rect.left - menuLeft + rect.width / 2 - underline.offsetWidth / 2) + "px)";
		    underline.style.opacity = "1"; // underline 표시
		    
		  });
		});
		
		// 마우스가 menubar를 벗어날 때 underline 숨기기
		document.querySelector("#menubar").addEventListener("mouseleave", function() {
		  underline.style.opacity = "0"; // underline 숨김
		});
		//===========================================================================================
		document.getElementById('three_line').addEventListener('click', function() {
		    // fast_menubar 보이기
		    document.getElementById('three_line').style.display = 'none';
		    document.getElementById('X_image').style.display = 'block';
		    document.getElementById('fast_menubar').style.display = 'block';
		});
		
		document.getElementById('X_image').addEventListener('click', function() {
		    // fast_menubar 숨기기
		    document.getElementById('X_image').style.display = 'none';
		    document.getElementById('three_line').style.display = 'block';
		    document.getElementById('fast_menubar').style.display = 'none';
		});

	</script>
</html>


