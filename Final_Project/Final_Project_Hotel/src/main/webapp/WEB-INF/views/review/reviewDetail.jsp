<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->
<script src="http://code.jquery.com/jquery-latest.js"></script>	
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
<title>후기 게시글 상세보기</title>
<style>
	textarea {resize: none;}
	* {color:black}
	#replyComm, #reviewModify, #reviewDelete {color:blue;}
</style>
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
 	
 	// 게시글 추천
 	$("#recomm").click(function(){
 		var token  = $("meta[name='_csrf']").attr("content");
 		var header = $("meta[name='_csrf_header']").attr("content");
 		$.ajax({
 			type: "POST",
 			url: "reviewRecomm",
 			data: {"REVIEW_NUM": ${review.REVIEW_NUM}},
 			beforeSend : function(xhr) {
 				xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리
 			},
 			success: function(data){
 				if(data.recomm == 1) { // 추천
 					alert("추천되었습니다.");
 					$("#recomm").attr('class','genric-btn primary circle');
 					$("#recomm").text("추천해제");
 					$("table > tbody > tr:nth-child(3) > td:nth-child(4)").text(data.recommCount);
 				}
 				if(data.recommDel == 1) { // 추천 해제
 					alert("추천 해제되었습니다.");
 					$("#recomm").attr('class','genric-btn primary-border circle');
 					$("#recomm").text("추천");
 					$("table > tbody > tr:nth-child(3) > td:nth-child(4)").text(data.recommCount);
 				}
 			}, // success end
 			error : function(error){
				alert("게시글 추천 에러 : " + error);
			}
 		}) // ajax end
 	})
 	
 	
 	// ==================== 댓글==================== //
	console.log("글번호 => " + ${review.REVIEW_NUM});
	
	$("#comment tbody").hide(); // 댓글 리스트 숨기기
	
	var page = 1; // 더보기에서 보여줄 기본페이지
	if( ${count} != 0 ) {  // 댓글 수가 0이 아니면
		commentList(1);    // 첫페이지의 댓글을 구해옵니다. (한 페이지에 3개씩 가져옵니다.)
	} else { // 댓글이 없는 경우
		$("#message").text("등록된 댓글이 없습니다.");
	}
	
	// 댓글 리스트
	function commentList(currentPage) {
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		$.ajax({
			type : "POST",
			url:"../reviewComm/reviewCommList",
			data: {"REVIEW_NUM" : ${review.REVIEW_NUM}, "page" : currentPage},		
			beforeSend : function(xhr) { 
	        	xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리		
	        },
			dataType : "json",
			success : function(rdata){
				$("#count").text(rdata.listcount); // 댓글 수 보여줌
				
				if(rdata.listcount > 0) {
					$("#comment tbody").show(); // 문서가 로딩될 때 hide() 했던 댓글 테이블 보이게 함 (1)
					$("#comment tbody").empty();
					$(rdata.commList).each(function(){
						
						output = '';
						output += "<tr>";
						output += "		<td>";
						if (this.REVIEW_COMMENT_RE_LEV != 0) { // 답댓글인 경우 꺾인 화살표 표시
							output += '<img src="${pageContext.request.contextPath}/resources/project_image/review/commReply.png" style="width:30px; height:30px">'
						}
						output += 			"<b style='color:black'>" + this.MEM_ID
						
						// 수정된 댓글인 경우 '수정됨' 표시
						if(this.REVIEW_COMMENT_REVISION == 'Y') {
							output += "&nbsp;&nbsp;<span style='color:blue'>수정됨</span>";
						}
						
						output += "			 </b><br>" + this.REVIEW_COMMENT_DATE.substring(2);
						if(this.REVIEW_COMMENT_DATE >= "${nowday}") { // 새 댓글 new 표시
							output += '	   &nbsp;&nbsp;<img src="${pageContext.request.contextPath}/resources/project_image/review/new.png" style="width:15px; height:15px">';		
						}
						output += "</td>";
						output += "<td>";
						
						// 답댓글인 경우 원문 댓글 작성자 구하기
						if(this.REVIEW_COMMENT_RE_SEQ != 0) {
							$.ajax({
								type: "post",
								async: false, // ajax 데이터 전역변수에 담기
								url: "../reviewComm/commReplyRefMem",
								data: {"REVIEW_COMMENT_RE_REF": this.REVIEW_COMMENT_RE_REF,
									   "REVIEW_COMMENT_RE_SEQ": this.REVIEW_COMMENT_RE_SEQ
								},
								beforeSend : function(xhr) { 
						        	xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리		
						        },
								success : function(refCommMem){
									if(refCommMem != '') {
										output += "<b style='color:#3C99DC;'>@"+refCommMem+"</b>";
									} else {
										console.log("댓글 삭제시 => 답댓글의 원문댓글 작성자 구하기 실패");
									}
								} // success end
							}) // ajax end
						}
						
						// XSS(Cross-Site Scripting) : 권한이 없는 사용자가 웹사이트에 스크립트를 삽입하는 공격기법으로,
						// 이것을 방지하기 위한 방법으로 2번처럼 <td></td> 영역을 만든 뒤
						// 3번에서 text() 안에 this.context를 넣어 스크립트를 문자열로 만듭니다.								
						output += "			<textarea disabled rows='1' cols='100' style='border:none;background-color:#f9f9ff'>" + this.REVIEW_COMMENT_CONTENT + "</textarea>"
						       +  "			<input type='hidden' value=" + this.REVIEW_COMMENT_NUM + ">" // 수정, 삭제 시 필요한 댓글 번호 hidden
						       +  "			<span style='display:none'>"+ this.REVIEW_COMMENT_RE_LEV+"</span></td>" // 수정, 삭제 시 필요한 댓글 번호 hidden
						output += '		<td><img src="${pageContext.request.contextPath}/resources/project_image/review/commRecomm.png" style="width:30px; height:30px"></td>'; // 좋아요(♡) 아이콘
						output += "		<td><a href='#' data-toggle='dropdown'>"
						       +  '				<img src="${pageContext.request.contextPath}/resources/project_image/review/commMenu.png" style="width:30px; height:30px">' // 아이콘 모양 바꿀 수 있으면 바꾸기!!
						       +  "			</a>"
						       +  "			<ul class='dropdown-menu'>"		
						       +  "				<li class='nav-item'><button class='genric-btn default-border' id='commReply'>답댓글</button></li>";
						if("${loginId}" == this.MEM_ID || "${loginId}" == 'admin') { // 로그인 아이디가 관리자 or 댓글 작성자인 경우에만 수정, 삭제 버튼 생김
							output += "			<li class='nav-item'><button class='genric-btn default-border' id='commModify'>수정</button></li>"
							       +  "			<li class='nav-item'><button class='genric-btn default-border' id='commDelete'>삭제</button></li>";
						}				
						output += '			</ul></td>';
						output += '</tr>'
						
						$("#comment tbody").append(output);
					}); // each end
					
					if(rdata.listcount > rdata.commList.length) { // 전체 댓글 갯수 > 현재까지 보여준 댓글 갯수
						$("#more").text("더보기");
					} else {
						$("#more").text("");
					}
				} else {
					$("#more").text("등록된 댓글이 없습니다.");
					$("#comment tbody").empty();
					$("#comment tbody").hide(); // 1
				}
			} // success end
		}); // ajax end
	} // function commentList() end
	
	
	// 댓글 등록
	$("#commWrite").click(function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var content = $("#commContent").val().trim(); // 댓글 내용
		if(!content) {
			alert('내용을 입력하세요');
			return false;
		}
		$.ajax({
			type: "post",
			url: "../reviewComm/commWrite",
			data: {"REVIEW_COMMENT_CONTENT": content, 
				   "REVIEW_NUM": ${review.REVIEW_NUM}, // 리뷰글 번호
				   "MEM_ID": "${loginId}"},
			beforeSend : function(xhr) { 
	        	xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리		
	        },
			success : function(result){
				$("#commContent").val(''); // 댓글 등록하면 댓글창 다시 공란됨
				if(result == 1) {
					alert("댓글이 등록되었습니다.");
					// page = 1
					commentList(page); // 등록, 수정완료 후 해당 페이지 보여줍니다.
				} else {
					alert("댓글등록 실패");
				}
			} // success end
		}) // ajax end 
	}) // 댓글 등록 버튼 end
	
	// 더보기 클릭하면 page 내용이 추가로 보여진다
	$("#more").click(function(){
		commentList(++page);
	}); // 더보기 클릭 end
	
	// 답댓글 등록 클릭
	$("body").on('click', '#commReply', function(){
		var replyRefNum = $(this).parent().parent().parent().parent().find('td:nth-child(2) > input').val() // 답댓글 다는 댓글 번호
		
		// 답댓글 작성할 입력란 생성
		var replyTextarea = '<tr>'
						 + '	<td><img src="${pageContext.request.contextPath}/resources/project_image/review/commReply.png" style="width:30px; height:30px">${loginId}</td>'
						 + '	<td>'
						 + '		<textarea rows="2" class="form-control" maxLength="50" placeholder="총 50자까지 가능합니다."></textarea>'
						 + '		<input type="hidden" value="' + replyRefNum + '">' // 답댓글 다는 댓글 번호를 새로 생기는 답댓글 입력란 밑에 hidden으로 저장
						 + '	</td>'
						 + '	<td colspan="2"><button id="commReplyCancelBtn" class="btn btn-danger float-right">취소</button>'
						 + '        <button id="commReplyBtn" class="btn btn-info float-right">등록</button></td></tr>';
		$(this).parent().parent().parent().parent().after(replyTextarea); 
	})
	// 답댓글 달기
	$("body").on('click', '#commReplyBtn', function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var refNum = $(this).parent().parent().find('td:nth-child(2) > input').val(); // 답댓글 다는 댓글 번호
		var replyContent = $(this).parent().parent().find('td:nth-child(2) > textarea').val(); // 답댓글 내용
		if(!replyContent) {
			alert('내용을 입력하세요');
			return false;
		}
		$.ajax({
			type: "post",
			url: "../reviewComm/commReply",
			data: {"REVIEW_NUM": ${review.REVIEW_NUM}, // 리뷰글 번호
				   "REVIEW_COMMENT_RE_REF": refNum, // 답댓글 다는 댓글
				   "REVIEW_COMMENT_CONTENT": replyContent, // 답댓글 내용
				   "MEM_ID": "${loginId}"},
			beforeSend : function(xhr) { 
	        	xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리		
	        },
			success : function(result){
				if(result == 1) {
					alert("댓글이 등록되었습니다.");
					commentList(page); // 등록, 수정완료 후 해당 페이지 보여줍니다.
				} else {
					alert("댓글등록 실패");
				}
			} // success end
		}) // ajax end
	})
	// 답댓글 달기 취소
	$("body").on('click', '#commReplyCancelBtn', function(){
		$(this).parent().parent().remove();
	})
	
	
	// 댓글 수정 클릭
	$("body").on('click', '#commModify', function(){
		var content = $(this).parent().parent().parent().parent().find("td:nth-child(2) > textarea"); // 수정할 textarea
		content.attr('disabled', false).addClass('form-control'); 
		content.focus();
		
		var modifyBtn = '<button type="button" class="float-right" id="commModifyCancelBtn">취소</button>'
					  + '<button type="button" class="float-right" id="commModifyBtn">등록</button>';
		content.parent().append(modifyBtn);
	})
	// 댓글 수정
	$("body").on('click', '#commModifyBtn', function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var commNum = $(this).parent().find('input').val(); // 수정할 댓글 번호
		var content = $(this).parent().find('textarea'); // 수정할 textarea
		console.log("*수정할 댓글번호:"+ commNum + " /댓글내용:" + content.val());
		$.ajax({
			type: "post",
			url: "../reviewComm/commModify",
			data: {"REVIEW_COMMENT_NUM": commNum,
				   "REVIEW_COMMENT_CONTENT": content.val().trim()},
			beforeSend : function(xhr) { 
	        	xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리		
	        },
			success : function(result){
				if(result == 1) {
					alert("댓글이 수정되었습니다.");
					content.attr('disabled', true);
					commentList(page); // 등록, 수정, 삭제 후 해당 페이지 보여줍니다.
				} else {
					alert("댓글 수정 실패");
				}
			}
		}) // ajax end
	}) // 댓글 수정 end
	// 댓글 수정 취소
	$("body").on('click', '#commModifyCancelBtn', function(){
		$(this).parent().find('textarea').removeClass('form-control').attr('disabled', true).attr('cols', '100').css('border','none');
		$(this).parent().find('button:nth-child(4)').remove();
		$(this).remove();
	}) // 댓글 수정 end
	
	
	
	// 댓글 삭제 클릭
	$("body").on('click', '#commDelete', function(){
		if(!confirm('정말 삭제하시겠습니까?')) {
			return;
		}
		var commNum = $(this).parent().parent().parent().parent().find('td:nth-child(2) > input').val() // 삭제할 댓글 번호
		var commLEV = $(this).parent().parent().parent().parent().find('td:nth-child(2) > span').text() // 삭제할 댓글 LEV
		console.log("*삭제할 댓글번호: " + commNum);
		console.log("*삭제할 댓글레벨: " + commLEV);
		
		var token  = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			type : "post",
			url: "../reviewComm/commDelete",
			data : {"REVIEW_COMMENT_NUM": commNum,
				    "REVIEW_COMMENT_LEV": commLEV
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리
			},
			success : function(result){
				console.log(result);
				if(result >= 1) {
					alert("댓글이 삭제되었습니다.");
					commentList(page); // 등록, 수정, 삭제 후 해당 페이지 보여줍니다.
				} else {
					alert("댓글 삭제 실패");
				}
			} // success end
		}) // ajax end	
	}) // 댓글 삭제 end
}) // ready end
</script>
</head>
<body>
<!--================Breadcrumb Area =================-->
<section class="breadcrumb_area">
    <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
    <div class="container">
        <div class="page-cover text-center">
            <h2 class="page-cover-tittle">후기게시글 상세보기</h2>
        </div>
    </div>
