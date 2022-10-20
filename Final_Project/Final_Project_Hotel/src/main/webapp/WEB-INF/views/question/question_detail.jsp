<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../main/header.jsp"/> 
<script src="http://code.jquery.com/jquery-latest.js"></script>	
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
<title>문의사항 게시판 - 상세보기</title>
<style>
.subject{width:15%; font-weight:bold}
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
<h1 class="title_color" style="margin-top:7rem; text-align:center">문의사항 게시판 - 디테일</h1>
<input type="hidden" id="loginid" value="${question.MEM_ID}" name="loginid">
     <div class="container" style="margin-top:5rem">
         <table class="table table-stripted" >
         
             <tr>
                 <td class="subject"><div>제목</div></td>
                 <td><c:out value="${question.QUESTIONS_SUBJECT}" /></td>
                 <td class="subject"><div>카테고리</div></td>
                 <td><c:out value="${question.QUESTIONS_CATEGORY}" /></td>
             </tr>
             <tr>
                 <td class="subject"><div>작성자</div></td>
                 <td><c:out value="${question.MEM_ID}" /></td>
                 <td class="subject"><div>문의상태</div></td>
                 <c:if test="${!empty question.QUESTIONS_ANSWER}">
                     <td>
                       <div>처리완료</div>
                     </td>
                  </c:if>
                  <c:if test="${empty question.QUESTIONS_ANSWER}">
                     <td>
                        <div>처리중</div>
                     </td>
                  </c:if>
             </tr>
             <tr>
                 <td class="subject"><div>등록일</div></td>
                 <td><c:out value="${question.QUESTIONS_DATE}" /></td>
                 <td class="subject"><div>조회수</div></td>
                 <td><c:out value="${question.QUESTIONS_READCOUNT}" /></td>
             </tr>
             <tr>
                 <td class="subject" style=line-height:200px><div>문의내용</div></td>
                 <td colspan="3">
                    <div>${question.QUESTIONS_CONTENT}</div></td>
             </tr>    
             
             <tr>
                  <td class="subject" style=line-height:200px><div>답변내용</div></td>
                  <c:if test="${!empty question.QUESTIONS_ANSWER}">
                     <td colspan="3">
                       <div>${question.QUESTIONS_ANSWER}</div>
                     </td>
                  </c:if>
                  <c:if test="${empty question.QUESTIONS_ANSWER}">
                     <td colspan="3">
                       <div style=text-align:center;><h4 style=line-height:200px;>문의 처리중입니다. 잠시만 기다려주세요.</h4></div></td>
                  </c:if>    
             </tr>

             <tr>   
                <td colspan="4" class="center" style="text-align:right">
                    <sec:authorize access="isAuthenticated()">
    			      <sec:authentication property="principal" var="pinfo"/>
    			      
    			      <c:if test="${pinfo.username == question.MEM_ID}">   			   
                      <a href="modifyview?num=${question.QUESTIONS_NUM}" class="genric-btn info radius">
                      수정
                      </a>                    
                      <a href="#" class="genric-btn danger radius" data-toggle="modal"
                      data-target="#removeModal${vs.index }">
                      삭제
                      </a>                     
                      </c:if>
                      
                    
                    
                      <c:if test="${pinfo.username == 'admin'}">                  
                      <a href="answerview?num=${question.QUESTIONS_NUM}" class="genric-btn info radius">
                      답변
                      </a>                   
                      <a href="#" class="genric-btn danger radius" data-toggle="modal"
                      data-target="#removeModal${vs.index }">
                      삭제
                      </a>               
                      </c:if>
                      
                    </sec:authorize>
                    
                    <a href="list" class="genric-btn primary radius">
                    목록
                    </a>
                  
               </td>
           </tr>
         </table>
         <%-- 게시판 view end --%>
    </div>
     <%--modal 시작 --%>
     <form name="deleteForm" action="delete" method="post">
     <div class="modal fade" id="removeModal${vs.index}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                     <div class="modal-dialog">
                            <div class="modal-content">
                            
                                    <div class="modal-header">
                                      <h5 class="modal-title" id="exampleModalLabel" style="text-align:center">문의사항 삭제</h5>
                                    </div>
                                    
                                    <div class="modal-body" style="text-align:center">
                                      정말로 삭제하시겠습니까?
                                    </div>
                                                                   
                                    <div class="modal-footer">
                                       <button type="submit" class="genric-btn info radius">확인</button>
                                       <button type="button" class="genric-btn danger radius" data-dismiss="modal">취소</button>  
                                       <input type="hidden" name="num" value="${param.num }">
                                       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                    </div>                                                    
                             </div>
                     </div>
     </div>
     </form>
     
     <%--my modal end --%>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>