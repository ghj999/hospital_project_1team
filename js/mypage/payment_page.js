// 조회버튼 클릭
function set_period() {
    let start_day = document.getElementById("start_day").value;
    let end_day = document.getElementById("end_day").value;

    if (!start_day || !end_day) {
        alert("시작일과 종료일을 모두 입력해주세요.");
        return;
    }

    if (start_day > end_day) {
        alert("종료일은 시작일 이후여야 합니다.");
        return;
    }

    let rows = document.querySelectorAll("#payment_list tr");
    rows.forEach(row => {
        let res_time = row.querySelector("td:nth-child(2)")?.innerText.trim() || "";
        let res_date = res_time.split(" ")[0];

        if (res_date >= start_day && res_date <= end_day) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}

// 전체조회버튼 클릭
function all_period() {
    document.getElementById("start_day").value = "";
    document.getElementById("end_day").value = "";

    let rows = document.querySelectorAll("#payment_list tr");
    rows.forEach(row => {
        row.style.display = ""; // 모든 행을 보이도록 설정
    });
}
			
let total = 0;
function calc_total(checkbox) {
    let value = parseInt(checkbox.value, 10);

    if (checkbox.checked) {
        total += value;
    } else {
        total -= value;
    }

    let paymentBtn = document.getElementById("payment_btn");
    paymentBtn.value = total + "원 결제진행";
}

// 결제버튼 클릭
function payment_btn() {
    if (isNaN(total) || total <= 0) {
        alert("결제할 항목을 선택해주세요.");
        return;
    }

    let openUrl = "mypage_payment_popup.do";
    let popupName = 'paymentPopup';
    let popupOption = "width=650px, height=900px, top=40px, left=200px, scrollbars=yes";

    // 팝업 창 열기
    let paymentWindow = window.open(openUrl, popupName, popupOption);

    // 결제에 필요한 데이터
    let paymentDetails = [];
    let rows = document.querySelectorAll("#payment_list tr");
    rows.forEach(row => {
        let checkbox = row.querySelector("input[type='checkbox']");
        
        if (checkbox && checkbox.checked) {
            // 각 항목의 res_idx를 가져옵니다. (숨겨진 첫 번째 td)
            let res_idx = row.querySelector("td:nth-of-type(1)").innerText.trim(); // 숨겨진 예약번호
            let res_time = row.querySelector("td:nth-of-type(2)").innerText.trim(); // 진료일
            let dept_name = row.querySelector("td:nth-of-type(3)").innerText.trim(); // 진료과(담당교수)
            let dept_payment = parseInt(row.querySelector("td:nth-of-type(4) span").innerText.trim().replace("원", "")); // 진료비
            
            // 결제 상세 정보에 예약번호(res_idx) 추가
            paymentDetails.push({
            	res_idx: res_idx,
            	res_time: res_time,
            	dept_name: dept_name,
            	dept_payment: dept_payment
            });
        }
    });

    // 팝업 창이 로드된 후에 데이터를 postMessage로 전달
    paymentWindow.onload = function() {
        paymentWindow.postMessage({
            total: total,
            paymentDetails: paymentDetails,
            pat_idx: document.getElementById("pat_idx").value,
            pat_email: document.getElementById("pat_email").value,
            pat_name: document.getElementById("pat_name").value,
            pat_phone: document.getElementById("pat_phone").value
        }, "*");
    }
}