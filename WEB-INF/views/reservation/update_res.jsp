<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 수정</title>
<!-- Custom CSS -->
    <link rel="stylesheet" href="resources/css/reservation/common.css">
    <link rel="stylesheet" href="resources/css/reservation/step3.css">
    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
    
    <script>
       window.availableDays = ${availableDays};
       window.professor = ${professor};
       window.holidays = ${holidays};
       window.pat_idx = "${sessionScope.patient.pat_idx}";
       window.res_idx = ${res_idx};
    </script>
	<script src="/hos/resources/js/reservation/update_res.js"></script>
   	
</head>
<body>
         <div style="display: flex;">
          <!-- 교수 정보 영역 -->
          <div id="professorInfo">
             <p>교수 정보</p>
             <hr class="pro">
              <table>
                 <tr>
                    <td colspan="2" align="center"><img src="resources/images/${vo.pro_file}"></td>
                 </tr>
		        	<tr>
		        		<td class="info" id="info_name" align="center">${vo.pro_name}</td>
		        	</tr>
		        	<tr>
		        		<td class="info" id="info_field" align="left">${vo.pro_field}</td>
		        	</tr>
              </table>
		      <input id="back" type="button" value="이전" onclick="history.back();">
          </div>
      
          <!-- 캘린더 영역 -->
          <div id="calendar"></div>
      
          <!-- 예약 가능한 시간 표시 영역 -->
      <div id="timePage">
         <p>예약 가능한 시간</p>
          <hr class="pro">
           <div id="timeSlots">
             <div class="time-buttons">
                 <c:forEach var="button" items="${buttons}">
                     <button 
                         class="time-slot" 
                         data-time="${button.time}" 
                         data-pro-idx="${pro_idx}" 
                         ${button.disabled == 'true' ? 'disabled' : ''}>
                         ${button.time}
                     </button>
                 </c:forEach>
             </div>
         </div>
      </div>
      </div>  
</body>
</html>