<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료기기정보</title>

<link rel="stylesheet" href="/hos/resources/css/MedicalDevice/divice_list.css">

	<script>
		function showPopup(devIdx) {
		    // 팝업 창 URL에 의료기기 ID를 전달
		    const popupUrl = "deviceInfo.do?dev_idx=" + devIdx;
		
		 	// 팝업 창 크기
		    const width = 600;
		    const height = 400;
		
		    // 화면의 중앙 위치 계산
		    const left = (window.innerWidth / 2) - (width / 2);
		    const top = (window.innerHeight / 2) - (height / 2);
		
		    // 팝업 창 열기 (주소 표시줄, 도구 모음, 메뉴 바 제거)
		    window.open(popupUrl, 'divicePopup', 
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
<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>

	<div class="header">
        <p id="header_title">의료기기정보</p>
		<!-- 버튼 그룹 -->
	    <div class="button-group">
	        <button onclick="location.href='reservation_info_page.do'">예약안내</button>
	        <button onclick="location.href='searchMain.do'">의료진찾기</button>
	    </div>
    </div>

	<div class="top-bar">
		<div class="info">가용 의료기기: 19개</div>
		<!-- 좌측 상단 -->
		<div class="search">
			<!-- 우측 상단 -->
			<form action="${pageContext.request.contextPath}/search.do"
				method="get">
				<select name="searchType">
					<option value="name">이름</option>
					<option value="content">내용</option>
					<option value="all">이름+내용</option>
				</select> <input type="text" name="keyword" placeholder="의료기기 검색...">
				<button type="submit" id="search_btn">검색</button>
			</form>
		</div>
	</div>
	
<div class="gallery-container">
	<c:forEach var="vo" items="${list}">
		<div class="device_box" onclick="showPopup('${vo.dev_idx}');">
			<c:if test="${vo.dev_filename ne 'no_file'}">
				<img src="${pageContext.request.contextPath}/resources/upload/${vo.dev_filename}">
				
				<!-- 확장자 제거 -->
				<c:set var="fileNameNoExtension" value="${fn:substringBefore(vo.dev_filename, '.png')}" />
				
				<!-- 숫자와 언더바 제거 -->
				<c:set var="formattedFileName" value="${fn:replace(fileNameNoExtension, '_', ' ')}" />
				<c:set var="cleanFileName" value="${fn:replace(formattedFileName, '^[0-9]+ ', '')}" />

				<!-- 출력 -->
				<a style="margin: 30px;">${cleanFileName}</a>
			</c:if>
		</div>
	</c:forEach>
</div>

	<div align="center" style="margin-top: 20px; margin-bottom: 50px;">
		<p>${pageMenu}</p>
	</div>

</body>
</html>