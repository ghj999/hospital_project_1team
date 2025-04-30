function check() {
    // 1. 연락처 입력란 값 가져오기
    const front = document.getElementById('front').value.trim();
    const middle = document.getElementById('middle').value.trim();
    const back = document.getElementById('back').value.trim();

    // 전화번호 앞자리 유효성 검사 (한국 전화번호 체계)
    const frontRegex = /^(010|011|016|017|018|019|070|02|031|032|033|041|042|043|051|052|053|054|055|061|062|063|064)$/;
    const phoneRegex = /^[0-9]{3,4}$/; // 중간 및 뒷자리 유효성 검사

    // 연락처 입력란 중 하나라도 값이 있는지 확인
    if (front || middle || back) {
        // 값이 하나라도 있을 경우, 유효성 검사 진행
        if (!frontRegex.test(front)) {
            alert("전화번호 앞자리는 올바른 형식이 아닙니다. (예: 010, 031 등)");
            return;
        }
        if (!phoneRegex.test(middle)) {
            alert("전화번호 중간 번호는 3~4자리 숫자만 입력 가능합니다.");
            return;
        }
        if (!phoneRegex.test(back)) {
            alert("전화번호 뒷 번호는 4자리 숫자만 입력 가능합니다.");
            return;
        }
    }

    // 2. 라디오 버튼 확인 (연락처 입력 여부와 무관하게 진행)
    const agreeValue = document.querySelector('input[name="check_agree"]:checked');
    if (!agreeValue) { // 라디오 버튼이 선택되지 않았을 때
        alert("개인정보 수집 및 이용에 대한 동의 여부를 선택해주세요.");
        return;
    }
    if (agreeValue.value === 'no') { // 동의하지 않았을 때
        alert("온라인 예약은 동의가 필요합니다.");
        return;
    }

    // 3. 유효성 검사가 모두 통과되었을 때
    document.getElementById('right').style.display = 'block'; // 3번 페이지 표시
    alert("진료과를 선택해주세요.");
}
//=========================================================================================
//로그아웃
		function logout(idx) {
			if(!confirm("로그아웃 하시겠습니까?")){
				return;
			}else{
				idx = "";
				location.href="main.do";
			}
		}//logout