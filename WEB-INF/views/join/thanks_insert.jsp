<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>감사합니다 등록하기</title>
		
		<link rel="stylesheet" href="resources/css/join/thank_insert.css">
		<script src="resources/js/join/thanks_insert.js"></script>
		
	</head>
	
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<div id="container">
			<p>감사합니다</p>
			<form method="post"
				  enctype="multipart/form-data"
				  name="f">
				
				<input type="hidden" name="board_type" value="thanks">
				<input type="hidden" name="page" value="${param.page}">
				<input type="hidden" name="pat_idx" value="${param.pat_idx}">

				<table>
					<tr>
						<th>작성자 성함<a>*</a></th>
						<td>
							<input type="text" class="name_txt" name="board_name">
						</td>
					</tr>
					
					<tr>
						<th>휴대폰번호<a>*</a></th>
						<td> 
	                        <select class="board_phone_s" name="board_phone">
	                           <option value="010">010</option>
	                           <option value="011">011</option>
	                           <option value="016">016</option>
	                           <option value="017">017</option>
	                           <option value="018">018</option>
	                           <option value="019">019</option>
	                        </select> - 
	                        <input type="text" class="board_phone" name="board_phone_1"> -
	   
	                        <input type="text" class="board_phone" name="board_phone_2">
	                        <p class="text">연락가능한 전화번호를 입력 해 주시기 바랍니다.</p>
	                     </td>
					</tr>
			        
			        <tr>
                     <th>이메일</th>
	                     <td>
	                        <input type="text" class="email" name="board_email1">
	                        <a> @ </a>
	                        <input type="text" class="email" name="board_email2">
	                        
	                        <select id="email_addr" onchange="chk_email(this.value);">
	                           <option value="">직접입력</option>
	                           <option value="gmail.com">gmail.com</option>
	                           <option value="hanmail.net">hanmail.net</option>
	                           <option value="naver.com">naver.com</option>
	                           <option value="nate.com">nate.com</option>
	                        </select>
	                     </td>
                 	 </tr>
					
					<tr>
						<th>제목<a>*</a></th>
						<td>
							<input type="text" class="title_txt" name="board_title"/>
						</td>
					</tr>
					
					<tr>
						<th>내용<a>*</a></th>
						<td>
							<textarea class="content_txt" name="board_content" placeholder="한글 4000자 입력 가능합니다."></textarea>
						</td>
					</tr>
					
					<!-- jpg, png (이미지)파일만 첨부 가능 -->
					<tr class="last_tr">
						<th>파일첨부</th>
						<td>
							<input type="file" id="file" class="file_btn" 
								   name="photo" accept="image/gif, image/jpeg, image/png" onchange="showFileName(this);"/>
							<!-- 커스터마이즈된 버튼처럼 보이는 label -->
   						    <label for="file" class="custom-file-label">파일 선택</label>
							
							<!-- 선택된 파일 이름이 표시될 영역 -->
  						    <span class="file-name" id="file-name">선택된 파일 없음</span>
							
							<p>JPG, PNG 파일만 첨부 가능합니다. (5MB 이하)파일이름은 영문으로 작성해 주시기 바랍니다.</p>
						
						</td>
					</tr>
					
				</table>
				
				<div id="btn_div">
					<input class="list_btn" type="button" value="목록"
						   onclick="location.href='join_thanks_list.do'"/>
					<input class="insert_btn" type="button" value="확인" 
						   onclick="insert(this.form);"/>
				</div>
			</form>
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>