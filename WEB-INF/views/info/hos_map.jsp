<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>간단한 지도 표시하기</title>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=io7bwup7x8"></script>
</head>
<body>

<div id="map"></div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    var mapOptions = {
        center: new naver.maps.LatLng(37.499036, 127.032924),
        zoom: 18,
        scrollWheel: false // 기본 휠 확대/축소 비활성화 (커스텀 동작 구현을 위해)
    };

    var map = new naver.maps.Map('map', mapOptions);

    var marker = new naver.maps.Marker({
        position: new naver.maps.LatLng(37.499036, 127.032924),
        map: map
    });

    // 마우스 휠 이벤트 리스너
    map.getElement().addEventListener('wheel', function (e) {
        e.preventDefault(); // 기본 동작 방지
        var zoomDelta = e.deltaY > 0 ? -1 : 1; // 휠 방향에 따라 줌 변경
        map.zoomBy(zoomDelta, map.getCenter()); // 현재 중심을 기준으로 확대/축소
    });
});
</script>


</body>
</html>

​




