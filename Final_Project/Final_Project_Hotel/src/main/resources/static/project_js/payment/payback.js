
/**
 * 미 완 성 메 소 드
 */
function cancelPay() {
    jQuery.ajax({
        "url": "{환불요청을 받을 서비스 URL}", // 예: http://www.myservice.com/payments/cancel
        "type": "POST",
        "contentType": "application/json",
        "data": JSON.stringify({
            "merchant_uid": "{결제건의 주문번호}", // 예: ORD20180131-0000011
            "cancel_request_amount": 2000, // 환불금액
            "reason": "테스트 결제 환불", // 환불사유
            "refund_holder": "홍길동", // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주
            "refund_bank": "88", // [가상계좌 환불시 필수입력] 환불 수령계좌 은행코드(예: KG이니시스의 경우 신한은행은 88번)
            "refund_account": "56211105948400" // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
        }),
        "dataType": "json"
    });
}