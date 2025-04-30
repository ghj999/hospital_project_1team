<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
	<link rel="stylesheet" href="/hos/resources/css/admin/volunteer/volunteer_insert.css">
	<script src="/hos/resources/js/httpRequest.js"></script>
	<script>
		function insert_volunteer(f) {
			let vol_title = f.vol_title.value;
			let vol_content = f.vol_content.value;
			let vol_start_date = f.vol_start_date.value;
			let vol_end_date = f.vol_end_date.value;
			
			if(vol_title == ""){
				alert("제목을 입력해주세요.");
				return;
			}
			if(vol_content == ""){
				alert("내용을 입력해주세요.");
				return;
			}
			if(vol_start_date == "" || vol_end_date == ""){
				alert("자원봉사 기간을 모두 선택해주세요.");
				return;
			}
			
			f.method = "post";
			f.action = "admin_volunteer_insert.do";
			f.submit();
		}
	</script>
	</head>
	<body>
		<!-- 헤더,사이드바 -->
		<jsp:include page="/WEB-INF/views/main/Admin/Admin_Header.jsp"/>
	
		<!-- 콘텐츠 영역 -->
		<form enctype="multipart/form-data">
			<div class="admin-content-container">
				<div class="admin-content" id="admin-content" style="margin-top: 35px;">
					<div class="scroll_container">
						<div id="container">
							<center>
							<p>자원봉사 게시글 추가</p>
							</center>
							
							<table>
								<tr>
									<th>자원봉사 게시글 제목</th>
									<td>
										<input name="vol_title" placeholder="제목을 입력해주세요" id="vol_title">
									</td>
								</tr>
								<tr>
									<th>자원봉사 게시글 내용</th>
									<td>
										<pre><textarea name="vol_content" placeholder="내용을 입력해주세요" id="vol_content"
											style="height: 300px;"></textarea></pre>
									</td>
								</tr>
								<tr>
									<th>자원봉사 게시 사진</th>
									<td>
										<input type="file" name="photo">
									</td>
								</tr>
								<tr>
									<th>자원봉사 기간</th>
									<td>
										<input type="date" name="vol_start_date" class="vol_dates">
										~
										<input type="date" name="vol_end_date" class="vol_dates">
									</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: center; border: none;">
										<input type="button" id="back_btn" value="취소하기"
											   onclick="location.href='admin_volunteer_list.do'">
											   
										<input type="button" id="ins_btn" value="추가하기" 
											style="color: white; border: none; background: #3086C9;"
											   onclick="insert_volunteer(this.form);">
									</td>
								</tr>	
							</table>
							
						</div>
					</div>
				</div>
			</div>				
		</form>
	
	</body>
</html>


