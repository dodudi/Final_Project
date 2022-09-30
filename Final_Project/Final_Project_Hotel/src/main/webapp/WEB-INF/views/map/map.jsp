<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <title>객실예약확인페이지</title>
    </head>

    <body>
        <div id="map" style="width:500px;height:400px;"></div>

    </body>
    <!--카카오 맵 사용        https://apis.map.kakao.com/web/sample/basicMarker/-->
    <!--카카오 개발자 페이지   https://developers.kakao.com/-->

    <!-- services와 clusterer, drawing 라이브러리 불러오기 -->
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1418c80ef227e872aa2578e5a817185e&libraries=services"></script>
    <!-- kakao map api-->
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1418c80ef227e872aa2578e5a817185e"></script>

    <!-- 지도 생성 js-->
    <script src="/hotel/static/project_js/map/map_create_module.js"></script>
    <!-- 주소에 따른 마커 생성 js-->
    <script src="/hotel/static/project_js/map/map_address_module.js"></script>
    <!-- 주소가 표시되는 태그엘리먼트의 width, height가 동적으로 변할 때 사용해야하는 js-->
    <script src="/hotel/static/project_js/map/map_resize_module.js"></script>
    <!-- 지도에 skyview 생성-->
    <script src="/hotel/static/project_js/map/map_skyview_module.js"></script>

    </html>