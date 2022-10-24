<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- core 라이브러리 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> <!-- fmt 라이브러리 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->
<script src="http://code.jquery.com/jquery-latest.js"></script> <!-- 제이쿼리 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script> <!-- 결제 시스템 - 아임포트API -->
<title>예약완료 - 예약확인 페이지</title>
</head>
<body>
	<!--================Breadcrumb Area =================-->
    <section class="breadcrumb_area">
        <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
        <div class="container">
            <div class="page-cover text-center">
                <h2 class="page-cover-tittle">예약 확인</h2>
            </div>
        </div>
    </section>
    <!--================Breadcrumb Area =================-->
    
    <!--================Contact Area =================-->
    <section class="contact_area section_gap">
        <div class="container">
        	<table class="table table-bordered" style="color:black">
        		<thead style="background-color:#f5f2a3">
	        		<tr>
	        			<th>예약상태</th>
	        			<th colspan="3">예약완료 - 예약번호 ${rez.REZ_ID}
	        			</th>
	        		</tr>
        		<thead>
        		<tbody>
        			<c:set var="num" value="1" />
	        		<tr style="background-color:lightgray">
	        			<th colspan="5">
	        				0<c:out value="${num}" /> 일정 및 객실
	        				<c:set var="num" value="${num+1}" />
	        			</th>
	        		</tr>
	        		<tr>
	        			<th>객실정보</th><td colspan="3">${rez.ROOM_ID}&nbsp;${room.ROOM_TYPE}</td>
	        		</tr>
	        		<tr>
	        			<th>체크인</th><td colspan="3">${rez.REZ_CHECKIN}</td>
	        		</tr>
	        		<tr>
	        			<th>체크아웃</th><td colspan="3">${rez.REZ_CHECKOUT}</td>
	        		</tr>
	        		<tr>
	        			<th>숙박일수</th><td colspan="3">${nights}박</td>
	        		</tr>
	        		<tr>
	        			<th>예약자명</th><td colspan="3">${member.MEM_NAME}</td>
	        		</tr>
	        		<tr>
	        			<th>인원수</th><td colspan="3">${rez.REZ_ADULT + rez.REZ_CHILD}명 (성인 ${rez.REZ_ADULT}명 / 아동 ${rez.REZ_CHILD}명)</td>
	        		</tr>
	        		
	        		<!-- 옵션 예약 리스트 -->
	        		<c:if test="${optRezListCount > 0}">
		        		<tr style="background-color:lightgray">
		        			<th colspan="5">
		        				0<c:out value="${num}" />  옵션 선택
	    	    				<c:set var="num" value="${num+1}" />
		        			</th>
		        		</tr>
		        		
		        		<c:forEach var="dl" items="${dateList}">
			        		<tr><!-- 날짜 -->
			        			<td>${dl}</td>
			        				
			        			<c:forEach var="orl" items="${optRezList}">
			        				<%-- <c:if test = "${fn:contains(dl, orl.OPTION_RESERVATION_DATE)}"> --%>
			        				<<c:if test="${dl eq orl.OPTION_RESERVATION_DATE}"> <!-- 해당 날짜에 해당하는 옵션예약정보만 출력 -->
								     	<c:if test="${orl.OPTION_ID == 1}"> <!-- 조식 -->
					        					<td>조식 | 성인 ${orl.ADULT}명 / 아동 ${orl.CHILD}명</td>
					        			</c:if>
					        			<c:if test="${orl.OPTION_ID == 2}">
					        					<td>디너 | 성인 ${orl.ADULT}명 / 아동 ${orl.CHILD}명</td>
					        			</c:if>
					        			<c:if test="${orl.OPTION_ID == 3}">
					        				<td>수영장 | 성인 ${orl.ADULT}명 / 아동 ${orl.CHILD}명</td>
					        			</c:if>
				        			</c:if>
			        			</c:forEach>
			        		</tr>
			        	</c:forEach>
			        </c:if>
			        
			        <!-- 결제금액 -->
			        <tr style="background-color:lightgray">
	        			<th colspan="5">
	        				0<c:out value="${num}" />  결제금액
	    	    			<c:set var="num" value="${num+1}" />
	        			</th>
	        		</tr>
	        		<tr>
	        			<th>총금액</th><td colspan="3">
	        				<fmt:formatNumber value="${originalPrice}" pattern="#,###"/>원
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>할인금액</th><td colspan="3">
	        			<fmt:formatNumber value="${paymentInfo.POINT_DISCOUNT + couponPrice}" pattern="#,###"/>원
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>최종 결제금액</th>
	        			<td colspan="3">
	        				<fmt:formatNumber value="${paymentInfo.PAYMENT_PRICE}" pattern="#,###"/>원
	        			</td>
	        		</tr>
        		</tbody>
        	</table>
        </div>
    </section>
    <!--================Contact Area =================-->

<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/>   
</body>
</html>