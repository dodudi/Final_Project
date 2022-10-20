<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="no-js" lang="en">
<head>

<jsp:include page="../main/header.jsp"/>

<!-- 필수 JS/CSS { -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<link type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<!-- } -->

<!-- Basic Page Needs	================================================== -->
<title>객실 상세 페이지</title>
<meta name="description" content="Professional Creative Template" />
<meta name="author" content="IG Design">
<meta name="keywords"
	content="ig design, website, design, html5, css3, jquery, creative, clean, animated, portfolio, blog, one-page, multi-page, corporate, business," />
<!-- Mobile Specific Metas	================================================== -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="theme-color" content="#212121" />
<meta name="msapplication-navbutton-color" content="#212121" />
<meta name="apple-mobile-web-app-status-bar-style" content="#212121" />
<!-- Web Fonts 	================================================== -->
<link
	href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i&subset=cyrillic,cyrillic-ext,greek,greek-ext,latin-ext,vietnamese"
	rel="stylesheet">
<!-- CSS	================================================== -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/room/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/room/css/font-awesome.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/room/css/ionicons.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/room/css/datepicker.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/room/css/jquery.fancybox.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/room/css/owl.carousel.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/room/css/owl.transitions.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/room/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/room/css/colors/color.css" />

<!-- datepicker css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project_css/room/datepicker.css" />

<!-- Favicons	================================================== -->
<link rel="icon" type="image/png" href="favicon.png">
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="114x114" href="apple-touch-icon-114x114.png">
<style>
	#flight-datepicker > div.ui-datepicker-inline.ui-datepicker.ui-widget.ui-widget-content.ui-helper-clearfix.ui-corner-all{display:none !important}
