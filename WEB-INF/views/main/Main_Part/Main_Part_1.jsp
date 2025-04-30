<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="/hos/resources/js/httpRequest.js"></script>
<script>
		//=======================================================================================
		//상담 예약
		function callCenter(f) {
			let name = f.callName.value;
			let tel = f.callTel.value;
			
			if(name === ''){
				alert("이름을 입력해 주세요");
				return;
			}
			if(tel === ''){
				alert("전화번호를 입력해 주세요");
				return;
			}
			
			let url = "calling_insert.do";
			let param = "name=" + name + "&tel=" + tel;
			sendRequest(url, param, callCenterFn, "GET");
		}
		
		function callCenterFn() {
			if(xhr.readyState == 4 && xhr.status == 200){
				let data = xhr.responseText;
				let json = ( new Function('return '+data) )();
				
				if(json[0].result == "succ"){
					alert("상담예약 성공");
				}else{
					alert("상담예약 실패");
				}
				location.href="main.do?pat_idx=${param.pat_idx}";
			}
		}
		
		//=======================================================================================
		//로그인
		function login() {
			let pat_id = document.getElementsByName("pat_id")[0].value;
			let pat_pwd = document.getElementsByName("pat_pwd")[0].value;
				
			//유효성검사
			if(pat_id == ''){
				alert("아이디를 입력하세요.");
				return;
			}
			if(pat_pwd == ''){
				alert("비밀번호를 입력하세요.");
				return;
			}
				
			let url = "login_chk_correct.do";
			let param = "pat_id=" + pat_id + "&pat_pwd=" + pat_pwd;
			sendRequest(url, param, login_result_fn, "post");
		}
		function login_result_fn() {
			if(xhr.readyState == 4 && xhr.status == 200){
				let data = xhr.responseText;
				let json = ( new Function('return '+data) )();
					
				if(json[0].result == "id_not_exist"){
					alert("존재하지 않는 아이디 입니다.");
					return;
				}
				else if(json[0].result == "id_exist"){
					alert("비밀번호가 일치하지 않습니다.");
					return;
				} else {
					alert("로그인 성공");
					let pat_idx = json[1].pat_idx;
					location.href="main.do?pat_idx=" + pat_idx;
				}
			}
		}
		//=======================================================================================
		//로그아웃
		function logout() {
			if(!confirm("로그아웃 하시겠습니까?")){
				return;
			}else{
				location.href="logout.do";
			}
		}//logout
	</script>

</head>
<body>
	<center>
		<div style="width: 1920px; display: flex; justify-content: center;">
			<div id="calling-card">
				<p class="card_title">상담예약</p>
				<p class="card_contents">빠르고 쉽게 진료안내를 받으실 수 있습니다.</p>
				<hr class="card-hr">
				<section class="details">
					<form>
						<input placeholder="성명 입력" name="callName"> <input
							placeholder="전화번호 입력" name="callTel" style="margin: 5px">

						<p class="card_contents" style="margin: 0;">상담시간 : 평일
							09:00-17:00</p>

						<input type="button" value="빠른 상담 신청" id="calling_btn"
							onclick="callCenter(this.form)">
					</form>
				</section>
			</div>

			<c:if test="${param.pat_idx eq null or empty param.pat_idx}">
				<div id="login-card">
					<p class="card_title">로그인/회원가입</p>
					<p class="card_contents">로그인 후 다양한 서비스를 이용하세요.</p>
					<hr class="card-hr">
					<form>
						<section class="details">
							<input placeholder="아이디 입력" name="pat_id"> 
							<input type="password" placeholder="비밀번호 입력" style="margin: 5px;" name="pat_pwd"><br>
							<a style="margin-right: 90px; font-size: 18px; cursor: pointer;"
								onclick="location.href='register_page.do'">회원가입</a> <a
								style="font-size: 18px; cursor: pointer;"
								onclick="location.href='login_find_id_form.do'">아이디 /</a> <a
								style="font-size: 18px; cursor: pointer;"
								onclick="location.href='login_find_pwd_form.do'">비밀번호 찾기</a> <input
								type="button" value="로그인" id="login_btn"
								onclick="login(this.form);">
						</section>
					</form>
				</div>
			</c:if>

			<c:if test="${param.pat_idx ne null and not empty param.pat_idx}">
				<div id="login-card">
					<p class="card_title">${sessionScope.patient.pat_name}님</p>
					<p class="card_contents">좋은 하루 보내세요.</p>
					<input type="button" value="로그아웃" id="logout_btn"
						style="margin-top: 88px;" onclick="logout();">
					<input type="button" value="예약목록" id="reservation_btn"
						style="margin-top: 5px;"
						onclick="location.href='mypage_reservation_list.do?pat_idx=${sessionScope.patient.pat_idx}'">
					<input type="button" value="마이페이지 이동" id="mypage_btn"
						style="margin-top: 5px;"
						onclick="location.href='mypage.do?pat_idx=${param.pat_idx}'">
				</div>
			</c:if>

			<div id="board-card">
				<p class="board-card-title">공지사항</p>
				<div id="board-card-plus"
					onclick="location.href='info_notice_list.do'">
					<p>+</p>
				</div>
				<table>
					<tr>
						<td>
							<div id="board-card-notice">
								<table>
									<c:forEach var="vo" items="${notices}" varStatus="status">
										<tr>
											<td>
												<c:if test="${status.index < 5}">
													<a onclick="location.href='info_notice_view.do?not_idx=${vo.not_idx}'">
															⦁ &ensp; ${vo.not_title}</a>
	
													<p>${fn:split(vo.not_date,' ')[0]}</p>
												</c:if> 
												<br>
											</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</td>
					</tr>
				</table>
			</div>

		</div>
	</center>
</body>
</html>


