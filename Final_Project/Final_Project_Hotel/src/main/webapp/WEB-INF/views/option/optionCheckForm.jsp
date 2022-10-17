<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- core 라이브러리 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> <!-- fmt 라이브러리 -->
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %> <!-- functions 라이브러리 -->
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->
<script src="http://code.jquery.com/jquery-latest.js"></script> <!-- 제이쿼리 -->
<title>예약정보 확인</title>
<style>
	input[readonly] {border:none; width:80px}
	
	.imgDiv {overflow:hidden; border-radius:10%;} /* 이미지 태그 감싸고 있는 div */
	.img {width:290px; height:194px; transition:all 0.2s linear;}
	.img:hover {transform: scale(1.4);}
</style>
<script>
$(function(){
	// 모든 input태그 readonly
	$("input").attr("readonly", true);
	
	
	// 총금액 계산	
	var price = $("#checkTable > tbody > tr > td > span").text().replace(/,/g, '').split('원');
	var total = 0;
	for(var i = 0; i<price.length-1; i++  ) {
		console.log( (i+1) + ":" +  parseInt(price[i]));
		total += parseInt(price[i]);
	}
	console.log( total );
	$("input[name='total']").val(total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
	
	
}) // ready end
</script>
</head>
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
    
    <!--================Contact Area =================-->
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
            							<a class="btn theme_btn button_hover" href="../room/roomDetail?num=${rez.ROOM_ID}" target='_blank'><strong>객실 상세보기</strong></a>
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
	                            		<c:forEach var="dl" items="${dateList}">
		                            		<tr>
		                            			<th><input type="text" name="dateList" value="${dl}" onfocus="this.blur();"></th>
		                            			<th>객실명:
		                            				<input type="text" value="${room.ROOM_TYPE}" onfocus="this.blur();">
		                            				<input type="hidden" name="ROOM_ID" value="${rez.ROOM_ID}">
		                            			</th>
		                            			<td>
		                            				 <!-- 체크아웃 날짜는 숙박하지 않으므로 객실 금액이 부과되지 않는다 (0원) -->
		                            				<c:if test="${dl != rez.REZ_CHECKOUT}">
		                            					<span><fmt:formatNumber value="${room.ROOM_PRICE}" pattern="#,###"/>원</span>
		                            				</c:if>
		                            				<c:if test="${dl == rez.REZ_CHECKOUT}">
		                            					<span><fmt:formatNumber value="0" pattern="#,###"/>원</span>
		                            				</c:if>
		                            			</td>
		                            		</tr>
	                            			<c:forEach var="optDate" items="${optList}"> <!-- List -->
	                            				<c:forEach var="date" items="${optDate}"> <!-- Map -->
	                            					<c:forEach var="d" items="${date.key}"> <!-- Map -->
	                            						<tr>
			                            					<c:if test="${d eq dl}">
			                            						<c:choose>
			                            							<c:when test="${fn:contains(date.value, 'bf')}">
			                            								<th>[조식]</th>
					                            						<td>
					                            							<c:forEach var="people" items="${date.value}"> <!-- Map -->
				                            									<c:if test="${fn:contains(people.key, 'Adult')}">
				                            										<c:set var="bfAdult" value="${people.value}"/>
				                            										성인:&nbsp;<input type="text" name="bfAdult" value="${bfAdult}" onfocus="this.blur();" style="width:15px">명&nbsp;&nbsp;&nbsp;&nbsp;
						                            							</c:if>
						                            							<c:if test="${fn:contains(people.key, 'Child')}">
						                            								<c:set var="bfChild" value="${people.value}"/>
						                            								아동:&nbsp;<input type="text" name="bfChild" value="${bfChild}" onfocus="this.blur();" style="width:15px">명
						                            							</c:if>
						                            						</c:forEach>
					                            						</td>
					                            						<td>
					                            							<c:forEach var="oi" items="${optionInfo}">
						                            							<c:if test="${oi.OPTION_NAME eq '조식'}">
						                            								<span><fmt:formatNumber value="${bfAdult * oi.OPTION_DEFAULT_PRICE + bfChild * oi.OPTION_CHILD_PRICE}" pattern="#,###"/>원</span>
						                            							</c:if>
					                            							</c:forEach>
					                            						</td>
					                            					</c:when>
			                            							<c:when test="${fn:contains(date.value, 'dn')}">
			                            								<th>[디너]</th>
			                            								<td>
				                            								<c:forEach var="people" items="${date.value}"> <!-- Map -->
				                            									<c:if test="${fn:contains(people.key, 'Adult')}">
						                            								<c:set var="dnAdult" value="${people.value}"/>
						                            								성인:&nbsp;<input type="text" name="dnAdult" value="${dnAdult}" onfocus="this.blur();" style="width:15px">명&nbsp;&nbsp;&nbsp;&nbsp;
						                            							</c:if>
						                            							<c:if test="${fn:contains(people.key, 'Child')}">
						                            								<c:set var="dnChild" value="${people.value}"/>
						                            								아동:&nbsp;<input type="text" name="dnChild" value="${dnChild}" onfocus="this.blur();" style="width:15px">명
						                            							</c:if>	
						                            						</c:forEach>
					                            						</td>
					                            						<td>
					                            							<c:forEach var="oi" items="${optionInfo}">
						                            							<c:if test="${oi.OPTION_NAME eq '디너'}">
						                            								<span><fmt:formatNumber value="${dnAdult * oi.OPTION_DEFAULT_PRICE + dnChild * oi.OPTION_CHILD_PRICE}" pattern="#,###"/>원</span>
						                            							</c:if>
					                            							</c:forEach>
					                            						</td>
					                            					</c:when>
					                            					<c:when test="${fn:contains(date.value, 'sp')}">
			                            								<th>[수영장]</th>
					                            						<td>
					                            							<c:forEach var="people" items="${date.value}"> <!-- Map -->
				                            									<c:if test="${fn:contains(people.key, 'Adult')}">
						                            								<c:set var="spAdult" value="${people.value}"/>
						                            								성인:&nbsp;<input type="text" name="spAdult" value="${spAdult}" onfocus="this.blur();" style="width:15px">명&nbsp;&nbsp;&nbsp;&nbsp;
						                            							</c:if>
						                            							<c:if test="${fn:contains(people.key, 'Child')}">
						                            								<c:set var="spChild" value="${people.value}"/>
						                            								아동:&nbsp;<input type="text" name="spChild" value="${spChild}" onfocus="this.blur();" style="width:15px">명
						                            							</c:if>	
						                            						</c:forEach>
					                            						</td>
					                            						<td>
					                            							<c:forEach var="oi" items="${optionInfo}">
						                            							<c:if test="${oi.OPTION_NAME eq '수영장'}">
						                            								<span><fmt:formatNumber value="${spAdult * oi.OPTION_DEFAULT_PRICE + spChild * oi.OPTION_CHILD_PRICE}" pattern="#,###"/>원</span>
						                            							</c:if>
					                            							</c:forEach>
					                            						</td>
					                            					</c:when>	
					                            				</c:choose>
					                            			</c:if>
				                            			</tr>
			                            			</c:forEach>
		                            			</c:forEach>
	                            			</c:forEach>
	                           			</c:forEach>
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
	                    <button type="submit" value="submit" class="genric-btn primary circle">회원예약</button>
	                </div>
	            </div>
	            
	            <!-- 403에러 방지 토큰 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				
				<!-- 예약 시 필요한 값들을 hidden 으로 넘긴다 -->
				<input type="hidden" name="nights" value="${nights}"> <!-- 숙박일수 -->
				<input type="hidden" name="REZ_CHECKIN" value="${rez.REZ_CHECKIN}"> <!-- 체크인 날짜 -->
				<input type="hidden" name="REZ_CHECKOUT" value="${rez.REZ_CHECKOUT}"> <!-- 체크아웃 날짜 -->
				<input type="hidden" name="REZ_ADULT" value="${rez.REZ_ADULT}"> <!-- 성인 수 -->
	            <input type="hidden" name="REZ_CHILD" value="${rez.REZ_CHILD}"> <!-- 아동 수 -->
	            <input type="hidden" name="bfTotal" value="${optionPrice.bfTotal}"> <!-- 조식 총금액 -->
	            <input type="hidden" name="dnTotal" value="${optionPrice.dnTotal}"> <!-- 디너 총금액 -->
	            <input type="hidden" name="spTotal" value="${optionPrice.spTotal}"> <!-- 수영장 총금액 -->
	        </form>    
        </div>
    </section>
    <!--================Contact Area =================-->
    
    
<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/>      
</body>
</html>