</style>
<script>
$(function(){
	// 체크인 날짜
	$("#sdate").change(function(){
		$("input[name='REZ_CHECKIN']").val($(this).val())
	})
	
	// 체크아웃 날짜
	$("#edate").change(function(){
		$("input[name='REZ_CHECKOUT']").val($(this).val())
	})
	
	
	// 인원수
	var people;
	var adult;
	var child;
	// 성인
	$("select[name='adult']").change(function(){
		if(isNaN($(this).val())){
			adult = 0;
		} else {
			adult = parseInt($(this).val());
		}
		if(isNaN($("select[name='child']").val())){
			child = 0;
		} else {
			child = parseInt($("select[name='child']").val());
		}
		
		people = adult + child;
		console.log("성인: " + adult);
		console.log("아동: " + child);
		console.log("=>인원수: " + people);
		console.log("===============");
		
		if(people > ${room.ROOM_MAX}) {
			alert("${room.ROOM_TYPE}의 최대 인원수는 ${room.ROOM_MAX}명입니다.");
			$("body > div > div > div > div > div.col-lg-4.order-first.order-lg-last > div > div > div:nth-child(2) > div > div:nth-child(1) > div > span").text(1);
		}  else {
			$("input[name='REZ_ADULT']").val($(this).val());
		}
	})
	
	// 아동
	$("select[name='child']").change(function(){
		if(isNaN($("select[name='adult']").val())){
			adult = 0;
		} else {
			adult = parseInt($("select[name='adult']").val());
		}
		if(isNaN($(this).val())){
			child = 0;
		} else {
			child = parseInt($(this).val());
		}
		
		people = adult + child;
		console.log("성인: " + adult);
		console.log("아동: " + child);
		console.log("=>인원수: " + people);
		console.log("===============");
		
		if(people > ${room.ROOM_MAX}) {
			alert("${room.ROOM_TYPE}의 최대 인원수는 ${room.ROOM_MAX}명입니다.");
			$("body > div > div > div > div > div.col-lg-4.order-first.order-lg-last > div > div > div:nth-child(2) > div > div:nth-child(2) > div > span").text(0);
		}  else {
			$("input[name='REZ_CHILD']").val($(this).val());
		}
	})
	
	
	// 예약하기 버튼
	$("#rezBtn").click(function(){
		if($("#sdate").val() == '' || $("#edate").val() == ''){
			alert("날짜를 선택해주세요.");
			return false;
		}
		
		if(parseInt($("input[name='adult']").val()) == 0){
			alert("성인을 1명 이상 선택해주세요.");
			return false;
		}
		
		if(isNaN($("select[name='adult']").val()) || isNaN($("select[name='child']").val())){
			alert("인원을 선택해주세요.");
			return false;
		}
	})
	
}) // ready end
</script>
</head>
<body>
	<section class="banner_area">
	 <div class="booking_table d_flex align-items-center">
	     <div class="overlay bg-parallax" data-stellar-ratio="0.9" data-stellar-vertical-offset="0"
	         data-background=""></div>
	     <div class="container">
	         <div class="banner_content text-center">
	             <h2>객실 상세 정보</h2>
	         </div>
	     </div>
	 </div>
  </section>
	
	
	
	<div class="section padding-top-bottom z-bigger">
		<div class="section z-bigger">
			<div class="container">
				<div class="row">
					<div class="col-lg-8 mt-4 mt-lg-0">
						<div class="section">
							<div class="customNavigation rooms-sinc-1-2">
								<a class="prev-rooms-sync-1"></a><a class="next-rooms-sync-1"></a>
							</div>
							<div id="rooms-sync1" class="owl-carousel">
								<div class="item">
									<img src="${room.ROOM_IMG}" alt="">
								</div>
								<c:if test="${room.ROOM_TYPE=='싱글룸'}">
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/singleroom2.jpg" alt="">
								</div>
								</c:if>
								<c:if test="${room.ROOM_TYPE=='더블룸'}">
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/doubleroom2.jpg" alt="">
								</div>
								</c:if>
								<c:if test="${room.ROOM_TYPE=='트리플룸'}">
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/tripleroom2.jpg" alt="">
								</div>
								</c:if>
								<c:if test="${room.ROOM_TYPE=='패밀리룸'}">
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/familyroom2.jpg" alt="">
								</div>
								</c:if>
								
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/gallery/4.jpg" alt="">
								</div>
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/gallery/8.jpg" alt="">
								</div>
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/gallery/9.jpg" alt="">
								</div>
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/rest-1.jpg" alt="">
								</div>
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/rest-2.jpg" alt="">
								</div>
							</div>
						</div>
						<div class="section">
							<div id="rooms-sync2" class="owl-carousel">
								<div class="item">
									<img src="${room.ROOM_IMG}" alt="">
								</div>
								<c:if test="${room.ROOM_TYPE=='싱글룸'}">
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/singleroom2.jpg" alt="">
								</div>
								</c:if>
								<c:if test="${room.ROOM_TYPE=='더블룸'}">
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/doubleroom2.jpg" alt="">
								</div>
								</c:if>
								<c:if test="${room.ROOM_TYPE=='트리플룸'}">
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/tripleroom2.jpg" alt="">
								</div>
								</c:if>
								<c:if test="${room.ROOM_TYPE=='패밀리룸'}">
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/familyroom2.jpg" alt="">
								</div>
								</c:if>
								
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/gallery/4-s.jpg" alt="">
								</div>
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/gallery/8-s.jpg" alt="">
								</div>
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/gallery/9-s.jpg" alt="">
								</div>
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/rest-1.jpg" alt="">
								</div>
								<div class="item">
									<img src="${pageContext.request.contextPath}/resources/room/img/rest-2.jpg" alt="">
								</div>
							</div>
						</div>
						<div class="section pt-5">
							<h5>${room.ROOM_TYPE}</h5>
							<p class="mt-3">"${room.ROOM_DETAIL}"</p>
							<p class="mt-3">비즈니스 고객, 관광객을 포함한 다양한 고객층이 만족할 수 있는 맞춤형 공간을 제공합니다.
							 각 객실에서 도심의 환상적인 야경과 자연 모두를 감상,
							 최신 시설과 고객 서비스 중심의 시스템,
							 최상의 평온함을 유지하는 객실 구성을 자랑하는 HOTEL ASIA만의 편안한 안식처를 경험하세요.
							
							
							</p>
						</div>
						<div class="section pt-4">
							<div class="row">
								<div class="col-12">
									<p class="mb-3"><strong class="color-black" style="font-size:17px">어메니티</strong></p>
								</div>
								<div class="col-lg-6">
									<p>
										<strong class="color-grey2">&bull;&nbsp;평면LCD TV</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;데이터포트</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;블루투스 스피커</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;개별 냉난방시스템</strong>
									</p>
									
								</div>
								<div class="col-lg-6">
									<p>
										<strong class="color-grey2">&bull;&nbsp;전화기</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;의자 및 램프</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;멀티콘센트</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;알람시계</strong>
									</p>
									
								</div>
								<div class="col-lg-6">
									<p>
										<strong class="color-grey2">&bull;&nbsp;옷장</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;휴대폰 충전기(안드로이드/아이폰)</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;헤어 드라이기</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;샤워부스,비데,치약&칫솔 등 무료제공</strong>
									</p>
									
								</div>
								<div class="col-lg-6">
									<p>
										<strong class="color-grey2">&bull;&nbsp;모닝콜 서비스</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;24시간 컨시어지 서비스(안드로이드/아이폰)</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;초고속 무료 인터넷</strong>
									</p>
									<p>
										<strong class="color-grey2">&bull;&nbsp;요청 시 대여 서비스(다리미판, 변압기, 선풍기)</strong>
									</p>
									
								</div>
								
							</div>
						</div>
						<div class="section pt-4">
							<p class="mb-3"><strong class="color-black" style="font-size:17px">추가정보</strong></p>
							<p class="mt-3">※ 모든 고객의 편안한 휴식을 위하여 전 객실 금연입니다.</p>
							<p class="mt-3">※ 객실에서 흡연 시(IQOS담배, 전자담배 포함) 10만원의 과태료가 부과됩니다.</p>
							<p class="mt-3">※ 객실내 애완동물의 출입 및 동반 투숙이 불가 합니다.</p>
							<p class="mt-3">※ 화재 예방을 위하여 객실 내에서는 촛불, 가스, 유류 등의 인화성 물질과 난방/취사를 위한 화기 및 전열기구에 대한 일체 사용을 엄격히 금지합니다.</p>
							<p class="mt-3">※ 고객님 편의를 위해 생수 1병을 추가로 무료 제공합니다.</p>
							<p class="mt-3">※ 그 외 궁금한 사항은 '문의사항'을 이용해 주세요.</p>
						</div>
					</div>
					<div class="col-lg-4 order-first order-lg-last">
						<div class="section background-dark p-4">
							<div class="row">
								<div class="col-12">
									<div class="input-daterange input-group" id="flight-datepicker">
										<div class="row">
											<div class="col-12">
												<div class="form-item">
													<form>
														<h6 class="color-white mg-6">날짜 선택</h6><br>
												    	<div class="checkin_checkout">
												        	<input type="text" name="d1" id="sdate" class="datepicker inp" placeholder="체크인" readonly> 
															<input type="text" name="d2" id="edate" class="datepicker inp" placeholder="체크아웃" readonly>
														</div>
									     			</form>
									     		</div>
									     	</div>
										</div>
									</div>
								</div>
								<div class="col-12">
									<div class="row">
										<div class="col-12 pt-4">
											<h6 class="color-white mg-6">가능인원</h6><br>
											<select name="adult" class="wide">
												<option data-display="성인">성인</option>
												<c:forEach var="adult" begin="0" end="${room.ROOM_MAX}" step="1">
													<option value="${adult}">${adult}</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-12 pt-4">
											<select name="child" class="wide">
												<option data-display="아동">아동</option>
												<c:forEach var="child" begin="0" end="${room.ROOM_MAX - 1}" step="1">
													<option value="${child}">${child}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
								<div class="col-12 col-md-6 col-lg-12 pt-5">
									<h6 class="color-white mb-3">객실 타입</h6>
									<ul class="list">
										<li class="list__item"><label class="label--checkbox">
										<input type="checkbox" id="checkall" class="checkbox" name="checkall" checked>${room.ROOM_TYPE}</label></li>
									</ul>
								</div>
								<div class="col-12 col-md-6 col-lg-12 pt-5">
									<h6 class="color-white mg-6">이용안내</h6><br>
						    		<div class="use_info">
						    			<form action="../reservation/reservationCheck" method="post">
						    				<input type="hidden" name="room_id" value="${room.ROOM_ID}">
						    				<input type="hidden" name="REZ_CHECKIN">
						    				<input type="hidden" name="REZ_CHECKOUT">
						    				<input type="hidden" name="REZ_ADULT">
						    				<input type="hidden" name="REZ_CHILD">
						        			<button type="submit" class="btn float-center submit_next booking-button" id="rezBtn">예약하기</button><br>
						        			<a class="btn float-center submit_next booking-button" href="../question/list">문의하기</a> <!-- 문의 게시판으로 이동 경로 바꾸기 -->
						        			
						        			<!-- 403에러 방지 토큰 -->
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	

	
		
	
	
	<jsp:include page="../main/footer.jsp"/> 
	
	<!-- JAVASCRIPT    ================================================== -->
	<script src="${pageContext.request.contextPath}/resources/room/js/plugins.js"></script>
	<script src="${pageContext.request.contextPath}/resources/room/js/custom.js"></script>
	<!-- End Document================================================== -->
