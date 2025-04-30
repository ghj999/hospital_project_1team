<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>교수 선택</title>
<link rel="stylesheet" href="resources/css/reservation/common.css">
<link rel="stylesheet" href="resources/css/reservation/step2.css">
</head>
<body>
	<h1 style="text-align: center;">교수 선택</h1>
	<hr>
	<div id="professorContainer" class="professor-container">
		<!-- 교수 버튼 -->
		<c:forEach var="vo" items="${list}">
			<button data-prof-id="${vo.pro_idx}"
				onclick="selectProfessor('${vo.pro_idx}');">
				<!-- 첨부된 이미지가 있는 경우에만 img태그를 사용 -->
				<c:if test="${ vo.pro_file ne 'no_file' }">
					<img
						src="${pageContext.request.contextPath}/resources/upload/${vo.pro_file}"
						alt="교수 이미지">
				</c:if>
				<c:if test="${ vo.pro_file eq 'no_file' }">
					<img src="/hos/resources/images/MEDICOMPILE LOGO_sample.png"
						alt="교수 이미지">
				</c:if>
				<p class="pro_name">${ vo.pro_name }</p>
				<hr id="pro">
				<p style="" class="pro_field">${vo.pro_field}</p>
			</button>
		</c:forEach>
	</div>
	<hr>
	<div class="back">
		<input type="button" value="이전" onclick="history.back();">
	</div>

	<script>
	    function selectProfessor(pro_idx) {
	    	 let contact = "${contact}";
	         location.href = "step3.do?pro_idx=" + pro_idx + "&contact=" + encodeURIComponent(contact);
		}
    </script>

</body>
</html>
