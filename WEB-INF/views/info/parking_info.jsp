<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>주차안내</title>
		
		<link rel="stylesheet" href="resources/css/info/parking_info.css">
	</head>
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="container">
			<p>주차안내</p>
				
			<img id="map1" src="/hos/resources/images/park_map1.PNG">
			<img id="map2" src="/hos/resources/images/park_map2.PNG">
			
			<div id="parking_scale">
				<p>주차장 규모</p>
				<table>
					<tr>
						<th>P1 정문 주차장</th>
						<td>509대</td>
					</tr>
					
					<tr>
						<th>P2 본관 주차장</th>
						<td>507대</td>
					</tr>
					
					<tr>
						<th>P3 본관 지하 주차장</th>
						<td>935대</td>
					</tr>
					
					<tr>
						<th>P4 암병원 지하 주차장</th>
						<td>405대</td>
					</tr>
					
					<tr>
						<th>P5 장례식장 주차장</th>
						<td>425대</td>
					</tr>
					
				</table>
				<h5>※총 2,841대의 주차공간이 확보되어 있습니다</h5>
			</div>
			
			<div id="parking_pay">
				<p>주차요금</p>
				<table>
					<tr>
						<th>구분</th>
						<th>무료주차시간</th>
						<th>요금내역</th>
					</tr>
					
					<tr>
						<td>주간<br>(08:00~22:00)</td>
						<td rowspan="2">입차 후 30분 무료</td>
						<td>초과 시 10분당 &#8361;500</td>
					</tr>
					
					<tr>
						<td>야간<br>(22:00~08:00)</td>
						<td>일괄 &#8361;1,000</td>
					</tr>
					
					<tr>
						<td colspan="3">
							주차 요금은 평일/주말/휴일 동일하게 적용합니다.
						</td>
					</tr>
				</table>
			</div>
			
			<div id="free_parking">
				<p>무료주차</p>
				<table>
					<tr>
						<th>구분</th>
						<th>무료주차</th>
						<th>출차방법</th>
					</tr>
					
					<tr>
						<td>예약환자, 입원환자 중간진료비 수납</td>
						<td>2시간 1대 1회	</td>
						<td rowspan="4">진료환자는 요금계산소에 진료카드 또는 영수증을 제시하여 주시기 바랍니다.</td>
					</tr>
					
					<tr>
						<td>외래(진료,검사,채혈)환자, 건강검진, 통원수술</td>
						<td>당일 수진 진료과별 무료</td>
					</tr>
					
					<tr>
						<td>입원, 퇴원, 수술환자</td>
						<td>당일 1대 1회</td>
					</tr>
					
					<tr>
						<td>응급실 환자(입실시간기준)</td>
						<td>당일 24시간/1회</td>
					</tr>
					
					<tr>
						<td>장애인(동승/운전할경우)</td>
						<td colspan="2">복지카드를 제시하면 일반요금의 50%할인<br>(할인주차권은 장애인 50% 할인이 없습니다.)</td>
					</tr>
					
					<tr>
						<td>할인주차권</td>
						<td colspan="2">
							<ul>
								<li>할인권: 10,000원/1일(24시간 자유로이 입/출차가능)</li>
								<li>입원기간 중 차량 1대에 한하여 1회 구입 가능합니다.</li>
								<li>할인권 사용 후에는 일반요금이 적용됩니다.</li>
							</ul>
						</td>
					</tr>					
				</table>
				<h5>※ P4 암 병원 주차장은 매우 혼잡하여 할인권 구입 및 사용이 불가하여 일과중 암병원을 이용하시는 고객님들께서는 P5 후문 주차장을 이용하시면 보다 빠른 주차가 가능합니다</h5>
			</div>
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
		
	</body>
</html>