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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project_css/member/join2.css" >
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" >
        
        <!-- Google JQuery CDN -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        
        <!-- 로고 -->
        <link rel="icon" href="${pageContext.request.contextPath}/static/image/favicon.png" type="image/png">
    	<title>Hotel Asia</title>
    	<script>
    	$(function(){
    		$('#login-form-login').click(function(){
    			location.href="../member/login";
    		});
    		$('#login-form-main').click(function(){
    			location.href="../main/main";
    		})
    	})
    	</script>
    </head>
    <body>
        <div>
           <div class="panel shadow1"> 
          	 <form>
              	<div class="panel-switch animated">
                      <button type="button" id="step1" class="button1" >STEP1 <br>정보입력</button> 
                      <div class="icon" style="position:relative; top:10px">--- <i class="fa-solid fa-handshake-simple"></i> ---</div>
                      <button type="button" id="step2" class="button2">STEP2 <br>가입완료</button>
                 </div>
                 <h1 class="animated fadeInUp animate1" id="title-login">환영합니다!</h1>
                 <h3 class="animated fadeInUp animate2">
                 	가입하신 이메일로 인증 메일을 성공적으로 보냈습니다. 
                 </h3>
                
                 <div class="clearfix">
	                  <input type="text" id="login-form-login" class="login_form button animated fadeInUp animate3" value="로그인">
	                  <input type="text" id="login-form-main" class="login_form button animated fadeInUp animate3" value="메인화면">
                 </div>
                </form>
            </div>
        </div>
    </body>
</html>