<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- core 라이브러리 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> <!-- fmt 라이브러리 -->
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../main/header.jsp"/> <!-- 헤더 -->
<script src="http://code.jquery.com/jquery-latest.js"></script> <!-- 제이쿼리 -->

<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script> <!-- 아임포트 API -->
<script>
$(function(){
	
	// 휴대폰번호 변경 여부 확인
	var phoneAuthChk = true;
	var originalPhone = "${member.MEM_PHONE}"; // 기존 휴대폰번호
	var input_phone = ''; //휴대폰 인증번호 검사에 사용된 휴대폰번호를 저장할 변수
	console.log(originalPhone);
	
	$("input[name='MEM_PHONE']").keyup(function(){
		if(originalPhone == $(this).val() || input_phone == $(this).val()) {
			$(this).parent().find('button').css({'color':'gray', 'cursor':'default'}).attr('disabled', true);
			$("input[name='phoneAuth']").attr('readonly', true);
			$("input[name='phoneAuthBtn']").attr('disabled', true);
			console.log("기존 번호랑 같음 or 이미 인증한 번호");
			phoneAuthChk = true;
			console.log("phoneAuthChk = " + phoneAuthChk);
		} else {
			$(this).parent().find('button').css({'color':'orange', 'cursor':'pointer'}).attr('disabled', false);
			phoneAuthChk = false;
			console.log("phoneAuthChk = " + phoneAuthChk);
		}
	})	
	
	
	// 휴대폰번호 인증
	$("#phoneChkBtn").click(function(){
		// 403 방지
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		input_phone = $.trim($("input[name='MEM_PHONE']").val()); // 변경된 휴대폰번호
		if( isNaN(input_phone) ) {
			alert('휴대폰번호를 숫자로만 입력해주세요.');
			$(this).parent().find('input[name="MEM_PHONE"]').focus();
			console.log("phoneAuthChk = " + phoneAuthChk);
			return false;
		} else {
			$.ajax({
				type : "POST",
				url: "../member/phoneCheck",
				data: { "phone": input_phone },
				beforeSend : function(xhr) { 
		        	xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리(Spring Security CSRF)		
		        },
				success: function(rdata) { // 휴대폰번호 있으면 1, 없으면 0, 뭔가 이상하면 -1
					if (rdata == 1) { // DB에 해당 휴대폰번호가 있는 경우
						alert("이미 등록된 휴대폰번호입니다. 다른 번호를 입력하거나 기존 번호를 사용하세요.");
						$(this).parent().find('input[name="MEM_PHONE"]').focus();
						console.log("phoneAuthChk = " + phoneAuthChk);
						return false;
					} else { // DB에 해당 phone이 없는 경우
						$.ajax({
							type : "POST",
							url: "../member/phoneAuth",
							data: { "phone": input_phone },
							beforeSend : function(xhr) { 
					        	xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리(Spring Security CSRF)		
					        },
							success : function(rdata){
								alert("인증번호가 발송되었습니다. => " + rdata);
								$("input[name='phoneAuthNum']").val(rdata); // 인증번호 저장되는 곳
								$("input[name='phoneAuth']").attr('type', 'text').attr('readonly', false); // 인증번호 입력란
								$("input[name='phoneAuthBtn']").attr('type', 'button').attr('disabled', false); // 인증번호 입력 후 일치여부 확인 버튼
								console.log("phoneAuthChk = " + phoneAuthChk);
							}
						}) // 휴대폰 번호 인증 ajax end
					} 
				}
			}) // 휴대폰 번호 중복 검사 $.ajax end
		}
	}) // 인증하기 버튼 클릭 end
	
	// 인증번호 확인 여부 검사
	$("input[name='phoneAuthBtn']").click(function(){
		if( $("input[name='phoneAuth']").val() != $("input[name='phoneAuthNum']").val() ) {
			alert('인증번호가 일치하지 않습니다.');
			phoneAuthChk = false;
			console.log("phoneAuthChk = " + phoneAuthChk);
			return false;
		} else {
			alert('휴대폰번호 인증에 성공하셨습니다');
			$("input[name='phoneAuth']").attr('readonly', true);
			$("input[name='phoneAuthBtn']").attr('disabled', true);
			phoneAuthChk = true;
			console.log("phoneAuthChk = " + phoneAuthChk);
		}
	})
	
	
	/*
	// 결제
	function payment() {
		var totalPrice = $("input[name='totalPrice']").val();
		var url = "${pageContext.request.contextPath}/payment/payment?totalPrice="+totalPrice;  
		
		window.open(url, "payment",
					"left=350px, top=100px, width=1000px, height=600px");
	}*/
	
	
	
	
	
	// 폼 전송
	$("form").submit(function(){
		// 휴대폰 중복검사 확인 
		var submit_phone_value = $.trim($("input[name='MEM_PHONE']").val()); input_phone
		if (phoneAuthChk == false ) {
			alert("변경된 휴대폰번호를 인증해주세요.");
			return false;
		}
		// 취소정책 확인 - 체크박스 체크 여부
		if ( !$("input[type='checkbox']").is(":checked")) {
			alert("취소 정책을 확인해주세요.");
			return false;
		}

		//payment();
		
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
                <h2 class="page-cover-tittle f_48">고객정보 확인 (필수)</h2>
            </div>
        </div>
    </section>
    <!--================Breadcrumb Area =================-->
    
    <!--================Blog Area =================-->
    <section class="blog_area single-post-area">
        <div class="container">
        	<form action="${pageContext.request.contextPath}/reservation/reservationRoomOption" method="post"> <!-- /reservation/reservationRoomOption --> <%--  action="${pageContext.request.contextPath}/payment/payment" --%>
	            <div class="row">
	                <div class="col-lg-8 posts-list">
	                    <div class="single-post row">
	                       <div class="col-lg-12">
	                       		<h3>고객정보 (필수)</h3>
	                       		<table class="table">
	                       			<tr>
	                       				<th>성명(한글)</th><td>${member.MEM_NAME}</td>
	                       			</tr>
	                       			<tr>
	                       				<th>연락처</th>
	                       				<td>
	                       					<input type="text" name="MEM_PHONE" value="${member.MEM_PHONE}">
	                       					<input type="hidden" name="phoneAuth" maxlength="6"> <!-- 인증번호 입력하는 곳 -->
	                       					<input type="hidden" name="phoneAuthBtn" value="인증번호 확인"> <!-- 인증번호 입력 후 일치하는지 확인 버튼 -->
	                       					<button type="button" id="phoneChkBtn" style="color:gray" disabled>인증하기</button>
	                       					<input type="hidden" name="phoneAuthNum"> <!-- 인증번호 저장되는 곳 -->
	                       				</td>
	                       			</tr>
	                       			<tr>
	                       				<th>이메일</th>
	                       				<td>${member.MEM_EMAIL}</td>
	                       			</tr>
	                       		</table>
	                       </div>
	                       <div class="col-lg-12" style="margin-top:40px">
	                       		<h3>취소 정책 (필수 확인)</h3>
	                       		<p class="cancel_stxt">예약취소 및 미입실(No Show)에 관한 위약금 규정에 관하여 <span class="pTxt">공정거래위 산하 소비자 보호원 기준에 따라 아래와 같이 위약금 부과 처리에 관해 안내</span> 하오니, 이용에 유의 하시기 바랍니다.</p>
					            <!-- 예약취소/환불 규정 참고: https://www.nesthotel.co.kr/privacy/cancellation_policy.asp -->
					            <div class="cancel">
									<table class="table">
										<colgroup>
											<col width="10%">
											<col width="45%">
											<col width="45%">
										</colgroup>
										<thead>
											<tr>
												<th></th>
												<th>성수기</th>
												<th>비수기</th>
											</tr>						
										</thead>
										<tbody>
											<tr>
												<th>기간</th>
												<td>
													<span class="bTxt">Ⅰ. 5월, 7월, 8월, 9월, 10월, 12월<br/>
													Ⅱ. 연중 모든 토요일<br/>
													Ⅲ. 연중 국, 공휴일 또는 대체 휴무일 하루 전날 <br/>
													Ⅳ. 연중 연휴시작 하루 전날부터 ~ 마지막 연휴 전날까지 <br/>
													V. 징검다리 연휴인 경우에 중간날짜에 있는 샌드위치 데이(평일과 일요일)의 경우도 모두 성수기에 해당</span>
												</td>
												<td>
													<span class="bTxt">Ⅰ. 1월, 2월, 3월, 4월, 6월, 11월 (일요일 ~ 금요일에 해당)<br/>
													Ⅱ. 연휴 마지막 날 (일요일 및 국, 공휴일과 대체 휴무일 포함)</span><br/>
													<span class="iTxt">※ 비수기 6개월 중 모든 토요일 및 국, 공휴일 또는 대체 휴무일 하루 전날, 연휴시작 하루 전날부터 마지막 연휴 전날까지는 모두 성수기에 해당됩니다.<br/>
													※ 샌드위치 데이와 징검다리 연휴인 경우의 중간 날짜가 평일이나 일요일이어도 모두 성수기에 해당됩니다.</span>
												</td>
											</tr>
											<tr>
												<th rowspan="2">위약금 규정</th>
												<td>
													<span class="bTxt2">사용 예정일(체크인 날짜) <strong>3일 전 15시 이후</strong> 예약취소 시<br/> - 하루 숙박 총 요금의 <strong>50%</strong> 부과</span><br/><br/>	
													<span class="bTxt2">사용 예정일(체크인 날짜) <strong>1일 전 15시 이후</strong> 예약취소 시<br/> - 하루 숙박 총 요금의 <strong>90%</strong> 부과</span><br/>
													(당일 숙박을 위한 당일예약 후, 예약 취소의 경우도 위약금 규정이 동일하게 적용됩니다.)<br/>
													<span class="bTxt2">* 사용 예정일(체크인 날짜) 3일 전 15시 이전 예약취소 시 무료취소 가능합니다.</span>
												</td>
												<td>
													<span class="bTxt2">사용 예정일(체크인 날짜) <strong>1일 전 15시 이후</strong> 예약취소 시<br/> - 하루 숙박 총 요금의 <strong>10%</strong> 부과	<br/></span><br/>
													<span class="bTxt2">사용 예정일(체크인 날짜) <strong>당일 15시 이후</strong> 예약취소 및 미입실(No Show)시<br/> - 하루 숙박 총 요금의 <strong>20%</strong> 부과</span><br/>
													(당일 숙박을 위한 당일예약 후, 예약 취소의 경우도 위약금 규정이 동일하게 적용됩니다)<br/>
													<span class="bTxt2">* 사용 예정일(체크인 날짜) 1일 전 15시 이전 예약취소 시 무료취소 가능합니다.</span>
												</td>
											</tr>					
										</tbody>
									</table>	
									<dl class="infoTxt">
										<dt>※ 조식의 경우 취소 및 환불은 체크인 전일 경우만 가능하며, 체크인 후에는 불가합니다.</dt>
										<dt>※ 총 요금이란?</dt>					
										<dd style="padding-left:10px;">예약 시 확정되었던 객실 총 요금이 기준입니다.</dd>
										<dd style="padding-left:10px;">1객실 2일 이상 예약 시,  2객실 이상 예약 시에도 위약금 규정에 따라 동일하게 처리됩니다.</dd>
									</dl>
									<div style="padding-bottom:30px; border-bottom:1px dotted #666;">
										<dl>
											<dt>※ 유의사항</dt>
											<dd style="padding-left:10px;">1. 신분증으로는 입금 환불 신청이 접수되지 않습니다.</dd>
											<dd style="padding-left:10px;">2. 예약 당일 취소 및 NO SHOW의 경우 위약금 규정에 따라 해당 금액 제외한 나머지 금액만 환불됩니다.</dd>
											<dd style="padding-left:10px;">3. 상기 일자는 당사, 카드사 상황 또는 금액에 따라 지연될 수 있습니다.</dd>
											<dd style="padding-left:10px; font-weight:bold;">4. 미성년자 (만 19세 미만)는 부모와 함께 동행하지 않는 경우 예약이 취소될 수 있습니다.</dd>
										</dl>
									</div>
									<input type="checkbox">예약취소 및 미입실 관련 위약금 규정’과 취소 정책을 확인하고 동의합니다.
									<button type="submit" class="btn">결제하기</button>
					            </div>
	                       </div>
	                    </div>
	                </div>
	                
	                
	                <!-- 네비게이션 -->
	                <div class="col-lg-4">
	                    <div class="blog_right_sidebar">
	                        <aside class="single_sidebar_widget author_widget">
	                        	<table class="table" id="rezInfo">
	                        		<tr>
	                        			<th colspan="2">01 일정 및 객실</th>
	                        		</tr>
	                        		<tr>	
	                        			<th>체크인</th><td><input type="text" name="REZ_CHECKIN" value="${rez.REZ_CHECKIN}"></td>
	                        		</tr>
	                        		<tr>	
	                        			<th>체크아웃</th><td><input type="text" name="REZ_CHECKOUT" value="${rez.REZ_CHECKOUT}"></td>
	                        		</tr>
	                        		<tr>	
	                        			<th>숙박일수</th><td><input type="text" name="nights" value="${nights}">박</td> 
	                        		</tr>
	                        		<tr>	
	                        			<th>객실명 (객실id)</th><td><input type="text" name="ROOM_ID" value="${rez.ROOM_ID}"></td>
	                        		</tr>
	                        		<tr>	
	                        			<th>인원수 </th>
	                        			<td>
	                        				성인: <input type="text" name="REZ_ADULT" value="${rez.REZ_ADULT}">
	                        				아동: <input type="text" name="REZ_CHILD" value="${rez.REZ_CHILD}">
	                        			</td>
	                        		</tr>
	                        		<tr>	
	                        			<th>총금액</th><td><input type="text" value="${room.ROOM_PRICE * nights}"></td>
	                        		</tr>
	                        	</table>
	                        	<div class="br"></div>
	                        </aside>
	                        <aside class="single_sidebar_widget author_widget">
	                        	<table class="table" id="optionInfo">
	                        		<tr>
	                        			<th colspan="2">02 옵션 선택</th>
	                        		</tr>
	                        		<tr>	
	                        			<th>조식</th>
	                        			<td>
	                        				<input type="text" name="bfTotal" value="${optionPrice.bfTotal}">원
	                        			</td> 
	                        		</tr>
	                        		<tr>	
	                        			<th>디너</th>
	                        			<td>
	                        				<input type="text" name="dnTotal" value="${optionPrice.dnTotal}">원
	                        			</td>
	                        		</tr>
	                        		<tr>	
	                        			<th>수영장</th>
	                        			<td>
	                        				<input type="text" name="spTotal" value="${optionPrice.spTotal}">원
	                        			</td> 
	                        		</tr>
	                        		<tr>	
	                        			<th>총 금액</th>
	                        			<td>
	                        				<input type="text" value="${optionPrice.bfTotal + optionPrice.dnTotal + optionPrice.spTotal}">원
	                        			</td>
	                        		</tr>
	                        	</table>
	                        	<div class="br"></div>
	                        </aside>
	                        <aside class="single_sidebar_widget author_widget">
	                        	<table class="table">
	                        		<tr>
	                        			<th colspan="2">03 할인금액</th>
	                        		</tr>
	                        		<tr>	
	                        			<th>쿠폰</th>
	                        			<td>	
	                        				<a href="#" class="genric-btn primary circle">보유쿠폰</a>
	                        			</td> 
	                        		</tr>
	                        		<tr>	
	                        			<th>마일리지</th>
	                        			<td>
	                        				0 / 0point
	                        			</td>
	                        		</tr>
	                        	</table>
	                        	<div class="br"></div>
	                        </aside>
	                        <aside class="single_sidebar_widget author_widget">
	                        	<table class="table">
	                        		<tr>
	                        			<th colspan="2">04 최종 결제 금액</th>
	                        		</tr>
	                        		<tr>	
	                        			<th><input type="text" name="totalPrice" value="${totalPrice}">원</th>
	                        		</tr>
	                        	</table>
	                        </aside>
	                    </div>
	                </div>
	            </div>
	            
	            <!-- 403에러 방지 토큰 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				
				<!-- 예약에 넘길 데이터 -->
				<input type="hidden" name="dateList" value="${dateList}"> <!-- 체크인 날짜 ~ 체크아웃 날짜 -->
				<input type="hidden" name="bfAdult" value="${bfAdult}">   <!-- 조식 성인 -->
				<input type="hidden" name="bfChild" value="${bfChild}">   <!-- 조식 아동 -->
				<input type="hidden" name="dnAdult" value="${dnAdult}">   <!-- 디너 성인 -->
				<input type="hidden" name="dnChild" value="${dnChild}">   <!-- 디너 아동 -->
				<input type="hidden" name="spAdult" value="${spAdult}">   <!-- 수영장 성인 -->
				<input type="hidden" name="spChild" value="${spChild}">   <!-- 수영장 아동 -->
            </form>
        </div>
    </section>
    <!--================Blog Area =================-->

<!-- 푸터 -->        
<jsp:include page="../main/footer.jsp"/>     
</body>
</html>