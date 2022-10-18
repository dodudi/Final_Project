<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
    	<meta name="_csrf" content="${_csrf.token }">
		<meta name="_csrf_header" content="${_csrf.headerName }">
        <!-- Required meta tags -->
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Font online-->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
      
		<!-- Animate.css-->
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project_css/member/find.css" >
        
        <!-- Google JQuery CDN -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
         <script src="${pageContext.request.contextPath}/resources/project_js/member/findid.js"></script>
        
        <!-- 로고 -->
        <link rel="icon" href="${pageContext.request.contextPath}/static/image/favicon.png" type="image/png">
    	<title>Hotel Asia</title>
    	
    </head>
    <body>
        <div class="panel shadow1">
	       <ul class="tab-group panel-switch animated fadeIn">
	        <li class="tab active tabid">아이디 찾기</li>
	        <li class="tab tabpw">비밀번호 찾기</li>
	      </ul>
	      <div class="tab-content animated fadeInUp animate1">
	       <!-- 아이디찾기 -->
		      <div id="findid">
				  <div class="findIdArea">
		          	<h3>아이디를 잊으셨나요? <br> 가입시 입력하신 이메일을 통해 아이디를 확인할 수 있습니다.</h3>
		            <fieldset id="id-fieldset">
	                     <div class="find-form">
	                     	<input name="MEM_NAME" type="text"  required placeholder="이름" >
	                     </div>
	                      <div class="find-form">
	                     	<input name="MEM_EMAIL" type="email" maxLength="30" required placeholder="이메일">
	                     </div>
	                     <div class="find-form">
	                     	<div id="emailCk" class="error3"></div>
	                     </div>
	                 </fieldset>
			         <input type="button" id="findform-submit-id" class="find_form button" value="확인">
			         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			        </div>
		        </div>
		     </div>
	        <!-- 비밀번호찾기 -->
		    <div id="findpw">
			</div><!-- tab-content -->
	  </div>
    </body>
</html>