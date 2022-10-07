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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css" >
        
        <!-- Google JQuery CDN -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/project_js/member/login.js"></script>
        
        <!-- 로고 -->
        <link rel="icon" href="${pageContext.request.contextPath}/static/image/favicon.png" type="image/png">
    	<title>Hotel Asia</title>
    </head>
    <body>
        <div>
           <div class="panel shadow1">
                <form class="login-form"> 
                	<div class="panel-switch animated">
                        <button type="button" id="step1" disabled>STEP1 <br>회원인증</button> 
                        ---<span class="icon"><i class="fas fa-running"  aria-hidden="true"></i>---</span>
                        <button type="button" id="step2" class="active-button">STEP2 <br>정보입력</button>
                        <button type="button" id="step3"class="active-button">STEP3 <br>가입완료</button>
                    </div>
                    <h1 class="animated fadeInUp animate1" id="title-login">환영합니다!</h1>
                    <fieldset id="login-fieldset">
                        <input class="login animated fadeInUp animate2" name="username" type="textbox"  required   placeholder="Username" value="" >
                        <input class="login animated fadeInUp animate3" name="password" type="password" required placeholder="Password" value="">
                    </fieldset>
                    <input type="submit" id="login-form-submit" class="login_form button animated fadeInUp animate4" value="Log in">
                    <input type="submit" id="signup-form-submit" class="login_form button animated fadeInUp animate4 hidden" value="Sign up">
                </form>
            </div>
        </div>
    </body>
</html>