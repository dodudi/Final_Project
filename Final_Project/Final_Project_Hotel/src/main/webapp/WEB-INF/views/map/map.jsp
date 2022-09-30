<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <title>객실예약확인페이지</title>
    </head>

    <body>
        <div id="map" style="width:500px;height:400px;"></div>

    </body>
    <!-- 카카오 맵 사용 https://apis.map.kakao.com/web/sample/basicMarker/-->
    <!--카카오 개발자 페이지https://developers.kakao.com/-->

    <!-- services와 clusterer, drawing 라이브러리 불러오기 -->
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1418c80ef227e872aa2578e5a817185e&libraries=services"></script>
    <!-- kakao map api-->
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1418c80ef227e872aa2578e5a817185e"></script>

    <script>
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
            draggable: false,
            level: 3 //지도의 레벨(확대, 축소 정도)
        };


        // 지도를 표시하는 div 크기를 변경하는 함수입니다
        function resizeMap() {
            var mapContainer = document.getElementById('map');
            mapContainer.style.width = '650px';
            mapContainer.style.height = '650px';
        }
        function relayout() {

            // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
            // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
            // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
            map.relayout();
        }

        var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴


        // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
        var mapTypeControl = new kakao.maps.MapTypeControl();
        // 지도 타입 컨트롤을 지도에 표시합니다
        map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

        // 지도에 교통정보를 표시하도록 지도타입을 추가합니다
        map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);



        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch('서울 종로구 율곡로10길 105 디아망 4층', function (result, status) {

            // 정상적으로 검색이 완료됐으면 
            if (status === kakao.maps.services.Status.OK) {

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;">중앙HTA</div>'
                });
                infowindow.open(map, marker);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            }
        });
    </script>

    </html>