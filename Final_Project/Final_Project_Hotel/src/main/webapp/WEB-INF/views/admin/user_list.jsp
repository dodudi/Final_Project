<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>공지사항 게시판</title>
<jsp:include page="../main/header.jsp"/>
<script src="http://code.jquery.com/jquery-latest.js"></script>	
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
<script>
 var result="${result}";
   if(result == 'deleteSuccess'){
      alert("회원 삭제 성공입니다.")
   } else if(result == 'updateSuccess'){
	alert("회원정보가 수정되었습니다.")
   } else if(result == 'deleteFail'){
	  alert("예약이 있어서 탈퇴불가합니다.")
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
                    <h2 class="page-cover-tittle">관리자페이지</h2>
                    <ol class="breadcrumb">
                        <li class="active">관리자페이지</li>
                        <li><a href="list">회원리스트</a></li>
                    </ol>
                </div>
            </div>
        </section>
<!--================Breadcrumb Area =================-->
<h1 class="title_color" style="margin-top:7rem; text-align:center">회원리스트</h1>
<div class="container" style="margin-top:7rem">
 <%-- 게시글이 있는 경우--%> 
 <sec:authorize access="isAuthenticated()">
 <sec:authentication property="principal" var="pinfo"/>
 <c:if test="${listcount > 0  && pinfo.username == 'admin'}">
  <table class="table">
   <thead>

	<tr style="text-align:center">
		<th><div>아이디</div></th>
		<th><div>성명</div></th>
		<th><div>생년월일</div></th>
		<th><div>이메일</div></th>
		<th><div>연락처</div></th>
		<th><div>탈퇴</div></th>
	</tr>	
   </thead>
   <tbody style="text-align:center">
	<c:set var="num" value="${listcount-(page-1)*limit}"/>	
	<c:forEach var="U" items="${userlist}">	
	<tr style=line-height:40px;>
	    <%--아이디--%>
	    <td><div>${U.MEM_ID }</div></td>
	    <%--성명--%>
		<td><div>${U.MEM_NAME }</div></td>
		<%--생년월일 --%>
		<td><div>${U.MEM_BIRTH}</div></td>	
		<%--이메일 --%>
		<td><div>${U.MEM_EMAIL}</div></td>
		<%--연락처 --%>
		<td><div>${U.MEM_PHONE}</div></td>
		<%--수정/탈퇴 --%>
		<td>
           <a href="#" class="genric-btn danger radius" data-toggle="modal"
                      data-target="#${U.MEM_ID }">
                      탈퇴
                      </a>
                      
        <%--modal 시작 --%>
        <form name="deleteForm" action="userdelete" method="post">
        <div class="modal fade" id="${U.MEM_ID}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                     <div class="modal-dialog">
                            <div class="modal-content">
                            
                                    <div class="modal-header">
                                      <h5 class="modal-title" id="exampleModalLabel" style="text-align:center">회원 탈퇴</h5>
                                    </div>
                                    
                                    <div class="modal-body" style="text-align:center">
                                      정말로 탈퇴시키겠습니까?
                                    </div>
                                                                   
                                    <div class="modal-footer">
                                       <button type="submit" class="genric-btn info radius">확인</button>
                                       <button type="button" class="genric-btn danger radius" data-dismiss="modal">취소</button> 
                                       <input type="hidden" name="MEM_ID" value="${U.MEM_ID }">
                                       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                    </div>                                                    
                            </div>
                     </div>
       </div>
       </form>
       <%--modal 끝 --%>
		</td>
		
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
		
		
	<div style="height:100px"></div>
    </c:if><%-- <c:if test="${listcount > 0 }"> end --%>
	
    <%-- 게시글이 없는 경우--%>
    <c:if test="${listcount == 0 && pinfo.username == 'admin'}">
	  <div id=container style=height:400px;text-align:center;line-height:200px;>
	     <font size=5>등록된 회원이 없습니다.</font>
	  </div>
    </c:if>
    
    <%-- admin이 아닐 경우--%>
    <c:if test="${pinfo.username != 'admin'}">
      <script>
       alert('admin만 이용할 수 있습니다.');
      </script>
    </c:if>
    </sec:authorize>
 
</div>
     
<jsp:include page="../main/footer.jsp"/>
<script>
  console.log(${param.num})
</script>
</body>
</html>