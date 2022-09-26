<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>common 오류</title>
</head>
<body>
	<h1>common.jsp</h1>
		죄송합니다.<br>
		요청하신<b>${url}</b> 처리에 오류가 발생했습니다.
	<hr>
	${exception }
</body>
</html>

<!-- 에러 발생 
MemberController.java > member_update > int i = 5/0;을 넣으면 에러 발생 (정수형은 0으로 나눌수없다)
 http://localhost:8088/myhome4/member/update-->