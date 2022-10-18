<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- core 라이브러리 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> <!-- fmt 라이브러리 -->
<!DOCTYPE html>
<html>
<head>

<jsp:include page="../main/header.jsp"/>
<script>

$(function(){
	 // 추가옵션 예약 클릭
	   $("#optionBtn").click(function(){
	      $("form").attr("action", "${pageContext.request.contextPath}/option/optionForm");
	        $("form").submit();
	   })
	
	}) // ready end

	</script>

</head>
<body>
<!-- 선택된 날짜, 객실을 바탕으로 예약 전 확인하는 페이지 -->
<section class="accomodation_area section_gap">
        <div class="container">
            <div class="section_title text-center">
                <h2 class="title_color">테스트</h2>
            </div>
            <div class="row mb_30">
            	<div class="accomodation_item text-center">
                   	<!-- 임시 폼 -->
				    <form action="${pageContext.request.contextPath}/reservation/reservationfinish" method="POST">
				    	객실 번호 : <input type="text" name="ROOM_ID" value="${room.ROOM_ID}"><br>
				    	객실 이미지: 
				    	<img src="${room.ROOM_IMG}"><br>
				    	객실 명: <input type="text" name="REZ_ROOM_TYPE" value="${room.ROOM_TYPE}"><br>
				    	체크인 날짜 : <input type="text" name="REZ_CHECKIN" value="${param.checkin}"><br>
				    	체크아웃 날짜 : <input type="text" name="REZ_CHECKOUT" value="${param.checkout}"><br>
				    	성인 : <input type="text" name="REZ_ADULT" value="${param.adult}"><br>
				    	아동 : <input type="text" name="REZ_CHILD" value="${param.child}"><br>
				    	가격 : <input type="text" name="ROOM_PRICE" value="${room.ROOM_PRICE}">
				    	<button class="btn btn-warning" type="submit">예약하기</button>
				    	<button class="btn btn-primary" type="button" id="optionBtn"> 추가옵션 예약 </button>
				    	
				    	<!-- 403에러 방지 토큰 -->
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				    </form>
                </div>
            </div>
        </div>
    </section>


</body>
</html>