<%@page import="vo.MypagePayVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>결제 결과</title>
    
    <link rel="stylesheet" href="/hos/resources/css/mypage/payment_popup.css?version=1.0">
    
    <script>
        function closeAndUpdate() {
            // 부모 창에 결제 성공 메시지 전달
            window.opener.postMessage('paymentSuccess', '*');
            window.close();  // 팝업 창 닫기
        }
    </script>
</head>
<body>
    <div id="main-div">
        <!-- 로고 -->
        <img id="logo" src="/hos/resources/images/MEDICOMPILE LOGO.png" alt="Logo">

        <!-- 성공 메시지 -->
        <h2>결제가 완료되었습니다!</h2>

        <!-- 결제 완료된 예약 내역 -->
        <ul id="payment-details-list">
            <%
                List<MypagePayVO> details = (List<MypagePayVO>) request.getAttribute("details");
                if (details != null && !details.isEmpty()) {
                    for (MypagePayVO detail : details) {
            %>
                <li>
                    예약 번호: <strong><%= detail.getRes_idx() %></strong><br>
                    예약 시간: <strong><%= detail.getRes_time() %></strong><br>
                    진료 과목: <strong><%= detail.getDept_name() %></strong><br>
                    금액: <strong><%= detail.getDept_payment() %></strong>원
                </li>
            <%
                    }
                } else {
            %>
                <li>결제 내역이 없습니다.</li>
            <%
                }
            %>
        </ul>

        <!-- 닫기 버튼 -->
        <button class="button" onclick="closeAndUpdate()">닫기</button>
    </div>
</body>
</html>