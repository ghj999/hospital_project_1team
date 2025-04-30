<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 
<!DOCTYPE html>
<html>
   <head>
		<meta charset="UTF-8">
		<title>나의 작성글 수정하기</title>
      
		<link rel="stylesheet" href="/hos/resources/css/mypage/modify_post.css">
		
		<script>
			function update_post( f ) {
				let board_name = f.board_name.value;
				let board_title = f.board_title.value;
				let board_content = f.board_content.value;
				
				let board_phone = f.board_phone.value;
			    let board_phone_1 = f.board_phone_1.value;
			    let board_phone_2 = f.board_phone_2.value;
			    
			    //유효성체크
				if( board_name === '' ){
					alert("이름을 입력하세요.");
					return;
				}
				
				if( board_phone_1 === '' || board_phone_2 === '' ){
					alert("번호을 입력하세요.");
					return;
				} 
				
				if( board_title === '' ){
					alert("제목을 입력하세요.");
					return;
				}
				
				if( board_content === '' ){
					alert("내용을 입력하세요.");
					return;
				}
				
				f.action = 'mypage_update_post.do';
				f.submit();
			}		
		</script>
	</head>

   
	<body>
   		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
   
		<div id="container">
		    <p id="modify_text">나의 게시글 수정</p>

		    <form method="post"
		          enctype="multipart/form-data">
	     	    <input type="hidden" name="board_idx" value="${ vo.board_idx }"/>
	     	    <input type="hidden" name="pat_idx" value="${ vo.pat_idx }"/>
	     	    <input type="hidden" name="board_email" value="${ vo.board_email }"/>
	     	    <input type="hidden" name="board_type" value="${ vo.board_type }"/>
	     	    
				<table>
					<tr>
					   <th>작성자 성함<a>*</a></th>
					   <td>
					      <input class="name_txt" name="board_name" value="${ vo.board_name }"/>
					   </td>
					</tr>
				   
					<tr>
					   <th>휴대폰번호<a>*</a></th>
					   <td> 
						   <select class="pat_phone_s" name="board_phone" defaultValue="${fn:split(vo.board_phone, '-')[0]}">
						      <option value="010">010</option>
						      <option value="011">011</option>
						      <option value="016">016</option>
						      <option value="017">017</option>
						      <option value="018">018</option>
						      <option value="019">019</option>
						   </select> - 
						   <input class="board_phone" name="board_phone_1" maxlength="4" value="${fn:split(vo.board_phone, '-')[1]}"> -
						
						   <input class="board_phone" name="board_phone_2" maxlength="4" value="${fn:split(vo.board_phone, '-')[2]}">
						   <p class="text">연락가능한 전화번호를 입력 해 주시기 바랍니다.</p>
						</td>
					</tr>
					
				 	<tr>
                     <th>이메일</th>
	                     <td>
	                        <input type="text" class="email" name="board_email1" defaultValue="${fn:split(vo.board_email, '-')[0]}">
	                        <a> @ </a>
	                        <input type="text" class="email" name="board_email2" defaultValue="${fn:split(vo.board_email, '-')[1]}">
	                        
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
					   <th>내용<a>*</a></th>
					   <td>
					      <input class="title_txt" name="board_title" value="${ vo.board_title }"/>
					   </td>
					</tr>
				   
				   	<tr>
				      <th>내용</th>
				      <td>
				         <textarea class="content_txt" name="board_content" placeholder="한글 4000자 입력 가능합니다.">${ vo.board_content }</textarea>
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
							
							<c:if test="${ vo.board_file ne 'no_file' }">
								<a>현재 선택된 파일 : ${ vo.board_file }</a>
							</c:if>
							<p>JPG, PNG 파일만 첨부 가능합니다. (5MB 이하)파일이름은 영문으로 작성해 주시기 바랍니다.</p>
						</td>
					</tr>
			   </table>
			   
			   <div id="btn_div">
			      <input class="update_btn" type="button" value="수정" onclick="update_post(this.form);"/>
			      <input class="return_btn" type="button" value="취소" onclick="history.back();"/>
			   </div>
			</form>
	   </div>
	   
	   <jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>