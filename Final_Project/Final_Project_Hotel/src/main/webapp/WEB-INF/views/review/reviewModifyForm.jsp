<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->

<!-- include libraries(jQuery, bootstrap) -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js -->
<link  href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>

<title> 리뷰 게시글 작성 </title>
<script>
$(function(){
    $(document).ready(function () {
        $('#summernote').summernote({
        	placeholder: '내용을 작성하세요',
            height: 400,
            lang: "ko-KR", // 에디터 한글 설정
            focus : true, // 에디터에 커서 이동
            toolbar: [
                ['fontname', ['fontname']], // 글꼴 설정
                ['fontsize', ['fontsize']], // 글자 크기 설정
                ['color', ['forecolor','color']], // 글자색
                ['para', ['ul', 'ol', 'paragraph']], // 글머리 기호, 번호매기기, 문단정렬
    		    ['table', ['table']], // 표만들기
    		    ['insert',['picture','link','video']], // 그림첨부, 링크만들기, 동영상첨부
                ['height', ['height']], // 줄간격
                ['view', ['codeview','fullscreen']] // 코드보기, 확대해서보기, 도움말
            ],
            fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'], // 추가한 글꼴
            
            // 이미지 첨부 콜백함수
            callbacks: {	
				onImageUpload : function(files) {
					uploadSummernoteImageFile(files[0],this);
				},
			}
        });
    });
	
	
    // 이미지 파일 업로드
    function uploadSummernoteImageFile(file, editor) {
    	var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		data = new FormData();
		data.append("file", file);
		$.ajax({
			type : "POST",
			url : "../review/uploadImage",
			data : data,
			beforeSend : function(xhr) { 
	        	xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리
	        },
			contentType : false,
			processData : false,
			success : function(data) {
				$(editor).summernote('insertImage', data.url); //항상 업로드된 파일의 url이 있어야 한다
			},
			error:function(request, status, error){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
    	
	
    // 수정완료 버튼 클릭
    $("form").submit(function(){
    	var content = $('#summernote').summernote('code');
    	console.log("*내용 길이 = " + content.length);
    	
    	// 내용 없으면 등록 불가
    	if(content.replaceAll('<p><br></p>', '') == '') {
    		alert('내용을 입력해주세요.');
    		return false;
    	}
    	
    	// 1000자 이상의 글은 등록 불가
    	if(content.length > 1000) {
    		alert('1000자 이상의 내용은 등록할 수 없습니다. (현재 길이: ' + content.length + '자)');
    		return false;
    	}
    	
    	$('input[name="REVIEW_CONTENT"]').val(content);
    })
    
    
    // 글 수정 시 비밀번호가 다른 경우
    if('${state}' == 'passFail'){
		alert("비밀번호가 다릅니다.");
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
		<h3 class="text-heading title_color">커뮤니티 > 후기게시판 > 글 수정하기</h3> 
		
		<form action="reviewModify" method="post">
			<input type="hidden" name="REVIEW_NUM" value="${review.REVIEW_NUM}">
			       
		    <h4><label for="REVIEW_SUBJECT">제목</label></h4>
			<input type="text" class="form-control" name="REVIEW_SUBJECT" value="${review.REVIEW_SUBJECT}" placeholder="Enter title" required>     
		     
			<h4><label for="summernote">내용</label></h4>   
			<textarea id="summernote" name="content" required>${review.REVIEW_CONTENT}</textarea>
			<input type="hidden" name="REVIEW_CONTENT">
			
			<h4><label for="REVIEW_PASS">Password</label></h4>
			<input type="password" class="form-control" name="REVIEW_PASS" placeholder="Enter password" required>        
			
			
			<div class="col-sm-12">
				<a onClick="history.go(-1)" class="genric-btn danger circle float-right" style="color:white">취소</a> <!-- 글 상세보기로 돌아간다 -->
				<button type="submit" class="genric-btn primary circle float-right">수정완료</button>
			</div>
			
			<!-- 403에러 방지 토큰 -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
	</div>
</section>




<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/> 	
</body>
</html>