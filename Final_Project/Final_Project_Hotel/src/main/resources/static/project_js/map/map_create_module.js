
/**
 * 지도 생성 메소드 입니다.
 * 지도를 사용하기 위해서 가장 먼저 script에서 호출해주세요.
 */

let map = createMap();

function createMap() {
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
        draggable: false, //드래그 불가능
        level: 3 //지도의 레벨(확대, 축소 정도)
    };

    return new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
}

