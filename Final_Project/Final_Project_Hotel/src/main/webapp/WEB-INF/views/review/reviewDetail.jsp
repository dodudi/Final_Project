<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->
<title>후기 게시글 상세보기</title>
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
            <h2 class="page-cover-tittle">후기게시글 작성</h2>
        </div>
    </div>
</section>
<!--================Breadcrumb Area =================-->


<section class="sample-text-area">
	<div class="container">
		<h3 class="text-heading title_color">커뮤니티 > 후기게시판 > 상세보기</h3> 
		
		<!-- 게시글 -->
		<table class="table">
			<tr>
				<td>제목</td>
				<td>${review.REVIEW_SUBJECT}</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${review.MEM_ID}</td>
			</tr>
			<tr>
				<td>등록일</td>
				<td>${review.REVIEW_DATE}</td>
			</tr>
			<tr>
				<td colspan="2">${review.REVIEW_CONTENT}</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="#" class="genric-btn primary circle">추천</a>
					<a href="#" class="genric-btn primary-border circle">비추천</a>
					
					<!-- 작성자 본인일 때만 나오게 c:if 하기~~ -->
					<a href="#" class="genric-btn danger circle float-right">삭제</a>
					<a href="reviewModifyForm?num=${review.REVIEW_NUM}" class="genric-btn info circle float-right">수정</a>
				</td>
			</tr>
		</table>
		
		<!-- 댓글 -->
		<div id="comment">
			<table class="table" style="margin-top:50px">
				<thead>
					<tr>
						<td>
							아이디 나올거임! ${review.MEM_ID}
						</td>
						<td>
							<textarea rows="3" class="form-control" id="content" maxLength="50" placeholder="총 50자까지 가능합니다."></textarea>
						</td>
						<td>
							<button id="write" class="btn btn-info float-right">등록</button>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>아이디</td><td>내용</td><td>날짜</td>
					</tr>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
		</div>
	
	</div>	
</section>

<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/> 
</body>
</html>