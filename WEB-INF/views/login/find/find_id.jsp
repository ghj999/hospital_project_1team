<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    

    <link rel="stylesheet" href="/hos/resources/css/login/find_id.css">
    <script src="/hos/resources/js/httpRequest.js"></script>
    <script>
        function send_mail(f) {
			let pat_name = document.getElementById("pat_name").value;
			let pat_email = document.getElementById("pat_email").value;
			
        	if(pat_id == '' || pat_email == ''){
        		alert("빈칸을 모두 입력하세요.");
        		return;
        	}
        	
            let url = 'login_find_id.do';
            let param = "pat_name=" + pat_name + "&pat_email=" + pat_email;
            sendRequest(url, param, result_mail, "post");
        }
        
        let number;
        let pat_id;
        function result_mail() {
        	if(xhr.readyState == 4 && xhr.status == 200){
                document.getElementById("input_number").disabled = false;
                
				let data = xhr.responseText;
				let json = ( new Function('return '+data) )();
				
                if (json[0].result == "no_patient") {
                    alert("존재하지 않는 정보입니다.");    
                    return;
                } else {
                    alert("인증코드가 이메일로 전송됐습니다.");
                    number = json[0].result;
                    pat_id = json[1].id;
                    
                    document.getElementById("pat_name").disabled = true;
                    document.getElementById("pat_email").disabled = true;
                }
            }
        }
        
        function chk_number() {
            let inp_number = document.getElementById("input_number").value;
            if (number == inp_number) {
                alert("인증이 완료되었습니다.");
                location.href = 'login_find_id_page.do?pat_id=' + pat_id;
            } else {
                alert("인증번호가 일치하지 않습니다.");
                return;
            }
        }
    </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
	<div id="main_div">
	    <div id="find_id_div">
	        <form>
	            <p id="find_id_text">아이디 찾기를 위한 이메일 인증</p>
	            <p id="find_id_sub">이메일 인증을 마치면, 아이디 확인이 가능합니다.</p>
	            <input id="pat_name" name="pat_name" placeholder="이름을 입력하세요.">
	            <input id="pat_email" name="pat_email" placeholder="이메일을 입력하세요.">
	            <input id="cert_btn" type="button" value="인증하기" onclick="send_mail(document.forms[0]);"> 
	        </form>    
	        <input id="input_number" disabled="disabled" placeholder="인증번호 6자리를 입력하세요">
	        <input id="ok_btn" type="button" value="확인" onclick="chk_number();"> 
	    </div>
	</div>	
	
	<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
</body>
</html>
