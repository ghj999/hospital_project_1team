<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료기기 정보</title>
<style>
        body {
            font-family: Interop, sans-serif;
            padding: 0;
            height: 100vh;
            justify-content: center;
            align-items: center;
            
			/* 배경 이미지 추가 */
			background-image: url('/hos/resources/images/질병팝업배경.PNG'); /* 경로를 수정 */
			background-size: cover; /* 화면 크기에 맞게 이미지 조정 */
			background-repeat: no-repeat; /* 이미지 반복 제거 */
			background-position: center; /* 이미지 중앙 정렬 */
        }
        .info-box {
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
        }
    </style>
</head>
<body>
	<h1>의료기기 상세 정보</h1>
    <div class="info-box">
        <p><strong>의료기기 이름:</strong> ${device.dev_name}</p>
        <p><strong>의료기기 설명:</strong> ${device.dev_content}</p>
    </div>
</body>
</html>