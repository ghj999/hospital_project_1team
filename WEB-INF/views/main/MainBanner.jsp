<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<link rel="stylesheet" href="/hos/resources/css/mainpage-user/mainbanner.css">
	<script src="/hos/resources/js/httpRequest.js"></script>
	
	<script>
		//배너 기본 기능들
		document.addEventListener("DOMContentLoaded", () => {
		    let slides = document.getElementById('slides');
		    let slideCount = slides.childElementCount;
		    let slideWidth = document.querySelector('.slider-container').offsetWidth;
		    let pagination = document.getElementById('pagination');
		    let currentIndex = 0; // 현재 슬라이드 인덱스
		    let slideInterval;    // 자동 슬라이드를 위한 타이머 변수
			
		 	// 이미지 로드 후 가장 큰 높이를 계산
		    const sliderContainer = document.querySelector(".slider-container");
		    const images = slides.querySelectorAll("img");
		
		    let maxHeight = 0;
		
		    // 모든 이미지의 높이 계산 후, 슬라이더 컨테이너에 반영
		    images.forEach(img => {
		        img.onload = () => {
		            maxHeight = Math.max(maxHeight, img.naturalHeight);
		            sliderContainer.style.height = maxHeight + "px";
		        };
		    });
		    
		    // 페이징 도트 생성
		    function createPagination() {
		        for (let i = 0; i < slideCount; i++) {
		            const dot = document.createElement('div');
		            dot.classList.add('dot');
		            dot.dataset.index = i;
		            pagination.appendChild(dot);
		
		            dot.addEventListener('click', () => {
		                moveToSlide(i);
		            });
		        }
		        updatePagination();
		    }

		    // 페이징 도트 상태 업데이트
		    function updatePagination() {
		        const dots = document.querySelectorAll('.pagination .dot');
		        dots.forEach((dot, index) => {
		            dot.classList.toggle('active', index === currentIndex);
		        });
		    }
		    
		    //슬라이드 이동 함수
		    function moveSlide(step) {
		        currentIndex += step;
		        if (currentIndex < 0) {
		            currentIndex = slideCount - 1;
		        } else if (currentIndex >= slideCount) {
		            currentIndex = 0;
		        }
		        slides.style.transform = "translateX(-" + (currentIndex * slideWidth) + "px)";
		        updatePagination(); // 페이징 상태 업데이트
		    }
			
		    // 특정 인덱스로 슬라이드 이동
		    function moveToSlide(index) {
		        currentIndex = index;
		        slides.style.transform = "translateX(-" + (currentIndex * slideWidth) + "px)";
		        updatePagination();
		    }
		    
		 	// 자동 슬라이드 함수
		    function startAutoSlide() {
		        stopAutoSlide(); // 기존 타이머를 초기화
		        slideInterval = setInterval(() => {
		            moveSlide(1); // 다음 슬라이드로 이동
		        }, 4000); // 4초마다 실행
		    }
			
		 	// 타이머 초기화 함수
		    function stopAutoSlide() {
		        if (slideInterval) {
		            clearInterval(slideInterval);
		        }
		    }
		    
		 	// 버튼 이벤트 연결
		    document.querySelector('.slider-btn.prev').addEventListener('click', () => {
		        moveSlide(-1);
		        startAutoSlide(); // 버튼 클릭 시 자동 슬라이드 재시작
		    });
		    document.querySelector('.slider-btn.next').addEventListener('click', () => {
		        moveSlide(1);
		        startAutoSlide(); // 버튼 클릭 시 자동 슬라이드 재시작
		    });

		 	// 초기화
		    createPagination();
		    startAutoSlide();
		});
		
		//배너 삭제
		function delete_banner() {
			const centerX = window.innerWidth / 2; // 화면 너비의 절반
		    const centerY = window.innerHeight / 2; // 화면 높이의 절반
		    
		 	// 문자열 연결 방식으로 옵션 작성
		    const options = "width=500,height=400,left=" + centerX + ",top=" + centerY;
		    
		    window.open(
		        "delete_banner_page.do", // 팝업에 띄울 페이지
		        "삭제할 배너의 이름을 선택해주세요", // 팝업창 이름
		        options // 옵션
		    );
		}
	</script>
	
	</head>
	<body>
		<div class="slider-container">
		    <div class="slides" id="slides">
		        <c:forEach var="vo" items="${images}">
		        	<c:if test="${vo.banner_chk eq 1}">
		            	<img src="/hos/resources/upload/${vo.banner_file}" alt="배너 이미지">
		        	</c:if>
		        </c:forEach>
		    </div>
		
		    <input type="button" value="<" class="slider-btn prev">
		    <input type="button" value=">" class="slider-btn next">
		    
		    <!-- 페이징 도트 영역 -->
    		<div class="pagination" id="pagination"></div>
		</div>
	</body>
</html>


