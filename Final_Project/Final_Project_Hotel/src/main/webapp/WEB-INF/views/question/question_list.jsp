<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<!-- 로고 -->
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/favicon.png" type="image/png">
<title>문의사항 게시판</title>
<jsp:include page="../main/header.jsp"/>
<script>
 var result="${result}";
   if(result == 'deleteSuccess'){
      alert("삭제 성공입니다.")
   } else if(result == 'updateSuccess'){
	alert("글이 수정되었습니다.")
   }
</script>
<style>
.container{color:black;}
</style>
</head>
<body>
<!--================Breadcrumb Area =================-->
        <section class="breadcrumb_area">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
            <div class="container">
                <div class="page-cover text-center">
                    <h2 class="page-cover-tittle">문의사항</h2>
                    <ol class="breadcrumb">
                        <li class="active">커뮤니티</li>
                        <li><a href="list">문의사항</a></li>
                    </ol>
                </div>
            </div>
        </section>
<!--================Breadcrumb Area =================-->
<h1 class="title_color" style="margin-top:10rem; text-align:center">문의사항 게시판</h1>
<div class="container" style="margin-top:10rem"> 
 <%-- 게시글이 있는 경우--%> 
 <c:if test="${listcount > 0 }">
  <table class="table">
   <thead>

	<tr style="text-align:center">
		<th><div>글 번호</div></th>
		<th><div>카테고리</div></th>
		<th><div>제목</div></th>
		<th><div>작성자</div></th>
		<th><div>날짜</div></th>
		<th><div>조회수</div></th>
		<th><div>문의상태</div></th>
	</tr>	
   </thead>
   <tbody style="text-align:center">
	<c:set var="num" value="${listcount-(page-1)*limit}"/>	
	<c:forEach var="q" items="${questionlist}">	
	<tr>
	  <td><%--번호 --%>
		<c:out value="${num}"/><%-- num 출력 --%>		
		<c:set var="num" value="${num-1}"/>	<%-- num=num-1; 의미--%>	
	  </td>
	  <td><div>${q.QUESTIONS_CATEGORY}</div></td>
	  <td><%--제목 --%>
	     <div>									
			<a href="detail?num=${q.QUESTIONS_NUM}">
			   <c:out value="${q.QUESTIONS_SUBJECT }" escapeXml="true"/>		   
			</a>
		  </div>
		</td>
		<td><div>${q.MEM_ID}</div></td>
		<td><div>${q.QUESTIONS_DATE}</div></td>	
		<td><div>${q.QUESTIONS_READCOUNT}</div></td>
		<c:if test="${!empty q.QUESTIONS_ANSWER}">
               <td>
                  <div>처리완료</div>
               </td>
        </c:if>
        <c:if test="${empty q.QUESTIONS_ANSWER}">
               <td>
                  <div>처리중</div>
               </td>
        </c:if>
	   </tr>
	  </c:forEach>
	 </tbody>
	</table>
		
	<nav class="blog-pagination justify-content-center d-flex" style=margin-top:100px>
		  <ul class="pagination justify-content-center">		
			 <c:if test="${page <= 1 }">
				<li class="page-item">
				  <a href="list?page=${page}" class="page-link" aria-label="Previous">
		            <span aria-hidden="true">
		            <span class="lnr lnr-chevron-left"></span>
		            </span>
		          </a>
				</li>
			 </c:if>
			 <c:if test="${page > 1 }">			
				<li class="page-item ">
				   <a href="list?page=${page-1}" class="page-link" aria-label="Previous">
		            <span aria-hidden="true">
		            <span class="lnr lnr-chevron-left"></span>
		            </span>
		          </a>
				</li> 
			 </c:if>
					
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a == page }">
					<li class="page-item active" >
					   <a class="page-link">${a}</a>
					</li>
				</c:if>
				<c:if test="${a != page }">
				    <li class="page-item">
					   <a href="list?page=${a}" 
					      class="page-link">${a}</a>
				    </li>	
				</c:if>
			</c:forEach>
			
			<c:if test="${page >= maxpage }">
				<a href="list?page=${page}" class="page-link" aria-label="Next">
		          <span aria-hidden="true">
		          <span class="lnr lnr-chevron-right"></span>
		          </span>
		        </a>
			</c:if>
			<c:if test="${page < maxpage }">
			  <li class="page-item">
				<a href="list?page=${page+1}" class="page-link" aria-label="Next">
		          <span aria-hidden="true">
		          <span class="lnr lnr-chevron-right"></span>
		          </span>
		        </a>
			  </li>	
			</c:if>
		 </ul>
		</nav>	
    </c:if>
    
    <c:if test="${listcount == 0 }">
	  <div id=container style=height:400px;text-align:center;line-height:200px;>
	     <font size=5>등록된 글이 없습니다.</font>
	  </div>
    </c:if>
 
    <sec:authorize access="isAuthenticated()">
    			   <sec:authentication property="principal" var="pinfo"/>
    <c:if test="${pinfo.username != 'admin'}">
      <div class="button-group-area mt-40" style="height:100px">
        <a href="writeform" class="genric-btn primary circle float-right">글쓰기</a>
      </div>
    </c:if>
    <c:if test="${pinfo.username == 'admin'}">
      <div style="height:100px"></div>
    </c:if>
    </sec:authorize>
</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>