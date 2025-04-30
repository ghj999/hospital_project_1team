<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>층별안내</title>
		
		<link rel="stylesheet" href="resources/css/info/floor_info.css">
		
		<script src="/hos/resources/js/info/floor_info.js"></script>
		
	</head>
	
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="container">
			<p>층별안내</p>
		
			<div id="content_wrap">
				<div id="floor_div">
					
					<!------------------------- 검색 ------------------------------------------------------------>
					<table id="search">
						<tr>
							<td><input id="search_text" name="search_text" placeholder="찾는 곳을 입력하세요."></td>
							<td><img onclick="search();" src="/hos/resources/images/search.png"
								style="cursor: pointer;"></td>
						</tr>
					</table>
					
					<!----------------- 검색 시 검색창 밑 결과 테이블 --------------------------------------------------->
					<div id="search_result_div">
						<table id="search_result" border="1">
							<c:forEach var="searchFloor" items="${search_floor}">
								<tr>
									<td>${searchFloor.floor_name}</td>
									<td>${searchFloor.floor_info}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					
					<div id="floor_table_div">
						<!--------------------------- 층별 목록 테이블 ( 1F ~ 9F ) ----------------------------------------------->
			            <table id="floor_table">
			                <c:forEach var="floorEntry" items="${groupedFloors}" varStatus="status">
			                    <c:if test="${floorEntry.key <= 9 && floorEntry.key >= 1}">
			                        <tr data-floor="${floorEntry.key}">
			                            <th onclick="showFloor(${floorEntry.key});">
			                                ${floorEntry.key}F
			                            </th>
			                        </tr>
			                    </c:if>
			                </c:forEach>
			            </table>
			       
		        
		        
				        <!--------------------- 층수( 1F ~ 9F ) 클릭 시 층 정보(floor_name) ----------------------------------------->
				        <div id="floor_names_div">
				            <c:forEach var="floorEntry" items="${groupedFloors}">
				                <c:if test="${floorEntry.key <= 9 && floorEntry.key >= 1}">
				                    <div id="floor_${floorEntry.key}" class="floor_name">
				                        <ul>
				                            <c:forEach var="floor" items="${floorEntry.value}">
				                                <li>${floor.floor_name}</li>
				                            </c:forEach>
				                        </ul>
				                    </div>
				                </c:if>
				            </c:forEach>
				        </div>
			        </div>
	        
	        	</div>
				
				<div id="line"></div>
				
				
				<!-- ------------------------------ 층별 사진 --------------------------  -->
				<div id="map_img_div">
					<c:forEach var="floorEntry" items="${groupedFloors}">
						<img id="floor_img_${floorEntry.key}" src="/hos/resources/images/floor_map${floorEntry.key}.PNG">				
					</c:forEach>
					
				
				</div>
			</div>
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
		
		<!-- 층수( 1F ~ 9F ) 클릭 시 배경 효과 -->
		<script>
			document.addEventListener('DOMContentLoaded', function () {
			    const floorTableHeaders = document.querySelectorAll('#floor_table th');
	
			    floorTableHeaders.forEach(th => {
			        th.addEventListener('click', () => {
			            // 모든 th에서 selected 클래스 제거
			            floorTableHeaders.forEach(th => th.classList.remove('selected'));
			            // 클릭한 th에 selected 클래스 추가
			            th.classList.add('selected');
			        });
			    });
			});
		</script>
	</body>
</html>