/*
    IMP.request_pay key값 설명
    https://docs.iamport.kr/sdk/javascript-sdk#request_pay
*/

$(document).ready(function () {
    $("#payment").click(function () {
        payment();
    });
});

function payment(data) {
    IMP.init('imp83310785');
    IMP.request_pay({
        pg: "html5_inicis.INIpayTest",
        pay_method: "card",
        merchant_uid: "ORD20180131-0000016",
        name: $('#item_name').val(),
        amount: parseInt($('#item_price').val()),
        buyer_email: "gildong@gmail.com",
        buyer_name: $('#user_name').val(),
        buyer_tel: "010-4242-4242",
        buyer_addr: "서울특별시 강남구 신사동",
        buyer_postcode: "01182"
    }, function (rsp) { // callback
        if (rsp.success) {
            // 결제 성공 시 로직,
            console.log("결제성공");
        } else {
            // 결제 실패 시 로직,
            console.log("결제실패");
        }
    });
}


//통합인증.. 필요하면 쓰자
// IMP.init('imp83310785');
// IMP.certification({ // param
// 	merchant_uid: "ORD20180131-0000011", // 주문 번호
// 	m_redirect_url: "{리디렉션 될 URL}", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
// 	popup: true // PC환경에서는 popup 파라메터가 무시되고 항상 true 로 적용됨
// }, function (rsp) { // callback
// 	if (rsp.success) {
// 		// 인증 성공 시 로직,
// 	} else {
// 		// 인증 실패 시 로직,
// 	}
// });