<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
    
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
		<link rel="stylesheet" href="/hos/resources/css/admin/volunteer/volunteer_view.css">
		<script src="/hos/resources/js/httpRequest.js"></script>
		<script>
			let comm_page = 1;
		
			window.onload = function(){
				comment_list(comm_page);
			}
			//답글 추가
			function reply_insert(button) {
			    let commentDiv = button.closest(".comment_list"); // 해당 댓글 블록 찾기
			    let replyForm = commentDiv.querySelector(".reply_form"); // 답글 입력창 찾기
			    let replyInput = replyForm ? replyForm.querySelector(".reply_input") : null; // ✅ replyInput이 null인지 체크
			    let replyContent = replyInput ? replyInput.value : ""; // ✅ replyInput이 존재하지 않으면 빈 문자열 반환
			    let vol_idx = "${param.vol_idx}"; // JSP에서 전달된 게시글 ID
			    let pat_idx = "${sessionScope.patient.pat_idx}"; // 환자 ID
			    let comm_idx_input = commentDiv ? commentDiv.querySelector("input[name='comm_idx']") : null; // ✅ 부모 댓글 ID 가져오기
			    let comm_idx = comm_idx_input.value.trim();
			   
			    if (replyContent === "") {
			        alert("답글을 입력하세요");
			        return;
			    }
			    
			    let url = "admin_volcomment_reply.do";
			    let param = "comm_idx=" + encodeURIComponent(comm_idx) +
			                "&pat_idx=" + encodeURIComponent(pat_idx) +
			                "&vol_idx=" + encodeURIComponent(vol_idx) +
			                "&reply_name=" + encodeURIComponent("메디컴파일 공식") +
			                "&reply_content=" + encodeURIComponent(replyContent);

			    sendRequest(url, param, insertFn, "post");
			}
			function insertFn() {
			    if (xhr.readyState == 4) {
			        if (xhr.status == 200) {
			            let data = xhr.responseText;

			            try {
			                let json = JSON.parse(data); // JSON 파싱

			                if (json.result === "succ") {
			                    alert("답글을 등록했습니다.");
			                    location.href="admin_volunteer_view.do?vol_idx=${param.vol_idx}&page=${param.page}";
			                } else {
			                    alert("답글 등록에 실패하였습니다.");
			                }
			            } catch (error) {
			                alert("서버 응답이 올바르지 않습니다.");
			            }
			        } else {
			            alert("서버 오류가 발생했습니다. 관리자에게 문의하세요.");
			        }
			    }
			}
			
			//답글 삭제
			function reply_delete(reply_idx) {
				if( !confirm("해당 답글을 삭제하시겠습니까?") ){
					return;
				}
				
				let url = "admin_volreply_delete.do";
				let param = "reply_idx="+reply_idx;
				sendRequest(url, param, reply_delFn, "get");
			}
			function reply_delFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if( json[0].result === "succ" ){
						comment_list( comm_page );
					}else{
						alert("삭제를 실패하였습니다.");
					}
				}
			}
			//=========================================================================================
			//댓글 추가
			function comment_insert(f){
				let comm_content = f.comm_content.value;
				
				if( comm_content === '' ){
					alert('댓글 작성을 위해 내용을 입력해주세요.');
					return;
				}
				
				let url = "admin_volcomment_insert.do";
				let param = "pat_idx=${sessionScope.patient.pat_idx}"+
							"&vol_idx="+encodeURIComponent(f.vol_idx.value)+
							"&comm_name="+encodeURIComponent("메디컴파일 공식")+
							"&comm_content="+encodeURIComponent(comm_content);
				
				sendRequest( url, param, insert_result, "get");
			}
			
			function insert_result(){
				if(xhr.readyState == 4 && xhr.status == 200 ){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if( json[0].result == "succ" ){
						comment_list(comm_page);
					}else{
						alert("댓글 등록에 실패하였습니다.");
					}
				}
			} 
			
			//댓글 조회
			function comment_list(page) {
			    let pat_idx = "${sessionScope.patient.pat_idx}"; 
			
			    if (!pat_idx || pat_idx === "null" || pat_idx === "undefined") {
			        alert("세션이 만료되었습니다."); 
			        window.location.href = "login_page.do"; 
			        return;
			    }
			
			    // 댓글 작성 textarea 초기화
			    let textarea = document.querySelector("textarea[name='comm_content']");
			    if (textarea) {
			        textarea.value = "";
			    }
			
			    comm_page = page;
			    
			    let url = "admin_volcomm_list.do";
			    let param = "pat_idx=" + encodeURIComponent(pat_idx) +
			                "&vol_idx=${param.vol_idx}" +
			                "&comm_page=" + comm_page;
			
			    sendRequest(url, param, list_result, "get");
			}
			
			function list_result(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let disp = document.getElementById("comment_list_div");
					disp.innerHTML = data;
				}
			}
			
			//댓글 삭제
			function comm_del(f){
				let comm_idx = f.comm_idx.value;
				
				if( !confirm("해당 댓글을 삭제하시겠습니까?") ){
					return;
				}
				
				let url = "admin_volcomm_del.do";
				let param = "comm_idx="+comm_idx;
				sendRequest(url, param, comm_del_result, "get");
			}
			function comm_del_result(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if( json[0].result === "succ" ){
						comment_list( comm_page );
					}else{
						alert("삭제를 실패하였습니다.");
					}
				}
			}
		</script>
	</head>
	<body>
		<!-- 헤더,사이드바 -->
		<jsp:include page="/WEB-INF/views/main/Admin/Admin_Header.jsp"/>
	
		<!-- 콘텐츠 영역 -->
		<div class="admin-content-container">
			<div class="admin-content" id="admin-content">
				<div class="scroll_container">
					<div id="container">
						
						<div id="title">
							<p>${vo.vol_title}</p>
						</div>
				
						<div id="period">
							<p>${fn:split(vo.vol_start_date, ' ')[0]} ~ ${fn:split(vo.vol_end_date, ' ')[0]}</p>
						</div>
						
						<div id="hit_and_regdate">
							<p>조회수 : ${vo.vol_hits}   |   등록일 : ${fn:split(vo.vol_date, ' ')[0]}</p>
						</div>
						
						<hr class="line2">
						
						<div id="contents">
							<pre>${vo.vol_content}</pre>
						</div>
						
						<!-- 첨부파일 div -->
						<div id="file">
							<p>파일</p>
							<c:if test="${ vo.vol_file ne 'no_file' }">
								<a href="${pageContext.request.contextPath}/resources/upload/${vo.vol_file}" download>
								    ${vo.vol_file} (다운로드) 
								</a>
							</c:if>
						    <c:if test="${ vo.vol_file eq 'no_file' }">
			        			<a>첨부된 파일이 없습니다.</a>
			        		</c:if>
						</div>
						
						<hr class="line3">
						
						<!-- 댓글입력 div -->
						<div id="comment_input_div">
							<form>
								<input type="hidden" name="pat_idx" value="${param.pat_idx}"/>
								<input type="hidden" name="vol_idx" value="${param.vol_idx}"/>
								<input type="hidden" name="comm_name" value="메디컴파일 공식"/>
								
								<div class="comment_header">
									<img id="profile" src="/hos/resources/images/MEDICOMPILE LOGO.png">
									<p>메디컴파일 공식</p><br>
								</div>
								
								<div class="comment_body">
									<textarea name="comm_content" placeholder="댓글을 입력하세요"></textarea>
									<input class="comm_insert_btn" type="button" value="등록"
									   onclick="comment_insert(this.form);"/>
								</div>
								
							</form>
						</div>
						
						<hr class="line4">
						
						<!-- 댓글조회 div -->
						<div id="comment_list_div">
						</div>
						
						<div id="page">
							${ pageMenu }
						</div>
						
						<!-- 이전글, 다음글 -->
						<div id="pre_next_div">
							<table>
								<tr>
									<th>이전글</th>
									<td class="pre_td">
										<c:if test="${preVol ne null}">
											<a href="admin_volunteer_view.do?vol_idx=${preVol.vol_idx}&page=${param.page}">${preVol.vol_title}</a>						
										</c:if>
										
										<c:if test="${preVol eq null }">
											<a>이전 글이 존재하지 않습니다.</a>
										</c:if>
									</td>
								</tr>
								
								<tr>
									<th>다음글</th>
									<td class="next_td">
										<c:if test="${nextVol ne null}">
											<a href="admin_volunteer_view.do?vol_idx=${nextVol.vol_idx}&page=${param.page}">${nextVol.vol_title}</a>							
										</c:if>
										
										<c:if test="${nextVol eq null}">
											<a>다음 글이 존재하지 않습니다.</a>
										</c:if>
									</td>
								</tr>
							</table>
						</div>
						
						<div id="list_btn_div">			
							<input type="button" id="back_btn" value="목록으로"
								   onclick="location.href='admin_volunteer_list.do?page=${param.page}'">
						</div>
								
					</div>
				</div>
			</div>
		</div>
	</body>
</html>




