<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- core 라이브러리 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> <!-- fmt 라이브러리 -->
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->
<script src="http://code.jquery.com/jquery-latest.js"></script> <!-- 제이쿼리 -->
<title>옵션 신청 페이지</title>
<style>
	#bfHide, #dnHide, #spHide { width:20px; height:20px; float:right }
	input[readonly] {border:none; background-color:#f9f9ff; width:95px; text-align:center}
	input[name="REZ_CHECKIN"], input[name="REZ_CHECKOUT"], input[name="ROOM_ID"] {float:left}
	input[name='bfTotal'], input[name='dnTotal'], input[name='spTotal'], #total {text-align:right;}
	.option {position:relative; right:40px}
	
	*{color:black}
	
	select {
	  box-sizing: border-box;
	  padding: 2px;
	  border-radius: 6px;
	}
	option {
	  padding: 4px;
	}
</style>
<script>
$(function(){
	// 모든 input태그 readonly
	$("input").attr("readonly", true);
	
	
	// 옵션 예약 날짜
	var checkInArr = "${rez.REZ_CHECKIN}".split('-');
	var checkIn = new Date(checkInArr[0], checkInArr[1]-1, checkInArr[2]);
	var checkOutArr = "${rez.REZ_CHECKOUT}".split('-');
	var checkOut = new Date(checkOutArr[0], checkOutArr[1]-1, checkOutArr[2]);
	console.log("체크인 날짜 : " + checkIn.toLocaleString());
	console.log("체크아웃 날짜 : " + checkOut.toLocaleString());
	console.log("숙박일수 : ${nights} 박");
	
	var ableDate;
	// 1. 조식 가능 날짜 => 체크인 날짜+1 ~ 체크아웃 날짜
	for(var i = 1; i <= ${nights}; i++) {
		checkIn.setDate(checkIn.getDate() + 1); 
		ableDate = checkIn.getFullYear() + "-" + (checkIn.getMonth()+1) + "-" + checkIn.getDate();
		console.log("조식 날짜 => " + ableDate);
		$("#bfDate" + i).val(ableDate);
	}
	
	// 2. 디너 가능 날짜 => 체크인 날짜 ~ 체크아웃 날짜-1
	checkInArr = "${rez.REZ_CHECKIN}".split('-');
	checkIn = new Date(checkInArr[0], checkInArr[1]-1, checkInArr[2]);
	for(var i = 0; i < ${nights}; i++) {
		ableDate = checkIn.getFullYear() + "-" + (checkIn.getMonth()+1) + "-" + checkIn.getDate();
		console.log("디너 날짜 => " + ableDate);
		$("#dnDate" + (i+1)).val(ableDate);
		checkIn.setDate(checkIn.getDate() + 1);
	}
	
	// 3. 수영장 가능 날짜 => 체크인 날짜 ~ 체크아웃 날짜
	checkInArr = "${rez.REZ_CHECKIN}".split('-');
	checkIn = new Date(checkInArr[0], checkInArr[1]-1, checkInArr[2]);
	for(var i = 0; i <= ${nights}; i++) {
		ableDate = checkIn.getFullYear() + "-" + (checkIn.getMonth()+1) + "-" + checkIn.getDate();
		console.log("수영장 날짜 => " + ableDate);
		$("#spDate" + (i+1)).val(ableDate);
		checkIn.setDate(checkIn.getDate() + 1);
	}
	
	
	// 각 옵션 금액
	var total = 0;  // 옵션 선택 총금액
	var commaTotal; // 옵션 선택 총금액 세자리 콤마
	// 1. 조식
	var bfTotal = 0;  // 조식 선택 총금액
	var bfCommaTotal; // 조식 선택 총금액 세자리 콤마
	$("body").on('change', '#bfTable > tbody > tr > td > select' , function(){
		var beforePeople = $(this).parent().find('input').val(); // 기존 선택 인원
		var people = $(this).eq(0).val(); // 바꾼 선택 인원
		var price = $(this).parent().parent().find('td:nth-child(2)').find('input').val(); // 선택한 옵션 금액
		console.log( "기존 선택 인원 : " + beforePeople );
		console.log( "바뀐 선택 인원 : " + people );
		
		if( beforePeople < people ) { // 바뀐 선택 인원이 기존 선택 인원보다 크면 조식 선택 총금액에 차액 증가
			bfTotal += price * (people - beforePeople);
		} else { // 바뀐 선택 인원이 기존 선택 인원보다 작으면 조식 선택 총금액에 차액 감소
			bfTotal -= price * (beforePeople - people);
		}
		bfCommaTotal = bfTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','); // 조식 선택 총금액 세자리 콤마 처리
		$("#bfTotal").val(bfCommaTotal);
		
		total =  bfTotal + dnTotal + spTotal;
		commaTotal = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','); // 옵션 선택 총금액 세자리 콤마 처리
		$("#total").val(commaTotal);
		
		$(this).parent().find('input').val(people); // 바꾼 선택 인원이 기존 선택 인원이 된다
	})
	
	// 2. 디너
	var dnTotal = 0;  // 디너 선택 총금액
	var dnCommaTotal; // 디너 선택 총금액 세자리 콤마
	$("body").on('change', '#dnTable > tbody > tr > td > select' , function(){
		var beforePeople = $(this).parent().find('input').val();
		var people = $(this).eq(0).val();
		var price = $(this).parent().parent().find('td:nth-child(2)').find('input').val();
		console.log( "기존 선택 인원 : " + beforePeople );
		console.log( "바뀐 선택 인원 : " + people );
		
		if( beforePeople < people ) { // 바뀐 선택 인원이 기존 선택 인원보다 크면 디너 선택 총금액에 차액 증가
			dnTotal += price * (people - beforePeople);
		} else { // 바뀐 선택 인원이 기존 선택 인원보다 작으면 디너 선택 총금액에 차액 감소
			dnTotal -= price * (beforePeople - people);
		}
		dnCommaTotal = dnTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','); // 디너 선택 총금액 세자리 콤마 처리
		$("#dnTotal").val(dnCommaTotal);
		$(this).parent().find('input').val(people);
		
		total =  bfTotal + dnTotal + spTotal;
		commaTotal = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');  
		$("#total").val(commaTotal); 
	})
	
	// 3. 수영장
	var spTotal = 0;  // 수영장 선택 총금액
	var spCommaTotal; // 수영장 선택 총금액 세자리 콤마
	$("body").on('change', '#spTable > tbody > tr > td > select' , function(){
		var beforePeople = $(this).parent().find('input').val();
		var people = $(this).eq(0).val();
		var price = $(this).parent().parent().find('td:nth-child(2)').find('input').val();
		console.log( "기존 선택 인원 : " + beforePeople );
		console.log( "바뀐 선택 인원 : " + people );
		
		if( beforePeople < people ) { // 바뀐 선택 인원이 기존 선택 인원보다 크면 수영장 선택 총금액에 차액 증가
			spTotal += price * (people - beforePeople);
		} else { // 바뀐 선택 인원이 기존 선택 인원보다 작으면 수영장 선택 총금액에 차액 감소
			spTotal -= price * (beforePeople - people);
		}
		spCommaTotal = spTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','); // 수영장 선택 총금액 세자리 콤마 처리
		$("#spTotal").val(spCommaTotal);
		$(this).parent().find('input').val(people);
		
		total =  bfTotal + dnTotal + spTotal;
		commaTotal = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		$("#total").val(commaTotal);
	})
	
	
	
	// 옵션 테이블 접기
	// 1. 조식
	$("#bfHide").click(function(){
		var tbody = $("#bfTable > tbody");
		if(tbody.is(":visible")){
			tbody.hide();
		} else {
			tbody.show();
		}
	})
	// 2. 디너
	$("#dnHide").click(function(){
		var tbody = $("#dnTable > tbody");
		if(tbody.is(":visible")){
			tbody.hide();
		} else {
			tbody.show();
		}
	})
	// 3. 수영장
	$("#spHide").click(function(){
		var tbody = $("#spTable > tbody");
		if(tbody.is(":visible")){
			tbody.hide();
		} else {
			tbody.show();
		}
	})
}) // ready end
</script>
</head>
<body>
    <!--================Breadcrumb Area =================-->
    <section class="breadcrumb_area blog_banner_two">
        <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
        <div class="container">
            <div class="page-cover text-center">
                <h2 class="page-cover-tittle f_48">옵션 신청 페이지</h2>
            </div>
        </div>
    </section>
    <!--================Breadcrumb Area =================-->
    
    <!--================Blog Area =================-->
    <section class="blog_area single-post-area">
        <div class="container">
        	<form action="${pageContext.request.contextPath}/option/optionCheck" method="post">
	            <div class="row">
	                <div class="col-lg-8 posts-list">
	                    <div class="single-post row">
	                       <div class="col-lg-12">
	                       		<!-- 1. 조식 -->
	                       		<table class="table" id="bfTable">
	                       			<thead>
		                       			<tr style="background-color:#f5f2a3">
		                       				<td colspan="2">
		                       					<span style="font-size:20pt; font-weight:bold">Breakfast</span>
		                       				</td>
		                       				<td>
		                       					<img src="${pageContext.request.contextPath}/resources/project_image/option/underarrow.png" id="bfHide">
		                       				</td>
		                       			</tr>
	                       			</thead>
	                       			<c:forEach var="nights" begin="1" end="${nights}">
	                       				<c:forEach var="option" items="${optionList}">
			                       			<c:if test="${option.OPTION_NAME eq '조식'}">
				                       			<tr>
				                       				<td colspan="3">
				                       					<h5>이용날짜 (
				                       						<input type="text" name="bfDate${nights}" id="bfDate${nights}" onfocus="this.blur();">)
				                       					</h5>
				                       				</td>
				                       			</tr>
				                       			<tr>
				                       				<td>성인(청소년 포함)</td>
				                       				<td>
				                       					요금
				                       					<span><fmt:formatNumber value="${option.OPTION_DEFAULT_PRICE}" pattern="#,###"/>원</span>
				                       					<input type="hidden" id="bfDefaultPrice" value="${option.OPTION_DEFAULT_PRICE}">
				                       				</td>
				                       				<td>
				                       					<span>인원수</span>
					                       				<select class="wide" name="bfAdult${nights}" id="bfAdult${nights}"> 
					                       					<c:forEach var="a" begin="0" end="${rez.REZ_ADULT}">
						                       					<option value="${a}">${a}</option>
					                       					</c:forEach>
					                       				</select>
					                       				<input type="hidden"> <!-- 기존 선택한 인원수 임시 저장 -->
				                       				</td>                       				
				                       			</tr>
				                       			<tr>
				                       				<td>아동</td>
				                       				<td>
				                       					요금
				                       					<span><fmt:formatNumber value="${option.OPTION_CHILD_PRICE}" pattern="#,###"/>원</span>
				                       					<input type="hidden" id="bfChildPrice" value="${option.OPTION_CHILD_PRICE}">
				                       				</td>
				                       				<td>
				                       					<span>인원수</span>
				                       					<select class="wide" name="bfChild${nights}">
					                       					<c:forEach var="c" begin="0" end="${rez.REZ_CHILD}">
						                       					<option value="${c}">${c}</option>
					                       					</c:forEach>
					                       				</select>
					                       				<input type="hidden"> <!-- 기존 선택한 인원수 임시 저장 -->
				                       				</td>
				                       			</tr>
			                       			</c:if>
		                       			</c:forEach>
	                       			</c:forEach>
	                       		</table>
		                       		
	                       		<!-- 2. 디너 -->
	                       		<table class="table" id="dnTable">
	                       			<thead>
		                       			<tr style="background-color:#f5f2a3">
		                       				<td colspan="2">
		                       					<span style="font-size:20pt; font-weight:bold">Dinner</span>
		                       				</td>
		                       				<td>
		                       					<img src="${pageContext.request.contextPath}/resources/project_image/option/underarrow.png" id="dnHide">
		                       				</td>
		                       			</tr>
	                       			</thead>
	                       			<c:forEach var="nights" begin="1" end="${nights}">
	                       				<c:forEach var="option" items="${optionList}">
			                       			<c:if test="${option.OPTION_NAME eq '디너'}">
				                       			<tr>
				                       				<td colspan="3">
				                       					<h5>이용날짜 (
				                       						<input type="text" name="dnDate${nights}" id="dnDate${nights}" onfocus="this.blur();">)
				                       					</h5>
				                       				</td>
				                       			</tr>
				                       			<tr>
				                       				<td>성인(청소년 포함)</td>
				                       				<td>
				                       					요금
				                       					<span><fmt:formatNumber value="${option.OPTION_DEFAULT_PRICE}" pattern="#,###"/>원</span>
				                       					<input type="hidden" id="dnDefaultPrice" value="${option.OPTION_DEFAULT_PRICE}">
				                       				<td>
				                       					<span>인원수</span>
					                       				<select class="wide" name="dnAdult${nights}">
					                       					<c:forEach var="a" begin="0" end="${rez.REZ_ADULT}">
						                       					<option value="${a}">${a}</option>
					                       					</c:forEach>
					                       				</select>
					                       				<input type="hidden"> <!-- 기존 선택한 인원수 임시 저장 -->
				                       				</td>                       				
				                       			</tr>
				                       			<tr>
				                       				<td>아동</td>
				                       				<td>
				                       					요금 
				                       					<span><fmt:formatNumber value="${option.OPTION_CHILD_PRICE}" pattern="#,###"/>원</span>
				                       					<input type="hidden" id="dnChildPrice" value="${option.OPTION_CHILD_PRICE}">
				                       				</td>
				                       				<td>
				                       					<span>인원수</span>
				                       					<select class="wide" name="dnChild${nights}">
					                       					<c:forEach var="c" begin="0" end="${rez.REZ_CHILD}">
						                       					<option value="${c}">${c}</option>
					                       					</c:forEach>
					                       				</select>
					                       				<input type="hidden"> <!-- 기존 선택한 인원수 임시 저장 -->
				                       				</td>
				                       			</tr>
				                       		</c:if>
		                       			</c:forEach>
	                       			</c:forEach>
	                       		</table>
	                       		
	                       		<!-- 3. 수영장 -->
	                       		<table class="table" id="spTable">
	                       			<thead>
		                       			<tr style="background-color:#f5f2a3">
		                       				<td colspan="2">
		                       					<span style="font-size:20pt; font-weight:bold">Swimming Pool</span>
		                       				</td>
		                       				<td>
		                       					<img src="${pageContext.request.contextPath}/resources/project_image/option/underarrow.png" id="spHide">
		                       				</td>
		                       			</tr>
	                       			</thead>
	                       			<c:forEach var="nights" begin="1" end="${nights + 1}">
	                       				<c:forEach var="option" items="${optionList}">
			                       			<c:if test="${option.OPTION_NAME eq '수영장'}">
				                       			<tr>
				                       				<td colspan="3">
				                       					<h5>이용날짜 (
				                       						<input type="text" name="spDate${nights}" id="spDate${nights}" onfocus="this.blur();">)
				                       					</h5>
				                       				</td>
				                       			</tr>
				                       			<tr>
				                       				<td>성인(청소년 포함)</td>
				                       				<td>
				                       					요금
				                       					<span><fmt:formatNumber value="${option.OPTION_DEFAULT_PRICE}" pattern="#,###"/>원</span>
				                       					<input type="hidden" id="spDefaultPrice" value="${option.OPTION_DEFAULT_PRICE}">
				                       				</td>
				                       				<td>
				                       					<span>인원수</span>
					                       				<select class="wide" name="spAdult${nights}">
					                       					<c:forEach var="a" begin="0" end="${rez.REZ_ADULT}">
						                       					<option value="${a}">${a}</option>
					                       					</c:forEach>
					                       				</select>
					                       				<input type="hidden"> <!-- 기존 선택한 인원수 임시 저장 -->
				                       				</td>                       				
				                       			</tr>
				                       			<tr>
				                       				<td>아동</td>
				                       				<td>
				                       					요금
				                       					<span><fmt:formatNumber value="${option.OPTION_CHILD_PRICE}" pattern="#,###"/>원</span>
				                       					<input type="hidden" id="spChildPrice" value="${option.OPTION_CHILD_PRICE}">
				                       				</td>
				                       				<td>
				                       					<span>인원수</span>
				                       					<select class="wide" name="spChild${nights}">
					                       					<c:forEach var="c" begin="0" end="${rez.REZ_CHILD}">
						                       					<option value="${c}">${c}</option>
					                       					</c:forEach>
					                       				</select>
					                       				<input type="hidden"> <!-- 기존 선택한 인원수 임시 저장 -->
				                       				</td>
				                       			</tr>
		                       				</c:if>
		                       			</c:forEach>
	                       			</c:forEach>
	                       		</table>
	                        </div>
	                    </div>
	                </div>
	                
	                
	                <!-- 네비게이션 -->
	                <div class="col-lg-4">
	                    <div class="blog_right_sidebar">
	                        <aside class="single_sidebar_widget author_widget">
	                        	<table class="table" id="rezInfo" style="text-align:left">
	                        		<tr>
	                        			<th colspan="2">01&nbsp;&nbsp;&nbsp;&nbsp;일정 및 객실</th>
	                        		</tr>
	                        		<tr>	
	                        			<th style="width:30%">체크인</th>
	                        			<td><input type="text" name="REZ_CHECKIN" value="${rez.REZ_CHECKIN}" onfocus="this.blur();" style="text-align:left"></td>
	                        		</tr>
	                        		<tr>	
	                        			<th>체크아웃</th>
	                        			<td><input type="text" name="REZ_CHECKOUT" value="${rez.REZ_CHECKOUT}" onfocus="this.blur();" style="text-align:left"></td>
	                        		</tr>
	                        		<tr>	
	                        			<th>숙박일수</th>
	                        			<td><input type="text" name="nights" value="${nights}" onfocus="this.blur();" style="width:15px">박</td>
	                        		</tr>
	                        		<tr>	
	                        			<th>객실명</th>
	                        			<td>
	                        				<c:out value="${room.ROOM_TYPE}"/>
	                        				<input type="hidden" name="ROOM_ID" value="${rez.ROOM_ID}">
	                        			</td>
	                        		</tr>
	                        		<tr>	
	                        			<th>인원수</th>
	                        			<td>
	                        				성인:&nbsp;<input type="text" name="REZ_ADULT" value="${rez.REZ_ADULT}" onfocus="this.blur();" style="width:15px">명&nbsp;&nbsp;/&nbsp;&nbsp;
	                        				아동:&nbsp;<input type="text" name="REZ_CHILD" value="${rez.REZ_CHILD}" onfocus="this.blur();" style="width:15px">명
	                        			</td>
	                        		</tr>
	                        	</table>
	                        	<div class="br"></div>
	                        </aside>
	                        <aside class="single_sidebar_widget author_widget">
	                        	<table class="table" id="optionInfo" style="text-align:left">
	                        		<tr>
	                        			<th colspan="2">02&nbsp;&nbsp;&nbsp;&nbsp;옵션 선택</th>
	                        		</tr>
	                        		<tr>	
	                        			<th style="width:30%">조식</th>
	                        			<td>
	                        				<span class="option"><input type="text" name="bfTotal" id="bfTotal" value="0" onfocus="this.blur();">원</span>
	                        			</td> 
	                        		</tr>
	                        		<tr>	
	                        			<th>디너</th>
	                        			<td>
	                        				<span class="option"><input type="text" name="dnTotal" id="dnTotal" value="0" onfocus="this.blur();">원</span>
	                        			</td>
	                        		</tr>
	                        		<tr>	
	                        			<th>수영장</th>
	                        			<td>
	                        				<span class="option"><input type="text" name="spTotal" id="spTotal" value="0" onfocus="this.blur();">원</span>
	                        			</td> 
	                        		</tr>
	                        		<tr>	
	                        			<th>총 금액</th>
	                        			<td>
	                        				<span class="option"><input type="text" id="total" value="0" onfocus="this.blur();">원</span>
	                        			</td>
	                        		</tr>
	                        	</table>
	                        </aside>
	                        <aside class="single_sidebar_widget author_widget">
	                        	<button type="submit" class="genric-btn primary circle">계속</button>
	                        </aside>
	                    </div>
	                </div>
	            </div>
	            
	            <!-- 403에러 방지 토큰 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            </form>
        </div>
    </section>
    <!--================Blog Area =================-->

<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/>     
</body>
</html>