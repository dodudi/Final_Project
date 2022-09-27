<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->
<script src="http://code.jquery.com/jquery-latest.js"></script> <!-- 제이쿼리 -->
<title>후기 게시판</title>
<style>
	/* input:focus, select:focus, option:focus, textarea:focus, button:focus{
	outline: none; }*/

</style>
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
				<input name="search_word" type="text" class="form-control" value="${search_word}"> <!-- 1. 검색어를 입력한 후 다시 memberList.net으로 온 경우 검색어가 나타나도록 합니다.  -->
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
		<table class="table">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>등록일</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>추천순</th>
			</tr>
			<tr>
				<td></td>
			</tr>
		</table>
	</div>
</section>

<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/> 	
</body>
</html>