<script>
	<!-- 캘린더 옵션  -->
	// 기예약 날짜
	let returnDate = "${rezDateList}";
	console.log("기예약날짜: " + returnDate);
	let rezDateList = returnDate.split(",");
	
     
	$.datepicker.setDefaults({
      closeText: "닫기",
      prevText: "이전달",
      nextText: "다음달",
      currentText: "오늘",
      monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
      monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
      dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
      dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
      dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
      weekHeader: "주",
      dateFormat: "yy-mm-dd", // 날짜형태 예)yy년 m월 d일
      firstDay: 0,
      isRTL: false,
      showMonthAfterYear: true,
      yearSuffix: "년",
      beforeShowDay: disableSomeDay
    })
	
    //시작 날짜를 오늘부터 선택 가능
    $('.datepicker').datepicker({
    	minDate:0
    });
    
    //시작일은 종료일 이후의 날짜 선택 불가, 종료일은 시작일 이전 날짜 선택 불가
    $('#sdate').datepicker();
    $('#sdate').datepicker("option", "maxDate", $("#edate").val());
    $('#sdate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#edate").datepicker( "option", "minDate", selectedDate );
    });   
   
    //예약된 날짜 비활성화 함수
     function disableSomeDay(date){
        var month = date.getMonth()
        var dates = date.getDate();
        var year = date.getFullYear();
        
        for(i=0; i<rezDateList.length;i++){
        	if($.inArray(year + '-' +(month+1) + '-' + dates,rezDateList) != -1) {
        		return [false];
        	}
        }
        return [true];
     };  
     

	</script>
	<!-- JAVASCRIPT    ================================================== -->
	<!-- End Document================================================== -->
</body>
</html>