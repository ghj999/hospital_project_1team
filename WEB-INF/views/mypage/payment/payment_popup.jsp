<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>진료비 결제</title>

    <!-- TossPayments SDK -->
    <script src="https://js.tosspayments.com/v2/standard"></script>
    
	<link rel="stylesheet" href="/hos/resources/css/mypage/payment_popup.css?version=1.0">
	
    <script>
        let total = 0;
	 	let pat_idx = "";
        let pat_email = "";
        let pat_name = "";
        let pat_phone = "";
        let paymentDetails = [];

        // Listen for message from the parent window
        window.addEventListener('message', function(event) {
            if (event.origin !== "http://localhost:9090") {
                return;
            }

            const data = event.data;
            total = data.total || 0;
            pat_idx = data.pat_idx || "";
            pat_email = data.pat_email || "";
            pat_name = data.pat_name || "";
            pat_phone = data.pat_phone.replace(/-/g, '') || "";
            paymentDetails = data.paymentDetails || [];
			
            console.log("환자번호 : " + pat_idx);
            console.log("이름 : " + pat_name);
            console.log("이메일 : " + pat_email);
            console.log("전화번호 : " + pat_phone);
            console.log("결제금액 : " + total);

            // 결제 금액 표시
            document.getElementById("payment-price-a").innerText = total;

            main();
        });

    	// 결제 완료 후 팝업 창 닫기 및 부모 페이지 갱신
        async function main() {
            if (total === 0) {
                console.error("결제 금액이 설정되지 않았습니다.");
                return;
            }

            //localhost:9090/hos/mypage_payment_fail.do?
            //code=2003&message=LGD_FIXED_BUYERPHONE%20%EA%B0%92%EC%9D%B4%20%EC%9C%A0%ED%9A%A8%ED%95%98%EC%A7%80%20%EC%95%8A%EC%8A%B5%EB%8B%88%EB%8B%A4.%20(10~11%EC%9E%90%EB%A6%AC)
            //&orderId=sw5Z0rpqsOBfs1tN74ZjG
            
            const button = document.getElementById("payment-button");

            // TossPayments 클라이언트 키 설정
            const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm"; // 관리자 콘솔에서 확인
            const tossPayments = TossPayments(clientKey);

            const customerKey = "pat_idx_" + pat_idx; // 실제 환경에 맞게 설정
            const widgets = tossPayments.widgets({ customerKey });

            // 결제 금액 설정
            console.log("총 결제금액 :" + total);
            await widgets.setAmount({
                currency: "KRW",
                value: total,
            });

            // 결제 UI와 이용약관 렌더링
            await Promise.all([
                widgets.renderPaymentMethods({
                    selector: "#payment-method",
                    variantKey: "DEFAULT",
                }),
                widgets.renderAgreement({
                    selector: "#agreement",
                    variantKey: "AGREEMENT",
                }),
            ]);

            // 결제하기 버튼 이벤트 설정
            button.addEventListener("click", async function () {
                const encodedDetails = encodeURIComponent(JSON.stringify(paymentDetails));

                try {
                    await widgets.requestPayment({
                        orderId: "sw5Z0rpqsOBfs1tN74ZjG", // 실제 환경에 맞게 고유한 주문 ID 설정
                        orderName: "진료비 결제",
                        successUrl: "http://localhost:9090/hos/mypage_payment_success.do?paymentDetails=" + encodedDetails,
                        failUrl: "http://localhost:9090/hos/mypage_payment_fail.do",
                        customerEmail: pat_email,
                        customerName: pat_name,
                        customerMobilePhone: pat_phone,
                    });
                } 
                catch (error) {
                    console.error("결제 요청 중 오류:", error);
                    alert("결제가 취소되었습니다.");
                    window.opener.postMessage('paymentFail', '*');  // 부모 페이지에 메시지 전달
                    window.close();  // 팝업 닫기
                }
            });
        }
    </script>
</head>
<body>
	<div id="main-div">
		<img id="logo" src="/hos/resources/images/MEDICOMPILE LOGO.png">
		
	    <!-- 결제 내역 표시 -->
	    <ul id="payment-details-list"></ul>

		<!-- 결제 금액 -->	
	    <div id="payment-price">
	    	총 <a id="payment-price-a"></a>원
    	</div>
	
	    <!-- 결제 UI -->
	    <div id="payment-method"></div>
	    
	    <!-- 이용약관 UI -->
	    <div id="agreement"></div>
	    
	    <!-- 결제하기 버튼 -->
	    <button class="button" id="payment-button" style="margin-top: 30px">결제하기</button>
	</div>

    <script>
        // 메인 함수 호출
        main();
    </script>
</body>
</html>
