<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
		<link rel="stylesheet" href="/hos/resources/css/admin/notice/notice_update.css">
		
		<script>
			//동적으로 textarea 높이 설정
			function adjustTextareaHeight(textarea) {
			    textarea.style.height = 'auto'; // 기존 높이 초기화
			    textarea.style.height = textarea.scrollHeight + 'px'; // 내용에 맞는 높이 설정
			}
	
			window.onload = function() {
			    const textarea = document.querySelector('#content textarea');
			    adjustTextareaHeight(textarea); // 초기 로드 시 높이 설정
	
			    textarea.addEventListener('input', function() {
			        adjustTextareaHeight(this); // 입력 시 높이 조정
			    });
			};
			//==============================================================
			//수정
			function notice_update(f) {
				//유효성 체크
				let not_title = f.not_title.value;
				let not_content = f.not_content.value;
				
				if(not_title == ""){
					alert("제목을 입력해주세요");
					return;
				}
				if(not_content == ""){
					alert("내용을 입력해주세요");
					return;
				}
				
				f.method = "post";
				f.action = "admin_notice_update.do?page=${param.page}";
				f.submit();
			}
			//==============================================================
			//이미지 삭제
			function delImg(f) {
				f.not_file.value = "no_file";
				
				let img = document.getElementById("notice_img");
				img.style.display = "none";
			}
		</script>
		
	</head>
	
	<body>
		<!-- 헤더,사이드바 -->
		<jsp:include page="/WEB-INF/views/main/Admin/Admin_Header.jsp"/>
		
		<!-- 콘텐츠 영역 -->
		<form enctype="multipart/form-data">
			<input type="hidden" name="not_idx" value="${ vo.not_idx }">
			<input type="hidden" name="not_file" value="${ vo.not_file }">
			<input type="hidden" name="page" value="${ param.page }">
		
			<div class="admin-content-container">
				<div class="admin-content" id="admin-content">	
					<div class="scroll_container">
					<div id="container">
						<p>병원뉴스</p>
						<hr>
						<center>
							<div id="title">
								<input value="${vo.not_title}" name="not_title">
							</div>
						</center>
						<hr>
						<div id="date">
							<p>작성일 : ${fn:split(vo.not_date, ' ')[0]}</p>
						</div>
						<hr>
						<div id="content">
							<pre><textarea name="not_content">${vo.not_content}</textarea></pre>
						</div>
						<div id="img">
							<!-- 경로 설정 해야됨 -->
							<input type="file" name="photo">
							<!-- 첨부된 이미지가 있는 경우에만 img태그를 사용 -->
							<c:if test="${ vo.not_file ne 'no_file' }">
							기존 파일: 
								<img src="${pageContext.request.contextPath}/resources/upload/${vo.not_file}"
									style="width: 100px; vertical-align: middle;" id="notice_img">
								<input type="button" value="X" onclick="delImg(this.form);">	
							</c:if>
						<hr style="margin-top: 20px;">
						<div>			
							<input type="button" id="back_btn" value="취소하기"
								   onclick="location.href='admin_notice_list.do?page=${param.page}'">
								   
							<input type="button" id="upd_btn" value="수정하기" 
								style="color: white; border: none; background: #3086C9;"
								   onclick="notice_update(this.form);">
						</div>
					</div>
				</div>
				</div>
			</div>
		</form>
	</body>
</html>


