<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>Insert title here</title> -->
<title>질병 목록</title>

<link rel="stylesheet" href="/hos/resources/css/SelfDiagnosis/diagnosis_list.css">

	<script>
		function showPopup(illIdx) {
		    // 팝업 창 URL에 질병 ID를 전달
		    const popupUrl = "diseaseInfo.do?ill_idx=" + illIdx;
		    
		    // 팝업 창 크기
		    const width = 600;
		    const height = 400;
	
		    // 화면의 중앙 위치 계산
		    const left = (window.innerWidth / 2) - (width / 2);
		    const top = (window.innerHeight / 2) - (height / 2);
	
		    // 팝업 창 열기 (주소 표시줄, 도구 모음, 메뉴 바 제거)
		    window.open(popupUrl, 'diseasePopup', 
		        'width=' + width + 
		        ',height=' + height + 
		        ',left=' + left + 
		        ',top=' + top + 
		        ',scrollbars=yes' + 
		        ',toolbar=no' + 
		        ',location=no' + 
		        ',menubar=no' + 
		        ',resizable=no');
		}
	</script>
</head>
<body>
<!-- 메뉴바 -->
<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>

	<div class="title">
		<p style="font-size: 40px; color: black; margin-left: -5px;">자가진단 서비스</p>
	     <!-- 버튼들을 감싸는 div 추가 -->
	    <div class="button-group">
	        <button onclick="location.href='reservation_info_page.do'">예약안내</button>
	        <button onclick="location.href='searchMain.do'">의료진찾기</button>
	    </div>
	</div>
	
	<div class="subject"> 
		<h2 style="font-weight: bold; color: #3086C9; margin-bottom: 3px;">일반적인 증상</h2>
		<p>자가진단은 사용자 스스로 건강진단을 할 수 있는 항목들과 결과에 대한 건강 콘텐츠를 통해 건강실천사항을 제공하고 있습니다.</p>
		<hr style="margin: 10px 0; margin-right: 10px;">
	</div>
	
	<div class="diagnosis-box">
		<div class="diagnosis-box_inner">
			<table>
				<tbody>
					<c:forEach var="vo" items="${list}" varStatus="status">
						<c:if test="${status.index % 4 == 0}">
							<tr>
						</c:if>
						<td>
							<!-- 질병 이름을 클릭하면 팝업을 띄움 --> 
							<a onclick="showPopup('${vo.ill_idx}');">${vo.ill_name}</a>
						</td>
						<c:if test="${status.index % 4 == 3}">
							</tr>
						</c:if>
						<c:if test="${status.index >= 52}">
							<!-- 여기서 반복 종료 -->
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	
	<!-- 풋터 -->
	<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	
	
</body>
</html>