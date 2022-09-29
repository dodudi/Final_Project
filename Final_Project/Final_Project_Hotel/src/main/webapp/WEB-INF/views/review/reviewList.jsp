<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- core 라이브러리 -->
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->
<script src="http://code.jquery.com/jquery-latest.js"></script> <!-- 제이쿼리 -->
<title>후기 게시판</title>
<script>
//1. 페이지 이동
function go(page) {
	var sortBy= $('#sort').val(); // page는 1
	var data = "sortBy=" + sortBy + "&page=" + page;
	sortList(data);
} // function go end

// 2. 페이징처리 함수 - setPaging
function setPaging(href, digit) {
	active = "";
	gray = "";
	if (href == "") { // href가 빈문자열인 경우
		if (isNaN(digit)) { // 이전&nbsp; 또는 다음&nbsp; - digit이 숫자가 아닌 경우
			gray = " gray"; // 앞에 공백 주기
		} else {
			active = " active"; // 앞에 공백 주기
		}
	} // if-else end
	var output = "<li class='page-item" + active + "'>";
	var anchor = "<a class='page-link" + gray + "'" + href + ">" + digit + "</a></li>";
	output += anchor;
	return output;
} // function setPaging end

// 3. 
function sortList(sdata) {
	var token  = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$.ajax({
		type: "POST",
		data: sdata,
		url: "reviewListSort",
		dataType: "json",
		cache: false,
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리(Spring Security CSRF)
		},
		success: function(data){
			if (data.listcount > 0) { // 총갯수가 0보다 큰 경우
				$("tbody").remove();
				var num = data.listcount - (data.page - 1) * data.limit;
				console.log(num);
				var output = "<tbody>";
				console.log("*받아온 리뷰리스트=>" + data.reviewList);
				$(data.reviewList).each(function(index, item) {
					output += '<tr><td>' + (num--) + '</td>'
					output += '	   <td>'
					output += '        <a href="reviewDetail?num=' + item.REVIEW_NUM  + '">' + item.REVIEW_SUBJECT + '</a>'
					output += '	   </td>'		
					output += '    <td>' + item.REVIEW_DATE +'</td>'
					output += '    <td>' + item.MEM_ID +'</td>'
					output += '    <td>' + item.REVIEW_READCOUNT +'</td>'
					output += '    <td>' + item.REVIEW_RECOMM +'</td></tr>'
				}) // each end
				output += "</tbody>"
				$('table').append(output)//table 완성
				
				// 페이징 처리
				$(".pagination").empty(); // 기존 페이징 처리 영역 내용 제거
				output = "";
				digit = '이전&nbsp;'
				href="";	
				if (data.page > 1) {
					href = 'href=javascript:go(' + (data.page - 1) + ')';
				}
				output += setPaging(href, digit);
				
				for (var i = data.startpage; i <= data.endpage; i++) {
					digit = i;
					href="";
					if (i != data.page) {
						href = 'href=javascript:go(' + i + ')';
					} 
					output += setPaging( href, digit);
				}
				digit = '&nbsp;다음&nbsp;';
				href="";
				if (data.page < data.maxpage) {
					href = 'href=javascript:go(' + (data.page + 1) + ')';
				} 
				output += setPaging( href, digit);

				$('.pagination').append(output)
			}
		} // success end
	}) // ajax end
} // sortBy end

// ready
$(function(){
	// 글 삭제 성공 후 리뷰리스트 페이지로 온 경우
    if('${state}' == 'deleteSuccess'){
		alert("글이 삭제되었습니다.");
	}
	
    // 정렬 기준 바꿈
    $("#sort").change(function(){
		go(1); // 보여줄 페이지(go)를 1페이지로 설정합니다. - 선언적 함수 go는 ready 안에 작성하면 안 됨!!
	}); // change end
	
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
				<select class="form-control" name="search_field">
					<option value="subjectNcontent" selected>제목+내용</option>
					<option value="subject">제목</option>
					<option value="content">내용</option>
				</select>
				<input name="search_word" type="text" class="form-control" value="${search_word}"> <!-- 검색어를 입력한 후 다시 돌아온 경우 검색어가 나타나도록 합니다. -->
				<button class="genric-btn primary circle" type="submit">검색</button>
			</div>
		</form><br><br>
		
		<!-- 정렬 -->
		<div class="rows float-right" style="margin-bottom:10px;">
			<select class="form-control" id="sort">
				<option value="REVIEW_DATE" selected>등록순</option>
				<option value="REVIEW_READCOUNT">조회순</option>
				<option value="REVIEW_RECOMM">추천순</option>
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
					<c:set var="num" value="${listcount - (page - 1)*limit}"/>
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
		
		<!-- 게시글이 없는 경우 -->
		<c:if test="${listcount == 0}">
			<div class="container" style="margin-top:80px; margin-bottom:80px; text-align:center">
				<font size=5>등록된 글이 없습니다.</font>
			</div>
		</c:if>
	</div>
</section>

<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/> 	
</body>
</html>