//진료예약
		function reservationContent() {
		    document.getElementById('board_content').style.display = 'none';
		    document.getElementById('introduce_content').style.display = 'none';
		    document.getElementById('health_content').style.display = 'none';
		    document.getElementById('reservation_content').style.display = 'block';
		    document.getElementById('menubar').style.height = '350px';
		}
	    
	    //병원게시판
		function boardContent() {
		    document.getElementById('reservation_content').style.display = 'none';
		    document.getElementById('introduce_content').style.display = 'none';
		    document.getElementById('health_content').style.display = 'none';
		    document.getElementById('board_content').style.display = 'block';
		    document.getElementById('menubar').style.height = '350px';
		}
	    
		//병원안내
		function introduceContent() {
		    document.getElementById('reservation_content').style.display = 'none';
		    document.getElementById('board_content').style.display = 'none';
		    document.getElementById('health_content').style.display = 'none';
		    document.getElementById('introduce_content').style.display = 'block';
		    document.getElementById('menubar').style.height = '350px';
		}
		
		//건강정보
		function healthContent() {
		    document.getElementById('reservation_content').style.display = 'none';
		    document.getElementById('board_content').style.display = 'none';
		    document.getElementById('introduce_content').style.display = 'none';
		    document.getElementById('health_content').style.display = 'block';
		    document.getElementById('menubar').style.height = '55px';
		}
		//=======================================================================
		//메뉴바 오픈
		function hideMenubarContent() {
		    document.getElementById('reservation_content').style.display = 'none';
		    document.getElementById('board_content').style.display = 'none';
		    document.getElementById('introduce_content').style.display = 'none';
		    document.getElementById('menubar').style.height = '55px';
		}
		// 부모 요소인 #menubar에 mouseleave이벤트 추가
		document.getElementById('menubar').addEventListener('mouseleave', () => {
		    hideMenubarContent(); // 메뉴바를 벗어났을 때 콘텐츠 숨김
		});
		
	