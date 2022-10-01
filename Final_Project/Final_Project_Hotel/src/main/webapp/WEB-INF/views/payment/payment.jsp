<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<!--결제 오류발생시 payment.js에서  merchant_uid를 바꿔서 해볼것-->
	<body>
		<h2>결제 데모</h2>
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
	
	<!-- 결제 시스템 -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<script src ="/hotel/static/project_js/payment/payment.js"></script>
	<!-- END -->
	
	</html>