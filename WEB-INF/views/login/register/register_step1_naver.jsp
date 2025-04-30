<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<link rel="stylesheet" href="/hos/resources/css/login/register_step1.css">
	
	<!-- 네이버 아이디로 로그인 API 호출 -->
	<%
	    String navApiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    navApiURL += "&client_id=" + "WYuXnPaEfWiiYkAtng_L";
	    navApiURL += "&redirect_uri=" + "http://localhost:8080/hos/register_naver_page.do";
	
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    navApiURL += "&state=" + state;
	    session.setAttribute("state", state);
	%>
	
	<script>
		/* chk_1_box, chk_2_box 모두 체크되어 있을때만 다음페이지로 이동  */
		function click_btn() {
			let chk1 = document.getElementById("chk_1_box");
			let chk2 = document.getElementById("chk_2_box");
			
			if(!chk1.checked){
				alert("이용약관 동의에 체크해주세요.");
				return;
			}
			
			if(!chk2.checked){
				alert("개인정보 처리방침에 체크해주세요.");
				return;
			}
			
			<!-- 네이버 아이디로 로그인 -->
			location.href='<%=navApiURL%>';
		}
		
		/* 모두 동의를 누르면 체크되거나 체크해제 */
		function check_boxes() {
			let chkAll = document.getElementById("chk_all_box");
			let chk1 = document.getElementById("chk_1_box");
			let chk2 = document.getElementById("chk_2_box");
			
			if(chkAll.checked){
				chk1.checked = true;
				chk2.checked = true;
				return;
			}
			else{
				chk1.checked = false;
				chk2.checked = false;
				return;
			}
		}
	</script>
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
		
		<!-- 로고 + 설명글 -->
		<div id="expl_div">
			<img src="/hos/resources/images/MEDICOMPILE LOGO.png">
			<a>MediCompile홈페이지는 이용을 원하는 모든 분들께 무료로 제공되고 있습니다.</a>
				
			<a>
				MediCompile의 온라인 회원정책은 웹회원과 진료회원으로 나뉘어 서비스 되고 있습니다.<br>
				웹회원으로 가입하는 경우, 차후 소정의 절차를 거쳐 진료회원으로 가입할 수 있습니다.<br>
				진료회원으로 가입하면 인터넷 진료예약 등 보다 다양한 서비스를 이용할 수 있습니다.<br>
				<br>
				회원 가입을 하시려면 아래의 서비스 이용약관에 동의해주세요.<br>
				회원님의 개인정보보호와 더욱 안정된 서비스를 위해 최선을 다하겠습니다.<br>
				감사합니다.
			</a>
		</div>
			
		<div id="chk_all">
			<input id="chk_all_box" type="checkbox" onchange="check_boxes();">이용약관, 개인정보 수집 이용 모두 동의합니다.
		</div>
		
		<a class="title_text">이용약관</a>
		<a class="title_ess">(*필수사항)</a>
		
		<div id="chk_1_expl">
			<jsp:include page="/WEB-INF/views/login/register/step1_chk1.jsp"/>
		</div>
		<div id="chk_1_div">
			<input id="chk_1_box" type="checkbox"> 이용약관에 동의합니다.
		</div>
		
		<a class="title_text">개인정보 수집 이용 목적</a>
		<a class="title_ess">(*필수사항)</a>
		
		<div id="chk_2_expl">
			<jsp:include page="/WEB-INF/views/login/register/step1_chk2.jsp"/>
		</div>
		<div id="chk_1_div">
			<input id="chk_2_box" type="checkbox"> 이용약관에 동의합니다.
		</div>
	
		<input type="button" value="다음단계" id="next_btn" onclick="click_btn();">
	</div>
	<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	
	
</body>
</html>