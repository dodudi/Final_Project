<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<h2>결제 데모</h2>
		<select name="pg" id="pg">
			<option value="kakaopay.TC0ONETIME">카카오</option>
			<option value="tosspay.tosstest">토스</option>
		</select>
		<br>
		<label for="price">상품이름</label>
		<input type="text" id="item_name" name="item_name" value="${paymentDTO.itemName}">
		<br>
		<label for="price">상품가격</label>
		<input type="text" id="item_price" name="item_price" value="${paymentDTO.itemPrice}">
		<br>
		<label for="price">구매자</label>
		<input type="text" id="user_name" name="user_name" value="${paymentDTO.name}">
		<br>
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
			IMP.request_pay({
				pg: $('#pg').val(),
				pay_method: "card",
				merchant_uid: "ORD20180131-0000014",
				name: $('#item_name').val(),
				amount: 55555,
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
	</script>

	</html>