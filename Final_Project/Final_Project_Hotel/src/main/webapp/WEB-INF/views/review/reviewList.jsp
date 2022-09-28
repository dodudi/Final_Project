<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- core 라이브러리 -->
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->
<script src="http://code.jquery.com/jquery-latest.js"></script> <!-- 제이쿼리 -->
<title>후기 게시판</title>
<script>
$(function(){
	
}) // ready end
</script>
</head>
<body>
<!--================Breadcrumb Area =================-->
<section class="breadcrumb_area">
    <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
    <div class="container">
        <div class="page-cover text-center">
            <h2 class="page-cover-tittle">후기게시판</h2>
        </div>
    </div>
</section>
<!--================Breadcrumb Area =================-->


<!-- 게시판 -->
<section class="sample-text-area">
	<div class="container">
		<h3 class="text-heading title_color">커뮤니티 > 후기게시판</h3>
		
		<a href="reviewWriteForm" class="genric-btn primary circle">글쓰기</a>
		
		<!-- 검색 -->
		<form action="" method="post" style="float:right">
			<div class="input-group">
				<select name="search_field">
					<option value="subjectNcontent" selected>제목+내용</option>
					<option value="subject">제목</option>
					<option value="content">내용</option>
				</select>
				<input name="search_word" type="text" class="form-control" value="${search_word}"> <!-- 검색어를 입력한 후 다시 돌아온 경우 검색어가 나타나도록 합니다. -->
				<button class="genric-btn primary circle" type="submit">검색</button>
			</div>
		</form><br><br>
		
		<!-- 정렬 -->
		<div class="rows" style="float:right; margin-bottom:10px;">
			<select class="form-control">
				<option value="reg" selected>등록순</option>
				<option value="view">조회순</option>
				<option value="recomm">추천순</option>
			</select>
		</div>	
          
		
		<!-- 게시글 리스트 -->
		<c:if test="${listcount > 0}">
			<table class="table">
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>등록일</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>추천순</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="num" value="${listcount - (page - 1)*limit }"/>
					<c:forEach var="reviewList" items="${reviewList}">
						<tr>
							<td>
								<c:out value="${num}"/>  <!-- num 출력 -->
								<c:set var="num" value="${num-1}"/>  <!-- num=num-1; -->
							</td>
							<td>
								<a href="reviewDetail?num=${reviewList.REVIEW_NUM}">
									${reviewList.REVIEW_SUBJECT}
									<%-- <span class="gray small">[<c:out value="${reviewList.CNT }"/>]</span> --%>
								</a>
							</td>
							<td>${reviewList.REVIEW_DATE}</td>
							<td>${reviewList.MEM_ID}</td>
							<td>${reviewList.REVIEW_READCOUNT}</td>
							<td>${reviewList.REVIEW_RECOMM}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!-- 페이지네이션 -->
			<div class="center-block">
				<ul class="pagination justify-content-center">
					<c:if test="${page <= 1}">  <!-- page는 현재 페이지 -->
						<li class="page-item">
							<a class="page-link gray">이전&nbsp;</a> <!-- page(현재 페이지)가 1페이지보다 작은 경우 이동할 이전 페이지가 없다 -->
						</li>
					</c:if>
					<c:if test="${page > 1}"> 
						<li class="page-item">
							<a href="reviewList?page=${page-1}" class="page-link">이전&nbsp;</a> <!-- page(현재 페이지)가 1페이지보다 크면 이동할 이전 페이지가 생긴다 -->
						</li>
					</c:if>
					
					<c:forEach var="a" begin="${startpage}" end="${endpage}">
						<c:if test="${a == page}">
							<li class="page-item active">
								<a class="page-link">${a}</a>
							</li>
						</c:if>
						<c:if test="${a != page}">
							<li class="page-item">
								<a href="reviewList?page=${a}" class="page-link">${a}</a>
							</li>
						</c:if>
					</c:forEach>
					
					<c:if test="${page >= maxpage}">
						<li class="page-item">
							<a class="page-link gray">&nbsp;다음</a>
						</li>
					</c:if>	
					<c:if test="${page < maxpage}">
						<li class="page-item">
							<a href="reviewList?page=${page+1}" class="page-link">&nbsp;다음</a>
						</li>
					</c:if>						
				</ul>
			</div>
		</c:if>
	</div>
</section>

<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/> 	
</body>
</html>