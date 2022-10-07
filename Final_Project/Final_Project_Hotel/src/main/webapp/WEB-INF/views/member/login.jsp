<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Font online-->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
      
		<!-- Animate.css-->
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project_css/member/login.css" >
        
        <!-- Google JQuery CDN -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/project_js/member/login.js"></script>
        
        <!-- 로고 -->
        <link rel="icon" href="${pageContext.request.contextPath}/static/image/favicon.png" type="image/png">
    	<title>Hotel Asia</title>
    </head>
    <body>
        <div class="panel shadow1">
             <form class="login-form" action="${pageContext.request.contextPath}/member/loginProcess" method="post">
                 <div class="panel-switch animated fadeIn">
                     <button type="button" id="log_in" class="" disabled>로그인</button>
                     <button type="button" id="sign_up"  class="active-button">회원가입</button>
                 </div>
                 <h1 class="animated fadeInUp animate1" id="title-login">Welcome Back !</h1>
                 <fieldset id="login-fieldset">
                     <input class="login animated fadeInUp animate2" name="id" type="textbox"  required placeholder="아이디" value="" >
                     <input class="login animated fadeInUp animate3" name="password" type="password" required placeholder="비밀번호" value="">
                 </fieldset>
                 <label class="animated fadeInUp animate4">
					<input type="checkbox" name="remember-me" class="remember"
						<c:if test="${!empty saveid}">
							checked
						</c:if>
					> 아이디 저장
				  </label>
                 <input type="submit" id="login-form-submit" class="login_form button animated fadeInUp animate4" value="로그인">
                 <p><a id="lost-password-link" href="" class="animated fadeIn animate5">아이디/비밀번호 찾기</a></p>
                 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
             </form>
         </div>
    </body>
</html>