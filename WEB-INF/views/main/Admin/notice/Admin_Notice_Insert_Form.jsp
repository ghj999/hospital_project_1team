<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
		<link rel="stylesheet" href="/hos/resources/css/admin/notice/notice_insert.css">
	</head>
	
	<script>
		function notice_insert(f) {
			//유효성 검사
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
			f.action = "admin_notice_insert.do";
			f.submit();
		}
	</script>
		
	<body>
		<!-- 헤더,사이드바 -->
		<jsp:include page="/WEB-INF/views/main/Admin/Admin_Header.jsp"/>
		
		<!-- 콘텐츠 영역 -->
		<form enctype="multipart/form-data">
			<div class="admin-content-container" style="margin-top: 35px;">
				<div class="admin-content" id="admin-content">	
					<div class="scroll_container">
					<div id="container">
						<p>병원뉴스</p>
						<center>
							<div id="title">
								<input value="${vo.not_title}" name="not_title" placeholder="제목을 입력해주세요">
							</div>
						</center>
						<div id="content">
							<pre><textarea name="not_content" placeholder="내용을 입력해주세요"
								style="height: 300px;">${vo.not_content}</textarea></pre>
						</div>
						
						<!-- 경로 설정 해야됨 -->
						<input type="file" name="photo">
						
						<div>			
							<input type="button" id="back_btn" value="취소하기"
								   onclick="location.href='admin_notice_list.do'">
								   
							<input type="button" id="ins_btn" value="추가하기" 
								style="color: white; border: none; background: #3086C9;"
								   onclick="notice_insert(this.form);">
						</div>
					</div>
					</div>
				</div>
			</div>
		</form>
	</body>
</html>