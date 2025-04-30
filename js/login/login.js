function login() {
	let pat_id = document.getElementsByName("pat_id")[0].value;
	let pat_pwd = document.getElementsByName("pat_pwd")[0].value;
	
	//유효성검사
	if(pat_id == ''){
		alert("아이디를 입력하세요.");
		return;
	}
	if(pat_pwd == ''){
		alert("비밀번호를 입력하세요.");
		return;
	}
	
	let url = "login_chk_correct.do";
	let param = "pat_id=" + pat_id + "&pat_pwd=" + pat_pwd;
	sendRequest(url, param, login_result_fn, "post");
}
function login_result_fn() {
	if(xhr.readyState == 4 && xhr.status == 200){
		let data = xhr.responseText;
		let json = ( new Function('return '+data) )();
		
		if(json[0].result == "id_not_exist"){
			alert("존재하지 않는 아이디 입니다.");
			return;
		}
		else if(json[0].result == "id_exist"){
			alert("비밀번호가 일치하지 않습니다.");
			return;
		} else {
			alert("로그인 성공");
			let pat_idx = json[1].pat_idx;
			location.href="main.do?pat_idx=" + pat_idx;
		}
	}
}