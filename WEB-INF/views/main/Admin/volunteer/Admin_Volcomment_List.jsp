<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/hos/resources/css/join/volcomment_list.css?v=1.0">
		
	</head>
	<body>
	    <div id="container">
	        <!-- 댓글 리스트 -->
	        <div id="comment_list_div">
			    <c:forEach var="vo" items="${comm_list}">    
			        <form>    
			            <div class="comment_list" style="height: 270px;">
			                <input type="hidden" name="comm_idx" value="${vo.comm_idx}">
			                
			                <div class="comment_result_header">
			                    <c:if test="${vo.comm_name ne '메디컴파일 공식'}">
			                        <img src="/hos/resources/images/profile.png" style="object-fit: cover;">
			                    </c:if>
			                    
			                    <c:if test="${vo.comm_name eq '메디컴파일 공식'}">
			                        <img src="/hos/resources/images/MEDICOMPILE LOGO.png" style="object-fit: cover; border: 2px solid #3086C9;">
			                    </c:if>
			                    
			                    <a class="comm_name">${vo.comm_name}</a>
			                    <a class="comm_time">${vo.comm_date}</a>
			                </div>
			                
			                <div class="comment_result_body">
			                    <div class="comm_content_div">                            
			                        <pre>${vo.comm_content}</pre>
			                    </div>    
			
			                    <div class="comm_btns">
			                        <input type="button" class="comm_del_btn" value="삭제" onclick="comm_del(this.form);">
			                    </div>
			                </div>
			
			                <!-- 답글 입력창 -->
			                <div class="reply_form" style="display: flex;">
			                    <textarea class="reply_input" placeholder="답글을 입력하세요..." name="reply_content"></textarea>
			                    <button class="reply_submit_btn" onclick="reply_insert(this);">등록</button>
			                </div>
			                
			                <!-- 답글 목록 -->
			                <c:forEach var="reply" items="${reply_list}">
			                    <c:if test="${reply.comm_idx eq vo.comm_idx}">
			                        <div class="reply_item">
			                            <span class="reply_name">${reply.reply_name}</span>
			                            <span class="reply_date">${reply.reply_date}</span>
			                            <div class="reply_content"><pre>${reply.reply_content}</pre></div>
			                            <input type="button" value="삭제" onclick="reply_delete(${reply.reply_idx});">
			                        </div>
			                    </c:if>
			                </c:forEach>
			            </div>
			        </form>
			    </c:forEach>
			</div>
	    </div>
	
	    <c:if test="${not empty comm_list and fn:length(comm_list) > 0}">
	        ${pageVolComm}
	    </c:if>
	</body>
</html>



