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
                    <div class="panel-switch animated fadeIn">
                        <button type="button" id="log_in" class="active-button">로그인</button>
                        <button type="button" id="sign_up" class="" disabled>회원가입</button>
                    </div>
                    <h1 class="animated fadeInUp animate1" id="title-login">환영합니다!</h1>
                    <fieldset id="login-fieldset">
                        <input class="login animated fadeInUp animate2" name="username" type="textbox"  required   placeholder="Username" value="" >
                        <input class="login animated fadeInUp animate3" name="password" type="password" required placeholder="Password" value="">
                    </fieldset>
                    <input type="submit" id="login-form-submit" class="login_form button animated fadeInUp animate4" value="Log in">
                    <input type="submit" id="signup-form-submit" class="login_form button animated fadeInUp animate4 hidden" value="Sign up">
                    <p><a id="lost-password-link" href="" class="animated fadeIn animate5">I forgot my  login or password (!)</a></p>
                </form>
            </div>
        </div>
    </body>
</html>