</section>
<!--================Breadcrumb Area =================-->


<section class="sample-text-area">
	<div class="container">
		<h3 style="color:black;font-weight:bold">커뮤니티 > <a href="/hotel/review/reviewList" style="text-decoration:none; color:black;">후기게시판</a> > 상세보기</h3> 
		
		<!-- 게시글 -->
		<table class="table">
			<tr>
				<th style="width:10%">제목</th>
				<td colspan="3">${review.REVIEW_SUBJECT}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td colspan="3">${review.MEM_ID}</td>
			</tr>
			<tr>
				<th>등록일</th>
				<td>
					${review.REVIEW_DATE}&nbsp;&nbsp;
					<c:if test="${review.REVIEW_DATE >= nowday}">
						<img src="${pageContext.request.contextPath}/resources/project_image/review/new.png" style="width:15px; height:15px">
					</c:if>
				</td>
				<th style="width:10%">추천수</th>
				<td>${review.REVIEW_RECOMM}</td>
			</tr>
			<tr>
				<td colspan="4">${review.REVIEW_CONTENT}</td>
			</tr>
			<tr>
				<td colspan="4">
					<!-- 로그인 아이디가 댓글 작성자인 경우에만 추천 버튼 생김 -->
					<c:if test="${loginId != review.MEM_ID}">
						<!-- 기존 추천 여부에 따라 버튼 변경 -->
						<c:if test="${already == 0}">
							<button type="button" class="genric-btn primary-border circle" id="recomm">추천</button>
						</c:if>
						<c:if test="${already == 1}">
							<button type="button" class="genric-btn primary circle" id="recomm">추천해제</button>
						</c:if>
					</c:if>
					
					<!-- 로그인 아이디가 관리자 or 글 작성자인 경우에만 수정, 삭제 버튼 생김 -->
					<c:if test="${loginId == review.MEM_ID || loginId == 'admin'}">
						<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 삭제 모달 안 나오는거 해결 -->
						<button class="genric-btn danger circle float-right" data-toggle="modal" data-target="#deleteReview">삭제</button>
						<a href="reviewModifyForm?num=${review.REVIEW_NUM}" class="genric-btn info circle float-right">수정</a>
					</c:if>	
				</td>
			</tr>
		</table>
		
		<!-- 글 삭제 모달 -->
		<div class="modal" id="deleteReview">
			<div class="modal-dialog">
				<div class="modal-content">
					<c:if test="${loginId == review.MEM_ID && loginId != 'admin'}"> <!-- 글 작성자일 때는 비밀번호 입력받음 -->
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
					</c:if>
					<c:if test="${loginId == 'admin'}"> <!-- 관리자일 때는 비밀번호 없이 삭제 가능 -->
						<div class="modal-header">
							<h5>삭제하시겠습니까?</h5>
							<button type="button" class="close" data-dismiss="modal">&times;</button> <!-- 모달 닫는 x버튼 -->
						</div>
						<div class="modal-body">
							<form action="reviewDelete" method="post">
								<input type="hidden" name="REVIEW_NUM" value="${review.REVIEW_NUM}"> <!-- 삭제할 글의 글번호 -->
								<button type="submit" class="btn btn-primary">삭제</button>
								<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
								
								<!-- 403에러 방지 토큰 -->
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							</form>
						</div>
					</c:if>
				</div>
			</div>
		</div>
		
		
		
		<!-- 댓글 -->
		<div id="comment">
			<table class="table" style="margin-top:50px">
				<thead>
					<tr>
						<th colspan="5"><span id="count">${count}</span>개의 댓글</th>
					</tr>
					<tr>
						<td>
							${loginId}
						</td>
						<td colspan="2">
							<textarea rows="3" class="form-control" id="commContent" maxLength="50" placeholder="총 50자까지 가능합니다."></textarea> 
						</td>
						<td>
							<button id="commWrite" class="btn btn-info float-right">등록</button>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>아이디</th><th>내용</th><th>날짜</th><th></th><th></th> <!-- 내용부분 width 조절 -->
					</tr>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
			<div id="more" style="cursor:pointer"></div>
		</div>
	
	</div>	
</section>

<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/> 
</body>
</html>