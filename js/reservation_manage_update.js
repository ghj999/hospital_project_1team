//교수 목록 버튼
			function professor_list() {
				let url = "professor_list.do";
				sendRequest(url, null, professor_listFn, "get");
			}
			
			function professor_listFn() {
			    if (xhr.readyState == 4 && xhr.status == 200) {
			    	let data = JSON.parse(xhr.responseText); // JSON 파싱
			    	displayProfessorList(data); 
					
			    	console.log(data);
			    }
			}
			//======================================================================================
			// JSON 데이터를 화면에 동적으로 추가
	        function displayProfessorList(professors) {
			    let listContainer = document.getElementById("professorList");
			    let container = document.getElementById("professorListContainer");
			    
			    // 기존 내용 초기화
			    listContainer.innerHTML = "";
			
			    // 데이터를 순회하며 DOM 요소 추가
			    professors.forEach(professor => {
			        const div = document.createElement("div");
			        div.className = "professor-item";
			        div.innerHTML =
			            "<img id='professor_image' src='/hos/resources/images/" + professor.pro_file + "'>" +
			            
			            "<div id='professorList_inner' onclick='changeProfessor(\"" + 
			            professor.pro_name + "\", \"" + 
			            professor.dept_name + "\", \"" + 
			            professor.pro_idx + "\");'>" +
			            
			            "<h2 id='professorList_h2'>" + professor.pro_name + "</h2>" +
			            "<p id='professorList_dept'>" + professor.dept_name + "</p>" +
			            "<p style='margin-top:10px; font-weight:bold; font-size:20px;'>전문분야 :</p>" + 
			            professor.pro_field +
			            "</div>"
			            
			        listContainer.appendChild(div);
			    });
			
			    // 컨테이너를 화면에 표시
			    if(container.style.display == "block"){
			    	container.style.display = "none";
			    	return;
			    }else{
			    	container.style.display = "block";
			    }
			    
			}
		    //======================================================================================
		    //교수 목록에서 교수 선택 시
			function changeProfessor(name, dept, idx) {
				let container = document.getElementById("professorListContainer");
				let professorName = document.getElementById("professorName");
				let professorIdx = document.getElementById("professorIdx");
					
				//교수 이름 칸의 td의 value를 선택한 교수의 정보로 교체
				professorName.value = name + "(" + dept + ")";
				
				//hidden타입의 form으로 보낼 실제 idx값도 교체
				professorIdx.value = idx;
				
				container.style.display = "none";
			}
			//======================================================================================
			//체크박스 중복 방지(예약)
			function cb_check_res(nowcheck) {
				let cb_res = document.getElementsByClassName("cb_res");
				for(var i = 0; i < cb_res.length; i++){
					if(cb_res[i] != nowcheck){
							cb_res[i].checked = false;
					}
				}
					
			}
			//체크박스 중복 방지(결제)
			function cb_check_pay(nowcheck) {
				let cb_pay = document.getElementsByClassName("cb_pay");
				for(var i = 0; i < cb_pay.length; i++){
					if(cb_pay[i] != nowcheck){
							cb_pay[i].checked = false;
					}
				}
					
			}
			
			
			