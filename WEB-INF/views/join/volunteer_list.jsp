<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

<link rel="stylesheet" href="/hos/resources/css/join/volunteer_list.css">

		<script>
			window.onload = function(){
				let search = document.getElementById("search");
				let search_text = document.getElementById("search_text");
				
				let search_arr = ['all', 'vol_title', 'vol_content', 'title_content'];
				
				for( let i = 0; i < search_arr.length; i++ ){
					if( '${param.search}' === search_arr[i] ){
						search[i].selected = true;
						search_text.value = '${param.search_text}';
						break;
					}
				}
			}
		</script>

<script src="/hos/resources/js/join/volunteer_list.js"></script>
</head>


<body>
	<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp" />

	<div id="container">

		<p>자원봉사</p>

		<div id="search_div">
			<select id="search" onchange="clearText()">
				<option value="all">전체보기</option>
				<option value="vol_title">제목</option>
				<option value="vol_content">내용</option>
				<option value="title_content">제목+내용</option>
			</select> <input id="search_text"> <input id="search_btn"
				type="button" value="검색" onclick="search(${param.pat_idx});">
		</div>

		<div id="volunteer_div">
			<table>

				<colgroup>
					<col width="80px" />
					<col width="460px" />
					<col width="220px" />
					<col width="140px" />
					<col width="100px" />
				</colgroup>

				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>등록일</th>
					<th>조회수</th>
					<th>파일</th>
				</tr>

				<c:forEach var="vo" items="${list}" varStatus="count">
					<tr>
						<td>${startIndex - count.index}</td>
						<td class="title_td"><a
							href="join_volunteer_view.do?pat_idx=${param.pat_idx}&vol_idx=${vo.vol_idx}&page=${param.page}">${vo.vol_title}</a>
						</td>
						<td class="date_td">${fn:split(vo.vol_date, ' ')[0]}</td>
						<td class="hit_td">${vo.vol_hits}</td>
						<td><c:if test="${ vo.vol_file ne 'no_file' }">
								<img src="/hos/resources/images/file.png">
							</c:if> <c:if test="${ vo.vol_file eq 'no_file' }">
								<a>X</a>
							</c:if></td>
					</tr>
				</c:forEach>
			</table>
		</div>

		<div id="page">${pageVol}</div>
	</div>
	<div style="margin-top: 150px;">
		<jsp:include page="/WEB-INF/views/main/Footer.jsp" />
	</div>
</body>
</html>