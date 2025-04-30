<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>고객의 소리</title>
		
		<style>
			/* 큰 틀 */
			#container{ width:1000px;
				 		margin: 150px auto; }
				 		
			#container p { font-size: 30px;
						   font-weight: bold;}
						   
			#thanks_compl_div { display:flex;
								justify-content:center;
								padding: 50px 0; }
						   
			
			
			/* 감사합니다 박스 */			   
			#thanks_div { display:inline-block;
						  width:400px;
						  height:200px;
						  background:#6495ED;
						  position :relative;
						  margin-bottom: 20px;}
						  
			#thanks_div p { color:white;
							padding: 0 40px; }
			
			#thanks_div h4 { color:white;
							 padding: 0 40px; }
			
			#thanks_div img { width:60px;
							  height:45px;
							  position:absolute;
							  right:15px;
							  top:15px; }
							  
			#thanks_div > #thanks_insert_btn { width:150px; 
											   height:35px;
											   position: absolute;
											   left:40px;
											   background:#6495ED;
											   color:white;
											   border:1px solid white; }
											
			#thanks_div > #thanks_list_btn { width:150px; 
											 height:35px;
											 position: absolute;
											 right:40px;
											 background:#6495ED;
											 color:white;
											 border:1px solid white; }	
						  
						  
			/* 건의합니다 박스 */			  
			#complaint_div { display:inline-block;
							 width:400px;
						 	 height:200px;
						 	 background:#96C7ED;
						 	 position:relative; }
						  
			#complaint_div p { color:white; 
							   padding: 0 40px; }
			
			#complaint_div h4 { color:white;
								padding : 0 40px; }
								
			#complaint_div img { width:60px;
							  height:45px;
							  position:absolute;
							  right:15px;
							  top:15px; }
					
			#complaint_div #complaint_insert_btn {  width:150px; 
											   		height:35px;
												    position: absolute;
												    left:40px;
												    background:#96C7ED;
												    color:white;
											        border:1px solid white; }
			
			/* 고객상담실 방문 및 전화상담 시간 */
			#notice1 { margin-bottom: 100px; }
			
			#notice1 p { font-size: 18px;
						 color:	#3c3c3c;
						 padding: 5px 30px; }	
			
			
			/* 고객상담 처리과정 */			 
			#notice2 { text-align: center; }
						 
			#notice2 #icon {  display: inline-block; }
						 
			#notice2 p { font-size: 20px;
						 color:#3c3c3c; }
			#notice2 img { width: 50px; 
						   height:50px;}
			
			
		</style> 
		
	</head>
	
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="container">
			<p>고객의 소리</p>
			<div id="thanks_compl_div">
				<div id="thanks_div">
					<p>감사합니다!</p>
					<h4>칭찬 및 감사 의견 접수</h4>
					<img src="/hos/resources/img/thanks_icon.png">
					
					<input id="thanks_insert_btn" type="button" value="감사합니다 글쓰기"/>
					<input id="thanks_list_btn" type="button" value="감사합니다 전체보기"/>
				</div>
				
				<div id="complaint_div"> 
					<p>건의합니다!</p>
					<h4>제안 및 불만 고충 접수</h4>
					<img src="/hos/resources/img/complaint_icon.png">
					
					<input id="complaint_insert_btn" type="button" value="건의합니다 글쓰기"/>
				</div>
			</div>
			
			<p>고객상담실 방문 및 전화상담 시간</p>
			<div id="notice1">
				<p>평 일 : 오전 9시 ~ 오후 5시<br>
					본원/어린이/암병원 : 02-2072-2002</p>
			</div>
			
			<p>고객상담 처리과정</p>
			<div id="notice2">
				<div id="icon">	
					<img src="/hos/resources/img/register_icon.png">			
					<p>고객의 소리<br>접수</p>
				</div>
				
				<img src="/hos/resources/img/arrow_icon.png">
				
				<div id="icon">
					<img src="/hos/resources/img/check_icon.png">				
					<p>해당부서 전달<br>및 확인</p>
				</div>
				
				<img src="/hos/resources/img/arrow_icon.png">
				
				<div id="icon">
					<img src="/hos/resources/img/reply_icon.png">			
					<p>결과 회신<br>및 개선 활동</p>
				</div>
			</div>
			
		</div>
	</body>
</html>