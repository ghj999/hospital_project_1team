//검색
function search( pat_idx ){
	let search = document.getElementById("search").value;
	
	let search_text = document.getElementById("search_text").value;
	
	if( search != 'all' && search_text === '' ){
		alert("검색할 내용을 입력하세요.");
		return;
	}
	
	
	location.href="join_volunteer_list.do?pat_idx="+pat_idx+
			  "&search="+search+
			  "&search_text="+encodeURIComponent(search_text)+
			  "&page=1";
}

//전체보기 선택 시 텍스트 비우기
function clearText(){
	let search = document.getElementById("search").value;
	let search_text = document.getElementById("search_text");
	
	if( search === 'all' ){
		search_text.value = '';
	}
}