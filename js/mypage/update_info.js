function change_mode( id ) {
	let pwd_btn = document.getElementById("change_pwd_btn");
	let info_btn = document.getElementById("change_info_btn");
	
	let update_pwd = document.getElementById("update_pwd");
	let update_infomation = document.getElementById("update_infomation");
	
	if( id == "change_pwd_btn") {//비밀번호 변경 버튼을 누른 경우 
		pwd_btn.style.backgroundColor = "#12B8BA";
		pwd_btn.style.color = "white";
		info_btn.style.backgroundColor = "white";
		info_btn.style.color = "black";
		
		update_infomation.style.display = "none";
		update_pwd.style.display = "block";
	}
	else {//비밀번호 변경 버튼을 누른 경우 
		info_btn.style.backgroundColor = "#12B8BA";
		info_btn.style.color = "white";
		pwd_btn.style.backgroundColor = "white";
		pwd_btn.style.color = "black";
		
		update_pwd.style.display = "none";
		update_infomation.style.display = "block";
	}
}

//이메일 주소에 따라 input text 값 변경하는 함수
function chk_email() {
    let email_addr = document.getElementById("email_addr");
    let email_addr2 = document.getElementsByName("pat_email_addr")[0];
    
    if (email_addr.options[email_addr.selectedIndex].value != "") {
    	email_addr2.value = email_addr.options[email_addr.selectedIndex].value;
    }
}

function update_info( f ) {
	//유효성체크
	let pat_email = document.getElementsByName("pat_email")[0].value;
	let pat_email_addr = document.getElementsByName("pat_email_addr")[0].value;
	let pat_address_post = document.getElementsByName("pat_address_post")[0].value;
	let pat_address_road = document.getElementsByName("pat_address_road")[0].value;
	let pat_address_detail = document.getElementsByName("pat_address_detail")[0].value;
	let pat_phone = document.getElementsByName("pat_phone")[0].value;
	let pat_phone1_1 = document.getElementsByName("pat_phone1_1")[0].value;
	let pat_phone1_2 = document.getElementsByName("pat_phone1_2")[0].value;
	
	if(pat_email == '' || pat_email_addr == '' ||
	   pat_address_post == '' || pat_address_road == '' || pat_address_detail == '' ||
	   pat_phone == '' || pat_phone1_1 == '' || pat_phone1_2 == '') {
		alert("빈칸을 모두 입력해주세요.");
		return;
	}
	
	alert("정보수정이 완료되었습니다.");
	
	f.method = "post";
	f.action = "mypage_update_info.do";
	f.submit();
}
			