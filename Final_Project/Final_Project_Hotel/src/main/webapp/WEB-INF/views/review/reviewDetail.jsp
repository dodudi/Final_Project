<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>	
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->
<title>후기 게시글 상세보기</title>
<script>
$(function(){
	// 글 수정 성공 후 상세보기 페이지로 온 경우
    if('${state}' == 'modifySuccess'){
		alert("글이 수정되었습니다.");
	}
	
 	// 글 삭제 실패 후 상세보기 페이지로 온 경우
    if('${state}' == 'passFail'){
		alert("비밀번호가 일치하지 않습니다.");
	}
	
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
		<h3 class="text-heading title_color">커뮤니티 > <a href="/hotel/review/reviewList" style="text-decoration: none; color: black;">후기게시판</a> > 상세보기</h3> 
		
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
					<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> <!-- 삭제 모달 안 나오는거 해결 -->
					<button class="genric-btn danger circle float-right" data-toggle="modal" data-target="#deleteReview">삭제</button>
					<a href="reviewModifyForm?num=${review.REVIEW_NUM}" class="genric-btn info circle float-right">수정</a>
				</td>
			</tr>
		</table>
		
		<!-- 글 삭제 모달 -->
		<div class="modal" id="deleteReview">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5>삭제를 위해 글 비밀번호를 입력해주세요.</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button> <!-- 모달 닫는 x버튼 -->
					</div>
					<div class="modal-body">
						<form action="reviewDelete" method="post">
							<input type="hidden" name="REVIEW_NUM" value="${review.REVIEW_NUM}"> <!-- 삭제할 글의 글번호 -->
							<div class="form-group">
								<input type="password" class="form-control" name="REVIEW_PASS" placeholder="Enter password">
							</div>
							<button type="submit" class="btn btn-primary">삭제</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
							
							<!-- 403에러 방지 토큰 -->
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						</form>
					</div>
				</div>
			</div>
		</div>
		
		
		
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