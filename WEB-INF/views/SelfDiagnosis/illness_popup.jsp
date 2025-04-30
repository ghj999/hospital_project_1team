<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>질병 정보</title>
    <style>
        body {
            font-family: Interop, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;

            /* 배경 이미지 추가 */
            background-image: url('/hos/resources/images/질병팝업배경.PNG'); /* 경로를 수정 */
            background-size: cover; /* 화면 크기에 맞게 이미지 조정 */
            background-repeat: no-repeat; /* 이미지 반복 제거 */
            background-position: center; /* 이미지 중앙 정렬 */
        }

        .info-box {
            background-color: white; 
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
            max-width: 500px;
            width: 90%;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        p {
            font-size: 16px;
            color: #555;
        }

        strong {
            color: #000;
        }
    </style>
</head>
<body>

    <div class="info-box">
        <h1>질병 상세 정보</h1>
        <p><strong>질병 이름:</strong> ${disease.ill_name}</p>
        <p><strong>질병 설명:</strong> ${disease.ill_des}</p>
    </div>
</body>
</html>