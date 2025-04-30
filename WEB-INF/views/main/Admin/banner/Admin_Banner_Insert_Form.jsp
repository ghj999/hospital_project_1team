<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
		<link rel="stylesheet" href="/hos/resources/css/admin/banner/banner_insert.css">
		<script src="/hos/resources/js/httpRequest.js"></script>
		
		<script>
			function banner_insert(f) {
			    // 유효성 검사
			    let banner_name = f.banner_name.value;
			    let banner_chk = f.banner_chk.value;
			    let photo = f.photo.files[0]; // 파일 객체 가져오기
	
			    if (banner_name === "") {
			        alert("배너 이름을 입력해주세요.");
			        return;
			    }
			    if (banner_chk === "") {
			        alert("배너 사용 여부를 선택해 주세요.");
			        return;
			    }
			    if (!photo) {
			        alert("사진을 선택해 주세요.");
			        return;
			    }
	
			    // FormData 생성
			    let formData = new FormData();
			    formData.append("banner_name", banner_name);
			    formData.append("banner_chk", banner_chk);
			    formData.append("photo", photo);
	
			    //AJAX생성
			    fetch("admin_banner_insert.do", {
			        method: "POST",
			        body: formData,
			    })
			        .then(response => {
			            if (!response.ok) {
			                throw new Error(`HTTP error! status: ${response.status}`);
			            }
			            return response.json();
			        })
			        .then(data => {
			            if (data[0].result === "succ") {
			                alert("배너 추가가 완료되었습니다.");
			                location.href = "admin_banner_list.do";
			            } else {
			                alert("배너 추가 중 오류가 발생했습니다.");
			            }
			        })
			        .catch(error => {
			            console.error("Error:", error);
			            alert("서버 요청 중 오류가 발생했습니다.");
			        });

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
							<p>배너 추가</p>
							
							<table border="1">
								<tr>
									<td>배너명</td>
									<td><input placeholder="사용할 배너의 이름을 입력하세요." name="banner_name"
										id="banner_name"></td>
								</tr>
								<tr>
									<td>사용여부</td>
									<td>
										사용함:<input type="radio" value="1" name="banner_chk">&emsp;
										사용안함:<input type="radio" value="0" name="banner_chk">
									</td>
								</tr>
								<tr>
									<td>배너사진</td>
									<td><input type="file" name="photo"></td>
								</tr>
							</table>
							<div>			
								<input type="button" id="back_btn" value="취소하기"
									   onclick="location.href='admin_banner_list.do'">
									   
								<input type="button" id="ins_btn" value="추가하기" 
									style="color: white; border: none; background: #3086C9;"
									   onclick="banner_insert(this.form);">
							</div>
						</center>
					</div>
				</div>
				</div>
			</div>
		</form>
		
	</body>
</html>



