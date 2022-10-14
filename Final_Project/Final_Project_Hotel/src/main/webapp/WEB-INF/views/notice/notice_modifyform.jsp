<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../main/header.jsp"/>
<script src="http://code.jquery.com/jquery-latest.js"></script>	
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
<title>notice_modify</title>
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
})
</script>
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
<div class="container">
   <form action ="modify" method="post">
      <input type="hidden" name="NOTICE_NUM"  value="${notice.NOTICE_NUM}">
      <input type="hidden" name="NOTICE_FILE"  value="${notice.NOTICE_FILE}">
     
     <h1 class="title_color" style="margin-top:7rem; text-align:center">공지사항 게시판 - 수정</h1>
     
     <div class="form-group" style="margin-top:5rem;">
        <label for="notice_name">글쓴이</label>
        <input name="NOTICE_NAME" type="text"    class="form-control"
               value="admin" readOnly> <%--admin 고정 --%>
     </div>
     <div class="form-group">
        <label for="notice_subject">제목</label>
        <textarea name="NOTICE_SUBJECT" id="notice_subject" rows="1"
                maxlength="100"   class="form-control">${notice.NOTICE_SUBJECT}</textarea>
     </div>
     <div class="form-group">
        <label for="notice_content">내용</label>
        <textarea name="NOTICE_CONTENT" id="notice_content"
              class="form-control" rows="15">${notice.NOTICE_CONTENT}</textarea>
     </div>


       <div class="form-group">
          <label for="board_file">파일 첨부</label>
          <label for="upfile">
            <img src="파일경로 수정" alt="파일첨부" width="20px">
          </label>
          <input type="file" id="upfile" name="uploadfile">
          <span id="filevalue">${notice.NOTICE_ORIGINAL }</span>
          <img src="파일경로 수정" alt="파일삭제" width="10px" class="remove">
       </div>
     
     <div class="form-group" style="text-align:right; margin-top:3rem">
        <button type="submit" class="genric-btn info radius">수정</button>
        <button type="reset" class="genric-btn danger radius" onClick="history.go(-1)">취소</button>
     </div>
     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
   </form>

 
</div>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>