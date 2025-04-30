//페이지 시작 시 1층이 기본값
window.onload = function() {
	showFloor(1);
};

// 층별 floor_name 표시 함수
function showFloor(floorNumber) {
	
	// 층 클릭 시 검색 테이블 지우기
	let table = document.getElementById("search_result");
	if( table ){
		table.style.display = 'none';
	}
	
	// 검색창 내용 비우기
    document.getElementById("search_text").value = '';
	
    // 모든 층의 floor_name 숨기기
    let allFloors = document.querySelectorAll(".floor_name");
    for (let i = 0; i < allFloors.length; i++) {
        allFloors[i].classList.remove("active");
    }

    // 선택한 층의 floor_name만 보이기
    document.getElementById("floor_" + floorNumber).classList.add("active");

	//이미지 숨기기        
    let imgFloors = document.querySelectorAll("#map_img_div img");
	for (let i = 0; i < imgFloors.length; i++){
		imgFloors[i].style.display = "none";
	}
	
	// 선택한 층의 이미지 표시
	let selectedImg = document.getElementById("floor_img_" + floorNumber);
	if( selectedImg ){
		selectedImg.style.display = "block";
	}

}


//검색
function search(){
	let search_text = document.getElementById("search_text").value;
	
	if( search_text === '' ){
		alert("검색할 내용을 입력하세요.");
		return;
	}

	let url = "search_floor.do";
	let param = "search_text="+search_text;
	
	sendRequest(url, param, searchFn, "get");
}

function searchFn(){
	if (xhr.readyState === 4 && xhr.status === 200) {
		
		let result = JSON.parse(xhr.responseText);
        
		let table = document.getElementById("search_result");
        table.innerHTML = ''; // 기존 테이블 내용 지우기

    	// 테이블 헤더 생성
        let headerRow = document.createElement('tr');
        headerRow.innerHTML = '<th class="search_loc">위치명</th><th class="search_floor">층</th>';
        table.appendChild(headerRow);

        // 결과가 없는 경우
        if (result.length === 0) {
            let noDataRow = document.createElement('tr');
            noDataRow.innerHTML = '<td colspan="2">검색 결과가 없습니다.</td>';
            table.appendChild(noDataRow);
        } else {
            // 결과 데이터 추가
        	result.forEach(function (item) {
        	    let row = document.createElement('tr');
        	    let cell1 = document.createElement('td');
        	    cell1.textContent = item.floor_name; 
        	    row.appendChild(cell1);

        	    let cell2 = document.createElement('td');
        	    cell2.textContent = item.floor_info; 
        	    row.appendChild(cell2);

        	    table.appendChild(row);
        	});

        }

        // 테이블 표시
        table.style.display = 'table';
    }
}