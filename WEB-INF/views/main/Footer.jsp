<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<style>
		#footer {
		    background-color: #23507B; /* 배경 색상 */
		    color: #ffffff; /* 텍스트 색상 */
		    padding: 20px 0;
		    text-align: center;
		    font-family: Arial, sans-serif;
		}
		
		.footer-content {
		    margin-bottom: 15px; /* 아이콘 위쪽 여백 */
		}
		
		.footer-text {
		    font-size: 14px;
		    margin: 5px 0;
		}
		
		.footer-copyright {
		    font-size: 12px;
		    color: #cccccc;
		    margin: 5px 0;
		    margin-top: 10px;
		}
		
		.footer-icons {
		    display: flex;
		    justify-content: center; /* 아이콘들을 중앙 정렬 */
		    gap: 20px; /* 아이콘 간의 간격 */
		}
		
		.footer-icon {
		    width: 30px; /* 아이콘 크기 조정 */
		    height: 30px;
		    object-fit: contain; /* 이미지 비율 유지 */
		   	cursor: pointer;
		}
	</style>
	
	</head>
	<body>
		<footer id="footer">
		    <div class="footer-content">
		        <p class="footer-text">
		            주소: 06234 서울특별시 강남구 테헤란로 10길 9 그랑프리빌딩<br> 대표전화: 010-1111-1111 홈페이지 의견접수<br>
		            공동 대표자: 한준희, 김태윤, 고결, 김태희, 정기홍
		        </p>
		        <p class="footer-copyright">
		            COPYRIGHT 2025 MEDICOMFILE UNIVERSITY HOSPITAL. ALL RIGHTS RESERVED
		        </p>
		    </div>
		    <div class="footer-icons">
		        <img src="/hos/resources/images/유튜브.png" alt="유튜브 채널" class="footer-icon"
		        	onclick="location.href='https://www.youtube.com/'">
		        <img src="/hos/resources/images/페이스북.png" alt="페이스북 페이지" class="footer-icon"
		        	onclick="location.href='https://www.facebook.com/?locale=ko_KR'">
		        <img src="/hos/resources/images/트위터.png" alt="트위터 페이지" class="footer-icon"
		        	onclick="location.href='https://x.com/?lang=ko'">
		    </div>
		</footer>
	</body>
</html>