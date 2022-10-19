<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- core 라이브러리 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> <!-- fmt 라이브러리 -->
<!DOCTYPE html>
<html>
<head>
<style>
.imgDiv {overflow:hidden; border-radius:10%;} /* 이미지 태그 감싸고 있는 div */
   .img {width:290px; height:194px; transition:all 0.2s linear;}
   .img:hover {transform: scale(1.4);}
</style>
<script src="http://code.jquery.com/jquery-latest.js"></script> <!-- 제이쿼리 -->
<jsp:include page="../main/header.jsp"/>
<script>

$(function(){
	 // 추가옵션 예약 클릭
	   $("#optionBtn").click(function(){
	      $("form").attr("action", "${pageContext.request.contextPath}/option/optionForm");
	        $("form").submit();
	   })
	   
	   $("")
	
	}) // ready end

	</script>

</head>
<body>
<!-- 선택된 날짜, 객실을 바탕으로 예약 전 확인하는 페이지 -->
 <body>
    <!--================Breadcrumb Area =================-->
    <section class="breadcrumb_area">
        <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
        <div class="container">
            <div class="page-cover text-center">
                <h2 class="page-cover-tittle">예약정보 확인</h2>
            </div>
        </div>
    </section>
    <!--================Breadcrumb Area =================-->
             <%-- <div class="row mb_30">
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
            </div>  --%>
      <section class="contact_area section_gap">
        <div class="container">
            <div class="row">
            	<div class="col-md-12">
            		<div class="contact_info">
            			<div class="info_item">
            				<table>
            					<tr>
            						<td rowspan="2" style="padding-right:20px">
            							<div class="imgDiv">
            								<img class="img" src="${room.ROOM_IMG}">
            							</div>
            						</td>
            						<td><span style="font-size:20pt;">${room.ROOM_TYPE}</span></td>
            					</tr>
            					<tr>
            						<td>
            							<a class="btn theme_btn button_hover" href="../room/roomDetail?num=${room.ROOM_ID}" target='_blank'><strong>객실 상세보기</strong></a>
            						</td>
            					</tr>
            				</table>
	                	</div>
	                </div>
	        	</div>   
            </div>
        </div>
        <br><br>
           	<div class="container">
	        <form action="${pageContext.request.contextPath}/option/memberCheck" method="post">
	            <div class="row">
	                <div class="col-md-12">
	                    <div class="contact_info">
	                        <div class="info_item">
	                            <table class="table" id="checkTable">
	                            	<thead class="thead-light">
	                            		<tr>
	                            			<th>항목</th><th>선택사항</th><th>금액</th>
	                            		</tr>
	                            	</thead>
	                            	<tbody>
		                            		<tr>
		                       					<th>날짜</th>
		                       					<td>${param.checkin} ~ ${param.checkout}
		                       						<input type="hidden" name="CHECKIN" value="${param.checkin}">
		                       						<input type="hidden" name="CHECKOUT" value="${param.checkout}"></td>
		                       					<td>${room.ROOM_PRICE} 원</td>
		                            		</tr>
		                       				<tr>
		                            			<th>객실명</th>
		                            				<td>${room.ROOM_TYPE}
		                            				<input type="hidden" name="ROOM_ID" value="${room.ROOM_ID}">
		                            				</td>
		                            			<td></td>
		                            		</tr>
		                            		<tr>
		                            			<th>인원</th>
		                            				<td>성인 : ${param.adult} / 소아 : ${param.child} 
		                            				<input type="hidden" name="ADULT" value="${param.adult}">
		                            				<input type="hidden" name="ROOM_ID" value="${room.ROOM_ID}"></td>
		                            				<td></td>
		                            		</tr>
		                            		<tr>
		                            			<th>추가옵션</th>		                            	
		                            				<td>X</td>
		                            				<td></td>
		                            		</tr>		
	                            	</tbody>
	                            	<tfoot>
								        <tr>
								            <th colspan="3" style="text-align:right">
								            	총 합계:&nbsp;&nbsp;&nbsp;<input type="text" name="total" onfocus="this.blur();">원
								            </th>
								        </tr>
								    </tfoot>
	                            </table>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-12 text-right">
	                    <button class="genric-btn primary circle" id="reservationBtn" type="submit" value="submit">회원예약</button>
	                	<button class="btn btn-primary circle" type="button" id="optionBtn"> 추가옵션 예약 </button>
	                </div>
	                
	            </div>
	            
	            <!-- 403에러 방지 토큰 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				
				<!-- 예약 시 필요한 값들을 hidden 으로 넘긴다 -->
				<input type="hidden" name="nights" value=""> <!-- 숙박일수 -->
				<input type="hidden" name="REZ_CHECKIN" value="${param.checkin}"> <!-- 체크인 날짜 -->
				<input type="hidden" name="REZ_CHECKOUT" value="${param.checkout}"> <!-- 체크아웃 날짜 -->
				<input type="hidden" name="REZ_ADULT" value="${param.adult}"> <!-- 성인 수 -->
	            <input type="hidden" name="REZ_CHILD" value="${param.child}"> <!-- 아동 수 -->
	        </form>    
        </div>
    </section> 
      
    <!--================Contact Area =================--> 
    
    
<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/>      


</body>
</html>