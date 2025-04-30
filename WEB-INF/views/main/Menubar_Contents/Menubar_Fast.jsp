<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<style>
			*{
			margin: 0; 
			padding: 0;
			list-style: none;
			}
			
			#fast_menubar_title{
				font-size: 40px;
				margin-bottom: 10px;
			}
			
			/* 컨테이너 스타일 */
			.menu-container {
			    display: flex; /* 플렉스 박스 사용 */
			    justify-content: space-between; /* 열 사이의 간격 균등 분배 */
			    padding: 20px;
			}
			
			.menu-column h3 {
			    font-size: 24px;
			    color: #12B8BA; /* 제목 색상 */
			    margin-bottom: 10px;
			    text-align: left;
			}
			
			.menu-column ul li {
			    margin-bottom: 8px; /* 목록 간격 */
			    font-size: 18px;
			    color: #333; /* 텍스트 색상 */
			    padding: 5px;
			    cursor: pointer;
			    text-align: left;
			}
			
			.menu-column ul li:hover{
				background-color: #12B8BA; /* 텍스트 색상 */
				color: white;
			}
		</style>
		
	</head>
	<body>
		<div>
			<p id="fast_menubar_title">빠른메뉴찾기</p>
			<hr>
			
			 <div class="menu-container">
		        <div class="menu-column">
		            <h3>진료안내</h3>
		            <ul>
		                <li onclick="location.href='reservation_info_page.do'">예약안내</li>
		                <li onclick="location.href='step1.do?pat_idx=${param.pat_idx}'">진료예약</li>
		                <li onclick="location.href='mypage_reservation_list.do?pat_idx=${sessionScope.patient.pat_idx}'">예약조회(마이페이지)</li>
		                <li onclick="location.href='mypage_certificates_print.do?pat_idx=${sessionScope.patient.pat_idx}'">증명서 발급</li>
		                <li onclick="location.href='mypage_reservation_list.do?pat_idx=${sessionScope.patient.pat_idx}'">온라인 진료비 결제</li>
		            </ul>
		        </div>
		        <div class="menu-column">
		            <h3>병원게시판</h3>
		            <ul>
		                <li onclick="location.href='info_notice_list.do'">공지사항 보기</li>
		                <li onclick="location.href='join_thanks_list.do?pat_idx=${sessionScope.patient.pat_idx}'">게시판 전체보기</li>
		                <li onclick="location.href='join_thanks_insert_form.do?pat_idx=${sessionScope.patient.pat_idx}'">감사합니다 글 쓰기</li>
		                <li onclick="location.href='join_compl_insert_form.do?pat_idx=${sessionScope.patient.pat_idx}'">건의합니다 글 쓰기</li>
		                <li onclick="location.href='join_volunteer_list.do?pat_idx=${sessionScope.patient.pat_idx}'">자원봉사 모집 공지</li>
		            </ul>
		        </div>
		        <div class="menu-column">
		            <h3>건강정보</h3>
		            <ul>
		                <li onclick="location.href='diagnosis_list.do'">자가진단 서비스</li>
		            </ul>
		        </div>
		        <div class="menu-column">
		            <h3>병원안내</h3>
		            <ul>
		                <li onclick="location.href='way_info.do'">오시는 길</li>
		                <li onclick="location.href='floor_info.do'">층별안내</li>
		                <li onclick="location.href='parking_info.do'">주차안내</li>
		                <li onclick="location.href='device_list.do'">의료기기 탐색</li>
		                <li onclick="location.href='searchMain.do'">진료과/의료진 보기</li>
		            </ul>
		        </div>
		    </div>
		    
		    
		</div>
	</body>
</html>