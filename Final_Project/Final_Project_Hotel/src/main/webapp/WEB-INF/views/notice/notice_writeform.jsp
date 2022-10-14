<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../main/header.jsp"/>
    <meta charset="UTF-8">
    <title>공지사항 게시판 - 글쓰기</title>
    <!-- include libraries(jQuery, bootstrap) -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

    <!-- include summernote css/js-->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
    <script>
    $(function(){
	// 메인화면 페이지 로드 함수
    $(document).ready(function () {
        $('#summernote').summernote({
        	placeholder: '내용을 작성하세요',
            height: 400,
            lang: "ko-KR", // 에디터 한글 설정
            //focus : true, // 에디터에 커서 이동
            toolbar: [
                ['fontname', ['fontname']], // 글꼴 설정
                ['fontsize', ['fontsize']], // 글자 크기 설정
                //['style', ['bold', 'italic', 'underline','strikethrough', 'clear']], // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
                ['color', ['forecolor','color']], // 글자색
                ['para', ['ul', 'ol', 'paragraph']], // 글머리 기호, 번호매기기, 문단정렬
    		    ['table', ['table']], // 표만들기
    		    ['insert',['picture','link','video']], // 그림첨부, 링크만들기, 동영상첨부
                ['height', ['height']], // 줄간격
                ['view', ['codeview','fullscreen']] // 코드보기, 확대해서보기, 도움말
            ],
            fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'], // 추가한 글꼴
            //airMode:true // 글보기 모드
            
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
			url : "../notice/uploadImage",
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
	</script>
	<style>
	label{font-size:15px; font-weight:bold}
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
<div class=container>
  <form action ="write" method="post" enctype="multipart/form-data" name="writeform">
   <h1 class="title_color" style="margin-top:7rem; text-align:center">공지사항 게시판 - 글쓰기</h1>
   
     <div class="form-group" style="margin-top:7rem">
        <label for="NOTICE_NAME">글쓴이</label>
        <input name="NOTICE_NAME" id="NOTICE_NAME" value="admin" readOnly
               type="text"    class="form-control"
               placeholder="Enter notice_name">
     </div>
     
     <div class="form-group">
        <label for="NOTICE_SUBJECT">제목</label>
        <input name="NOTICE_SUBJECT" id="NOTICE_SUBJECT"
               type="text" maxlength="100"   class="form-control"
               placeholder="Enter notice_subject">
     </div>
     
     <div class="form-group">
        <label for="NOTICE_CONTENT">내용</label>
        <textarea id="summernote" name="NOTICE_CONTENT" required></textarea>
     </div>
     
     <div class="form-group" style="text-align:right; margin-top:3rem">
        <button type="submit" class="genric-btn success radius">등록</button>
        <button type="reset" class="genric-btn danger radius">취소</button>
     </div>
   
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
   </form>
 </div>
<script>
    // 메인화면 페이지 로드 함수
    $(document).ready(function () {
        $('#summernote').summernote({
            placeholder: '내용을 작성하세요',
            height: 400,
            maxHeight: 400
        });
    });
</script>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>