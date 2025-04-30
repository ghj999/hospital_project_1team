window.onload = function(){
	let search = document.getElementById("search");
	let search_text = document.getElementById("search_text");
	
	let search_arr = ['all', 'not_title', 'not_content','title_content'];
	
	for( let i = 0; i < search_arr.length; i++){
		if( '${param.search}' === search_arr[i] ){
			search[i].selected = true;
			search_text.value = '${param.search_text}';
			break;
		}
	}
} 

//검색
function search(){
	let search = document.getElementById("search").value;
	
	let search_text = document.getElementById("search_text").value;
	
	if( search != 'all' && search_text === '' ){
		alert("검색할 내용을 입력하세요.");
		return;
	}
	
	location.href="info_notice_list.do?search="+search+
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