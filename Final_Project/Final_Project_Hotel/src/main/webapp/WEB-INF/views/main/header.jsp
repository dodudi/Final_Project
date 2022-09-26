<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<meta name="_csrf" content="${_csrf.token }">
<meta name="_csrf_header" content="${_csrf.headerName }">

<!--================Header Area =================-->
 <header class="header_area">
     <div class="container">
         <nav class="navbar navbar-expand-lg navbar-light">
             <!-- Brand and toggle get grouped for better mobile display -->
             <a class="navbar-brand logo_h" href="#"><img src="image/logo.png" alt=""></a>
             <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                 <span class="icon-bar"></span>
                 <span class="icon-bar"></span>
                 <span class="icon-bar"></span>
             </button>
             <!-- Collect the nav links, forms, and other content for toggling -->
             <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                 <ul class="nav navbar-nav menu_nav ml-auto">
                     <li class="nav-item active"><a class="nav-link" href="home">Hotel</a></li>
                     <li class="nav-item"><a class="nav-link" href="accomodation">Accomodation</a></li>
                     <li class="nav-item"><a class="nav-link" href="promotion">Promotion</a></li>
                     <li class="nav-item submenu dropdown">
                         <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Community</a>
                         <ul class="dropdown-menu">
                             <li class="nav-item"><a class="nav-link" href="info">공지사항</a></li>
                             <li class="nav-item"><a class="nav-link" href="qna">문의사항</a></li>
                             <li class="nav-item"><a class="nav-link" href="review">리뷰</a></li>
                         </ul>
                     </li> 
                 </ul>
                 
             	<sec:authorize access="isAnonymous()">
             	   <ul class="nav navbar-nav ml-auto">
		            <li class="nav-item"><a href="${pageContext.request.contextPath}/member/login" class="nav-link">로그인</a></li>
		            <li class="nav-item"><a href="${pageContext.request.contextPath}/member/join" class="nav-link">회원가입</a></li>
		      	  </ul>
             	</sec:authorize>
             	
	    		<sec:authorize access="isAuthenticated()">
    			   <sec:authentication property="principal" var="pinfo"/>
    			  	 <ul class="nav navbar-nav ml-auto">
				      <li class="nav-item">
				      	<form action="${pageContext.request.contextPath}/member/logout" method="post"
				      			style="margin-bottom:0px" name="logout">
				      		<a class="nav-link" href="#" id="logout">
				      			<span id="loginid">${pinfo.username}</span>님(로그아웃)
				      		</a>
				      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				      	</form>
				      </li>
				      <li class="nav-item">
				      	<a class="nav-link" href="${pageContext.request.contextPath}/member/update">정보수정</a>
				      </li>
					      
				      <c:if test="${pinfo.username=='admin' }">
			      		<!-- Dropdown -->
		     	  		<li class="nav-item dropdown">
		     	  			<a class="nav-link dropdown-toggle" href="#" id="navbardrop"
		     	  				data-toggle="dropdown">관리자</a>
		     	  			<div class="dropdown-menu">
		     	  				<a class="dropdown-item" href="${pageContext.request.contextPath}/member/list">회원정보</a>
		     	  				<a class="dropdown-item" href="${pageContext.request.contextPath}/board/list">게시판</a>
		     	  			</div>
		     	  		</li>
			     	  </c:if>
			     	</ul>
		     	</sec:authorize>
            </div>
         </nav>
     </div>
 </header>
 <!--================Header Area =================-->