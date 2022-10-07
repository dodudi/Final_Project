<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Font online-->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
      
		<!-- Animate.css-->
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project_css/member/join.css" >
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" >
        
        <!-- Google JQuery CDN -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/project_js/member/join.js"></script>
        
        <!-- 로고 -->
        <link rel="icon" href="${pageContext.request.contextPath}/static/image/favicon.png" type="image/png">
    	<title>Hotel Asia</title>
    </head>
    <body>
        <div>
           <div class="panel shadow1">
                <form class="login-form"> 
                	<div class="panel-switch animated">
                        <button type="button" id="step1" class="button2" >STEP1 <br>회원인증</button> 
                        <div class="icon">--- <i class="fa-solid fa-person-running"></i> ---</div>
                        <button type="button" id="step2" class="button1">STEP2 <br>정보입력</button>
                        <div class="icon">--- <i class="fa-solid fa-person-running"></i> ---</div>
                        <button type="button" id="step3"class="button2">STEP3 <br>가입완료</button>
                    </div>
                    <h1 class="animated fadeInUp animate1" id="title-login">환영합니다!</h1>
                    <h3 class="re-inform">필수정보 입력</h3>
	                    <fieldset id="login-fieldset" class="login animated fadeInUp animate2">
	                    	<span>아이디<sup>*</sup></span>
	                        <input name="id" type="text"  required   placeholder="아이디를 입력하세요"><br>
	                        <span>비밀번호<sup>*</sup></span>
	                        <input name="password" type="password" required placeholder="영문(소문자),숫자,특수문자 포함 8~12자리"><br>
	                        <span>비밀번호 확인<sup>*</sup></span>
	                        <input  name="password" type="password" required><br>
	                        <span>성명(한글)<sup>*</sup></span>
	                        <input name="username" type="text" required placeholder="이름을 입력하세요"><br>
	                        <span>이메일</span>
	                        <input name="email" type="email"><br>
	                        <span>휴대폰</span>
	                        <input  name="phone" type="text"><br>
	                        <span>생년월일</span>
	                        <input  name="phone" type="text"><br>
	                    </fieldset>
                    <div class="clearfix">
	                    <input type="reset" id="login-form-reset" class="login_form button animated fadeInUp animate3" value="취소">
	                    <input type="submit" id="login-form-submit" class="login_form button animated fadeInUp animate3" value="회원가입">
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>