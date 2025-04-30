function insert(f){
				      
	let pat_idx = f.pat_idx.value;
	let board_name = f.board_name.value;
	let board_title = f.board_title.value;
	let board_content = f.board_content.value;
	
	let board_phone_1 = f.board_phone_1.value;
    let board_phone_2 = f.board_phone_2.value;
    
   
    //유효성체크
	if( board_name === '' ){
		alert("이름을 입력하세요.");
		return;
	}
	
	if( board_phone_1 === '' || board_phone_2 === '' ){
		alert("번호을 입력하세요.");
		return;
	}
	
	//전화번호 숫자인지 체크
	let pat_num = /^[0-9]*$/; 
	if(!pat_num.test(board_phone_1) || !pat_num.test(board_phone_2)) {
		alert("숫자만 입력하세요.");
		document.getElementsByName("board_phone_1")[0].focus();
		return;
	}
	
	if( board_title === '' ){
		alert("제목을 입력하세요.");
		return;
	}
	
	if( board_content === '' ){
		alert("내용을 입력하세요.");
		return;
	}
	
	f.action = "join_board_insert.do?pat_idx="+pat_idx;
	f.submit();
}

//이메일 select -> text로 옮기기
function chk_email(email_addr){
	document.forms[0].board_email2.value = email_addr;
}

// 파일 이름 표시 함수
function showFileName(input) {
    const fileName = input.files[0] ? input.files[0].name : "선택된 파일 없음";
    document.getElementById("file-name").textContent = fileName;
}