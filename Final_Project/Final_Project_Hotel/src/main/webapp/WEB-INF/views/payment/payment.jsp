<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<h2>결제 데모</h2>
		<button id="payment" type="button">결제테스트</button>
	</body>

	<!-- jQuery -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<!-- iamport.payment.js -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

	<script>
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
			IMP.request_pay({ // param
				pg: "kakaopay.TC0ONETIME",
				pay_method: "card",
				merchant_uid: "ORD20180131-0000012",
				name: "노르웨이 회전 의자",
				amount: 64900,
				buyer_email: "gildong@gmail.com",
				buyer_name: "홍길동",
				buyer_tel: "010-4242-4242",
				buyer_addr: "서울특별시 강남구 신사동",
				buyer_postcode: "01182"
			}, function (rsp) { // callback
				if (rsp.success) {
					console.log("결제성공");
					// 결제 성공 시 로직,
				} else {
					console.log("결제실패");
					// 결제 실패 시 로직,
				}
			});
		}
	</script>

	</html>