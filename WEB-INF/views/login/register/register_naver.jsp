<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		
		<link rel="stylesheet" href="/hos/resources/css/login/register.css">
		
		<script src="/hos/resources/js/httpRequest.js"></script>
		<script src="/hos/resources/js/login/register_naver.js"></script>
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="main_div">

			<a id="register_text">회원 가입</a>
			
			<!-- 회원가입 단계 -->
			<table id="register_step" border="1">
				<tr>
					<td id="step1"><a>STEP1</a><br>약관동의</td>
					<td id="step2"><a>STEP2</a><br>회원정보</td>
					<td id="step3"><a>STEP3</a><br>가입완료</td>
				</tr>
			</table>
			
			<div id="register_div">
				<hr>
				<form>
					<table>
						<tr>
							<th>이름<a class="essential">*</a></th>
							<td><input name="pat_name" value="${ naverVO.n_name }"></td>
						</tr>
						<tr>
							<th>아이디<a class="essential">*</a></th>
							<td>
								<input name="pat_id" onchange="chk_id_change();">
								<input id="id_btn" type="button" value="중복확인" onclick="chk_id( this.form );">
							</td>
						</tr>
						
						<!-- 비밀번호 & 비밀번호 확인 ------------------------------------------------------------------->
						<tr>
							<th>비밀번호<a class="essential">*</a></th>
							<td><input type="password" name="pat_pwd" onkeyup="chk_pwd();"></td>
						</tr>
						<tr>
							<th>비밀번호 확인<a class="essential">*</a></th>
							<td>
								<input type="password" name="pat_pwd2" onkeyup="chk_pwd();"><br>
								<a id="pwd_text">비밀번호가 일치하지 않습니다.</a>
							</td>
						</tr>
						
						<!-- 이메일 ------------------------------------------------------------------->
						<tr>
							<th>이메일<a class="essential">*</a></th>
							<td>
								<input class="email" name="pat_email" value="${ fn:split(naverVO.n_email, '@')[0]}">
								<a> @ </a>
								<input class="email" name="pat_email_addr" value="${ fn:split(naverVO.n_email, '@')[1]}">
								
								<select id="email_addr" onchange="chk_email(this.value);">
									<option value="">직접입력</option>
									<option value="gmail.com">gmail.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="naver.com">naver.com</option>
									<option value="nate.com">nate.com</option>
								</select>
							</td>
						</tr>
						
						<!-- 주소 ------------------------------------------------------------------->
						<tr>
							<th>주소<a class="essential">*</a></th>
							<td>
								<input id="address_post" name="pat_address_post">
								
								<input id="address_btn" type="button" value="주소찾기" onclick="find_address();"><br>
								
								<input id="address_road" name="pat_address_road"><br>
								<input id="address_detail" name="pat_address_detail" placeholder="상세 주소를 입력하세요">
							</td>
						</tr>
						
						<!-- 연락처 ------------------------------------------------------------------->
						<tr>
							<th>연락처<a class="essential">*</a></th>
							<td> 
								<select class="pat_phone" name="pat_phone" defaultValue="${fn:split(naverVO.n_phone,'-')[0]}">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select> - 
								<input class="pat_phone" name="pat_phone1_1" maxlength="4" value="${fn:split(naverVO.n_phone,'-')[1]}"> -
								<input class="pat_phone" name="pat_phone1_2" maxlength="4" value="${fn:split(naverVO.n_phone,'-')[2]}">
							</td>
						</tr>
						<tr>
							<th>비상연락처</th>
							<td>
								<select class="pat_phone" name="pat_phone2">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select> - 
								<input class="pat_phone" name="pat_phone2_1" maxlength="4"> -
								<input class="pat_phone" name="pat_phone2_2" maxlength="4">
							</td>
						</tr>
						<tr>
							<th>생년월일<a class="essential">*</a></th>
							<td><input type="date" name="pat_birthday"></td> <!-- value="${ naverVO.n_birthYear }-${ naverVO.n_birthday }" -->
						</tr>
						<tr>
							<th>성별<a class="essential">*</a></th>
							<td>
								<input class="gender" type="radio" name="pat_gender" value="남자"
									${naverVO.n_gender == 'M' ? 'checked' : ''}>남자
								<input class="gender" type="radio" name="pat_gender" value="여자"
									${naverVO.n_gender == 'F' ? 'checked' : ''}>여자
							</td>
						</tr>
					</table>

					<hr>
					<!-- 회원가입 or 가입취소 버튼 ----------------------------------------------------------------->
					<input id="back_btn" type="button" value="가입취소" onclick="history.back();">
					<input id="reg_btn" type="button" value="회원가입" onclick="register( this.form );">
				</form>
			</div>
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
	
	<!-- 주소찾기 API ------------------------------------------------------------------------------>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function find_address() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("address_detail").value = extraAddr;
	                
	                } else {
	                    document.getElementById("address_detail").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('address_post').value = data.zonecode;
	                document.getElementById("address_road").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("address_detail").focus();
	            }
	        }).open();
	    }
	</script>
</html>