<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/hotel/payment" method="get">
		상품이름<input type="text" id="itemName" name="itemName">
		<br>
		상품가격<input type="text" id="itemPrice" name="itemPrice">
		<br>
		전화번호<input type="text" id="phone" name="phone">
		<br>
		이름<input type="text" id="name" name="name">
		<br>
		주소<input type="text" id="addr" name="addr">
		<br>
		<input type="submit">
	</form>
</body>
</html>