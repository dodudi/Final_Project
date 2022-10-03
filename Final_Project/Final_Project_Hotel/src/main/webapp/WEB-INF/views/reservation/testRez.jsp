<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->
<script src="http://code.jquery.com/jquery-latest.js"></script> <!-- 제이쿼리 -->
<script>
$(function(){
	
	/* $("body").on('change', "select[name='roomId']" , function(){
		$("input[name='ROOM_ID']").val($("select[name='roomId'] option:selected").text());
	}) // 객실 선택
	
	$("body").on('change', "input[name='checkin']" , function(){
		$("input[name='REZ_CHECKIN']").val($(this).val().substr(0, 11));
	}) // 체크인 날짜 선택
	
	$("body").on('change', "input[name='checkout']" , function(){
		$("input[name='REZ_CHECKOUT']").val($(this).val().substr(0, 11));
	}) // 체크아웃 날짜 선택
	
	$("body").on('change', "select[name='adult']" , function(){
		$("input[name='REZ_ADULT']").val($("select[name='adult'] option:selected").text());
	}) // 성인 인원수 선택
	
	$("body").on('change', "select[name='child']" , function(){
		$("input[name='REZ_CHILD']").val($("select[name='child'] option:selected").text());
	}) // 아동 인원수 선택 */
	
}) // ready end
</script>
</head>
<body>
    <!--================Breadcrumb Area =================-->
    <section class="breadcrumb_area">
        <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
        <div class="container">
            <div class="page-cover text-center">
                <h2 class="page-cover-tittle">테스트</h2>
            </div>
        </div>
    </section>
    <!--================Breadcrumb Area =================-->
    
    <!--================ Accomodation Area  =================-->
    <section class="accomodation_area section_gap">
        <div class="container">
            <div class="section_title text-center">
                <h2 class="title_color">테스트</h2>
            </div>
            <div class="row mb_30">
            	<div class="accomodation_item text-center">
                   	<!-- 임시 폼 -->
				    <form action="${pageContext.request.contextPath}/option/optionForm" method="post">
				    	객실 번호 : <input type="text" name="ROOM_ID" value="3"><br>
				    	체크인 날짜 : <input type="text" name="REZ_CHECKIN" value="2022-10-10"><br>
				    	체크아웃 날짜 : <input type="text" name="REZ_CHECKOUT" value="2022-10-11"><br>
				    	성인 : <input type="text" name="REZ_ADULT" value="2"><br>
				    	아동 : <input type="text" name="REZ_CHILD" value="1"><br>
				    	<button class="btn btn-primary" type="submit"> 추가옵션 예약 </button>
				    	
				    	<!-- 403에러 방지 토큰 -->
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				    </form>
                </div>
            </div>
        </div>
    </section>
    <!--================ Accomodation Area  =================-->
    
<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/> 
</body>
</html>