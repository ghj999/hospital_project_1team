<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>감사합니다 전체보기</title>
		
		<link rel="stylesheet" href="/hos/resources/css/join/thank_list.css">
		
	</head>
	
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/> 
	
		<div id="container">
			<p>감사합니다</p>
			
			<div id="btn_div">
				<input class="myWrite_btn" type="button" value="작성글 보기"
					   onclick="location.href='mypage_managing_posts.do?pat_idx=${param.pat_idx}'"/>
				<input class="insert_btn" type="button" value="글쓰기"
					   onclick="location.href='join_thanks_insert_form.do?pat_idx=${param.pat_idx}'"/>
			</div>
			
			<div id="grid_div">
				<c:forEach var="vo" items="${list}">
					<div id="list_div" class="open_div" style="cursor: pointer;">
						<div class="title_div">
							<p>${ vo.board_title }</p>
						</div>
						
						<div class="content_div">
							<pre>${ vo.board_content }</pre>
						</div>
						
						<div class="date_name_div">
							 <p>${fn:split(vo.board_date, ' ')[0]} ${ vo.board_name } 님</p>
						</div>
						
						<div class="img_div" style="display:none;">
							<c:if test="${vo.board_file ne 'no_file'}">
								<img src="${ pageContext.request.contextPath }/resources/uploadThanksCompl/${vo.board_file}">
							</c:if>
						</div>
					
					</div>
				</c:forEach>
				
				
				<!-- 상세보기 팝업 -->
				<div class="overlay"></div> <!-- 배경 어두운 레이어 추가 -->
				<div class="modal">
					<div class="modal_popup">
						<input type="button" id="close_btn" value="x" style="cursor: pointer;"/>
						
						<p id="pop_title"></p>
						
						<div id="pop_content_div">
							<pre id="pop_content"></pre>
							<img id="pop_img">
						</div>
						
						<p id="pop_date_name"></p>	
					</div>
				</div>

				<!-- 모달 팝업 띄우기 -->
				<script>
				// 모달 관련 요소 선택
				const modal = document.querySelector('.modal');
				const overlay = document.querySelector('.overlay');
				const modalClose = document.querySelector('#close_btn');
				const modalTitle = document.querySelector('#pop_title');
				const modalContent = document.querySelector('#pop_content');
				const modalDateName = document.querySelector('#pop_date_name');
				const modalImg = document.querySelector('#pop_img');

				// 리스트 항목에 클릭 이벤트 추가
				document.querySelectorAll('.open_div').forEach(item => {
				    item.addEventListener('click', function() {
				        // 클릭한 항목의 데이터를 가져오기
				        const title = this.querySelector('.title_div p').textContent;
				        const content = this.querySelector('.content_div pre').textContent;
				        const dateName = this.querySelector('.date_name_div').textContent;
				        const imgElement = this.querySelector('.img_div img');
				        const imgSrc = imgElement ? imgElement.getAttribute('src') : "";

				        // 모달 내용 업데이트
				        modalTitle.textContent = title;
				        modalContent.textContent = content;
				        modalDateName.textContent = dateName;

				        if (imgSrc && imgSrc !== 'no_file' && imgSrc.trim() !== "") {
				            modalImg.setAttribute('src', imgSrc);
				            modalImg.style.display = 'block'; // 이미지가 존재하면 표시
				        } else {
				            modalImg.style.display = 'none'; // 이미지가 없으면 숨김
				        }

				        // 모달 표시, 배경 어둡게
				        modal.style.display = 'block';
				        overlay.style.display = 'block';
				    });
				});


				// 닫기 버튼 클릭 시 모달 및 배경 닫기
				modalClose.addEventListener('click', function() {
				    modal.style.display = 'none';
				    overlay.style.display = 'none';
				});
				
				// 배경 클릭 시 모달 및 배경 닫기
				overlay.addEventListener('click', function() {
				    modal.style.display = 'none';
				    overlay.style.display = 'none';
				});

				</script>
				
			</div>
		</div>
		
		${ pageMenu }
		
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>