<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../main/header.jsp"/> 
<script src="http://code.jquery.com/jquery-latest.js"></script>	
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
<title>notice_detail</title>
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
                    <h2 class="page-cover-tittle">공지사항</h2>
                    <ol class="breadcrumb">
                        <li class="active">커뮤니티</li>
                        <li><a href="list">공지사항</a></li>
                    </ol>
                </div>
            </div>
        </section>
<!--================Breadcrumb Area =================-->
<h1 class="title_color" style="margin-top:7rem; text-align:center">공지사항 게시판 - 디테일</h1>
<input type="hidden" id="loginid" value="admin" name="loginid"> <%-- admin으로 고정 --%>
     <div class="container" style="margin-top:5rem">
         <table class="table table-stripted" >
         
             <tr>
                 <td class="subject"><div>제목</div></td>
                 <td colspan="3"><c:out value="${notice.NOTICE_SUBJECT}" /></td>
             </tr>
             <tr>
                 <td class="subject"><div>글쓴이</div></td>
                 <td colspan="3"><div>admin</div></td> <%--admin으로 고정 --%>
             </tr>
             <tr>
                 <td class="subject"><div>등록일</div></td>
                 <td><c:out value="${notice.NOTICE_DATE}" /></td>
                 <td class="subject"><div>조회수</div></td>
                 <td><c:out value="${notice.NOTICE_READCOUNT}" /></td>
             </tr>
             <tr>
                 <td class="subject"><div>내용</div></td>
                 <td colspan="3">
                    <div>${notice.NOTICE_CONTENT}</div></td>
             </tr>    
             <tr>
             
                  <td class="subject"><div>첨부파일</div></td>
                  <c:if test="${!empty notice.NOTICE_FILE}">
                     <td colspan="3"><img src="${pageContext.request.contextPath}/resources/static/image/attch.jpg" alt="">
                         <form method="post" action="down" style="height:0px">
                           <input type="hidden" value="${notice.NOTICE_FILE }" name="filename">
                           <input type="hidden" value="${notice.NOTICE_ORIGINAL }" name="original">
                           <input type="submit" value="${notice.NOTICE_ORIGINAL }">
                         </form>
                  </c:if>
                  <c:if test="${empty notice.NOTICE_FILE}">
                              <td colspan="3"><div></div></td>
                  </c:if>    
             </tr>

             <tr>   <%-- 수정 삭제는 admin일 때만 나타나도록 변경 예정 --%>
                <td colspan="4" class="center" style="text-align:right">
                    <%-- <c:if test="${MEM_ID == 'admin'}"> --%> 
                      <a href="modifyview?num=${notice.NOTICE_NUM}" class="genric-btn info radius">
                      수정
                      </a>
                      <a href="#" class="genric-btn danger radius" data-toggle="modal"
                      data-target="#removeModal${vs.index }">
                      삭제
                      </a>
                    <%-- </c:if> --%> 
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
                                      <h5 class="modal-title" id="exampleModalLabel" style="text-align:center">공지사항 삭제</h5>
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