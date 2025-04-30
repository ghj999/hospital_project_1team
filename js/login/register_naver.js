//비밀번호가 일치한지 확인하는 변수
let chk_pwd_value = 'n';
//아이디가 중복체크가 되었는지 확인하는 변수
let chk_id_value = 'n';

//두개의 비밀번호가 일치하는지 체크하는 함수
function chk_pwd() {
	chk_pwd_value = 'n';
	
	let pwd = document.getElementsByName("pat_pwd")[0];
    let pwd2 = document.getElementsByName("pat_pwd2")[0];
    let pwd_text = document.getElementById("pwd_text"); 
	
	if(pwd.value == pwd2.value){
		chk_pwd_value = 'y';
		pwd_text.innerHTML = "";
	}
	else{
		chk_pwd_value = 'n';
		pwd_text.innerHTML = "비밀번호가 일치하지 않습니다.";
	}
}

//이메일 주소에 따라 input text 값 변경하는 함수
function chk_email(email_addr) {
    let pat_email_addr = document.getElementsByName("pat_email_addr")[0];
    pat_email_addr.value = email_addr;
}

function chk_id_change() {
	chk_id_value = 'n';
}
//아이디 중복체크 버튼 클릭
function chk_id() {
	let id = document.getElementsByName("pat_id")[0].value;
	
	if(id == ''){
		alert("아이디를 입력하세요.");
		return;
	}
	
	let url = "register_check_id.do";
	let param = "pat_id="+encodeURIComponent(id);
	sendRequest(url, param, chk_id_result, "post");
}
//chk_id() => 콜백함수
function chk_id_result() {
	if(xhr.readyState == 4 && xhr.status == 200){
		let pat_id = document.getElementsByName("pat_id")[0];
		let data = xhr.responseText;
		let json = ( new Function('return '+data) )();
		
		if(json[0].result == "yes"){
			alert("이미 존재하는 아이디 입니다.");
			pat_id.focus();
		}
		else {
			chk_id_value = 'y';
			alert("사용가능한 아이디 입니다.");
			
			//아이디 입력칸 비활성화
			//pat_id.disabled = "disabled";
			return;
		}
	}
}

//회원가입 버튼 클릭
function register( f ) {
	//아이디 중복검사 했는지 체크
	if(chk_id_value == 'n'){
		alert("아이디 중복확인을 진행해주세요.");
		return;
	}
	//비밀번호 일치 체크
	if(chk_pwd_value == 'n'){
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}
	
	//유효성체크
	let pat_id = document.getElementsByName("pat_id")[0].value;
	let pat_name = document.getElementsByName("pat_name")[0].value;
	let pat_pwd = document.getElementsByName("pat_pwd")[0].value;
	let pat_email = document.getElementsByName("pat_email")[0].value;
	let pat_email_addr = document.getElementsByName("pat_email_addr")[0].value;
	let pat_address_post = document.getElementsByName("pat_address_post")[0].value;
	let pat_address_road = document.getElementsByName("pat_address_road")[0].value;
	let pat_address_detail = document.getElementsByName("pat_address_detail")[0].value;
	
	let pat_phone = document.getElementsByName("pat_phone")[0].value;
	let pat_phone1_1 = document.getElementsByName("pat_phone1_1")[0].value;
	let pat_phone1_2 = document.getElementsByName("pat_phone1_2")[0].value;
	
	let pat_phone2 = document.getElementsByName("pat_phone2")[0].value;
	let pat_phone2_1 = document.getElementById("pat_phone2_1")?.value || "";
    let pat_phone2_2 = document.getElementById("pat_phone2_2")?.value || "";
    let pat_birthday = document.getElementsByName("pat_birthday")[0].value;
    let pat_gender = document.querySelector('input[name="pat_gender"]:checked').value;
    
	if(pat_id == '' || pat_name == '' || pat_email == '' || pat_email_addr == '' ||
	   pat_address_post == '' || pat_address_road == '' || pat_address_detail == '' ||
	   pat_phone == '' || pat_phone1_1 == '' || pat_phone1_2 == '' || pat_birthday == '') {
		alert("빈칸을 모두 입력해주세요.");
		return;
	}
	
	//전화번호 숫자인지 체크
	let pat_num = /^[0-9]*$/; 
	if(!pat_num.test(pat_phone1_1) || !pat_num.test(pat_phone1_2)) {
		alert("숫자만 입력하세요.");
		document.getElementsByName("pat_phone1_1")[0].focus();
		return;
	}
	
	let url = "register_patient_insert.do";
	let param = "pat_id=" + pat_id
			    + "&pat_name=" + pat_name
			    + "&pat_pwd=" + pat_pwd
			    + "&pat_email=" + pat_email
				+ "&pat_email_addr=" + pat_email_addr 
			    + "&pat_address_post=" + pat_address_post
			    + "&pat_address_road=" + pat_address_road
			    + "&pat_address_detail=" + pat_address_detail
			    + "&pat_phone=" + pat_phone
				+ "&pat_phone1_1=" + pat_phone1_1
				+ "&pat_phone1_2=" + pat_phone1_2
			    + "&pat_phone2=" + pat_phone2
				+ "&pat_phone2_1=" + pat_phone2_1
				+ "&pat_phone2_2=" + pat_phone2_2
				+ "&pat_gender=" + pat_gender
				+ "&pat_birthday=" + pat_birthday;
	sendRequest(url, param, register_result, "get");
}

function register_result() {
	if(xhr.readyState == 4 && xhr.status == 200){
		let data = xhr.responseText;
		let json = ( new Function('return '+data) )();
		
		//회원가입이 성공한 경우
		if (json[0].result === "success") {
			alert("회원가입에 성공하였습니다.");
         	//메인 페이지로 이동
            location.href = "register_fin.do?pat_name=" + document.getElementsByName("pat_name")[0].value; 
        } 
		//회원가입에 실패한 경우
		else if (json[0].result === 'fail') {
			alert("이미 존재하는 회원 정보 입니다. \n아이디 찾기를 진행해주세요");
            // 회원가입 페이지에 머무름
            return;
        } 
		else {
            alert("알 수 없는 오류가 발생했습니다.");
            return;
        }
	}
}