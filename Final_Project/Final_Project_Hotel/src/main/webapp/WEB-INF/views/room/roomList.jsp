<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=0.9,minimum-scale=0.9,maximum-scale=0.9,user-scalable=no">
<meta name="HandheldFriendly" content="true">
<meta name="format-detection" content="telephone=no">
<title>객실예약</title>

<jsp:include page="../main/header.jsp"/>

<!-- 필수 JS/CSS { -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<link type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<!-- } -->

<!-- Web Fonts 	================================================== -->
<link
	href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i&subset=cyrillic,cyrillic-ext,greek,greek-ext,latin-ext,vietnamese"
	rel="stylesheet">


<!-- Basic Page Needs	================================================== -->

<!-- Web Fonts 	================================================== -->

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
<link rel="apple-touch-icon" sizes="72x72"
	href="apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="114x114"
	href="apple-touch-icon-114x114.png">


<script>
$(function(){
	$("#searchBtn").click(function(){
      // 하나라도 선택 안 되어 있으면 조회 못하게 막기
      if($("#sdate").val() == "" || $("#edate").val() == ""){
	  	  alert("날짜를 선택해주세요.");
	  	  return false;
	  }else if($("#adult").val() == "성인" || $("#child").val() == "소아"){
		  alert("인원을 선택해주세요.");
		  return false;
	  }else if($("#adult").val() == "0"){
		  alert("인원을 선택해주세요. (성인 1명 이상)");
		  return false;
	  }else if($("input[name='check']:checked").length==0){
		  alert("객실 타입을 체크해주세요.");
		  return false;
	  }
	


	  // 1. 인원 수 산정
      var adults = $("select[name='adults']").val(); // 선택된 성인 수
      var children = $("select[name='children']").val(); // 선택된 아동 수
      var people = parseInt(adults) + parseInt(children); // 총 인원 수
      console.log("선택된 성인 수: " + adults);
      console.log("선택된 아동 수: " + children);
      console.log("총 인원 수: " + people);
      
      // 2. 선택한 객실 유형
      var chk_arr = $(".checkbox");
        var roomTypes = ""; // 선택된 객실 유형 담을 변수
        for( var i=0; i<chk_arr.length; i++ ) {
            if( chk_arr[i].checked == true && chk_arr[i].value != 'on') {
                roomTypes += chk_arr[i].value + ",";
            }
        }
      console.log("선택된 객실 유형: " +roomTypes);

      
	  var token = $("meta[name='_csrf']").attr("content");
	  var header = $("meta[name='_csrf_header']").attr("content");
	  $.ajax({
			type : "POST",
			url: "roomList_select",
			data: {"people": people,
	               "roomTypes": roomTypes,
	               "checkIn":$("#sdate").val(), "checkOut":$("#edate").val()},	
			beforeSend : function(xhr) { 
	        	xhr.setRequestHeader(header, token); // 403 Access deny 오류 처리(Spring Security CSRF)		
	        },
	        success: function(data){
  	        	console.log("===넘어온 list 확인===");
  	        	console.log(data.rezRoomList2);
  	        	
	        	$(".roomListParent").remove();
	        	var people = data.people;
	        	var output = '<form class="row roomListParent" action="reservationCheck" method="POST">';
	        	$(data.roomList).each(function(index, item) {
	        		output +='<div class="col-lg-6 roomList">'
	        			    + '		<div class="room-box background-grey">'
	        		        + '			<div class="room-name">' + item.ROOM_TYPE + '</div>';
	        		
	        		// 이미지
	        		output += "<img src='" + item.ROOM_IMG + "'";
	        		if(data.rezRoomList2.length != 0) {
	        			$(data.rezRoomList2).each(function(i) {
		        			if(item.ROOM_ID == data.rezRoomList2[i] || item.ROOM_MAX < people){
		        				output += " style='opacity:0.3;'";
		        			}
		  	        	})
	        		} else {
	        			if(item.ROOM_MAX < people){
	        				output += " style='opacity:0.3;'";
	        			}
	        		}
        			output += '>';
        			$(data.rezRoomList2).each(function(i) {
	        			if(item.ROOM_ID == data.rezRoomList2[i]){
	        				output += "<span style='background-color:darkgray; color:white; position:absolute; top:100px; left:110px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px; border-radius:10px; font-weight:bold;'>마감</span>";
	        			}
	  	        	})
	        		        
	        		output += '<div class="room-box-in">'
	        		        + '		<h5>' + item.ROOM_TYPE + '</h5>'
	        		        + '		<p class="mt-3">' + item.ROOM_DETAIL + '</p>';
	        		output += "<input type='hidden' value='" + item.ROOM_ID + "'>";
	        		
	        		// 버튼
	        		output += '<button type="button" class="mt-1 btn btn-warning"';
	        		if(data.rezRoomList2.length != 0) {
	        			$(data.rezRoomList2).each(function(i) {
		        			if(item.ROOM_ID == data.rezRoomList2[i] || item.ROOM_MAX < people){
		        				output += ' style="background-color:lightgray" disabled';
		        			} 
		  	        	})
	        		} else {
	        			if(item.ROOM_MAX < people){
	        				output += ' style="background-color:lightgray" disabled';
	        			}
	        		}
	  	        	output += '>'
          				    + '		book from ' + item.ROOM_PRICE + '원'
       		                + '</button>';
	  	        	
	        		output += '		<div class="room-icons mt-4 pt-4">'
	        		 	    + '			<img src="${pageContext.request.contextPath}/resources/room/img/5.svg"><img src="${pageContext.request.contextPath}/resources/room/img/6.svg">'
							+ '			<img src="${pageContext.request.contextPath}/resources/room/img/3.svg"><a href="roomDetail?num='+ item.ROOM_ID +'">객실정보</a>'
							+ '		</div>';
					output += "</div></div></div>";		
	        	}) // each end
	        	output += '<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">'
	        	output += "</form>";
	        	$(".roomListParentP").append(output);
	        } // success end
		}) // ajax end
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
	             <h6>Inspiring Senses & Touching place </h6>
	             <h2>Relax Your Mind</h2>
	         </div>
	     </div>
	 </div>
  </section>
  
  	<div class="section padding-top-bottom z-bigger">
		<div class="section z-bigger">
			<div class="container">
				<div class="row">
					<!-- 객실리스트 -->
					<div class="col-lg-8 mt-4 mt-lg-0 roomListParentP">
						<!-- 객실 리스트 있을 때 -->
						<c:if test="${roomListCount > 0}">
							<form class="row roomListParent">
								<c:forEach var="roomList" items="${roomList}">
									<div class="col-lg-6 roomList">
										<div class="room-box background-grey">
											<div class="room-name">${roomList.ROOM_TYPE}</div>
											<img src="${roomList.ROOM_IMG}">
											<div class="room-box-in">
												<h5>${roomList.ROOM_TYPE}</h5>
												<p class="mt-3">${roomList.ROOM_DETAIL}</p>
										
													<button type="submit" class="mt-1 btn btn-warning basicbutton">
														book from <fmt:formatNumber value="${roomList.ROOM_PRICE}" pattern="#,###"/>원
													</button>
												
												<div class="room-icons mt-4 pt-4">
													<img src="${pageContext.request.contextPath}/resources/room/img/5.svg"><img src="${pageContext.request.contextPath}/resources/room/img/6.svg">
													<img src="${pageContext.request.contextPath}/resources/room/img/2.svg"><a href="roomDetail?num=${roomList.ROOM_ID}">객실정보</a>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</form>
						</c:if>
						<!-- 객실 리스트 없을 때 -->
						<c:if test="${roomListCount == 0}">
							<h1>예약 가능한 객실이 없습니다.</h1>
						</c:if>
					</div>
					
					
					<!-- 날짜선택 네비 -->
					<div class="col-lg-4 order-first order-lg-last">
						<div class="section background-dark p-4">
							<div class="row">
								<div class="col-12">
									<div class="input-daterange input-group" id="flight-datepicker">
										<div class="row">
											<div class="col-12">
												<div class="form-item">
											 	    <h6 class="color-white mg-6">날짜 선택</h6><br>
											    	<div class="checkin_checkout">
											        	<input type="text" name="d1" value="" id="sdate" class="datepicker inp" placeholder="체크인" readonly > 
											        
														<input type="text" name="d2" value="" id="edate" class="datepicker inp" placeholder="체크아웃" readonly >
														<input type="hidden" name="hnum" value="">
													</div>
									     		</div>
									     	</div>
										</div>
									</div>
								</div>
								<div class="col-12">
									<div class="row">
										<div class="col-12 pt-4">
											<h6 class="color-white mg-6">인원</h6><br>
											<select name="adults" id="adult" class="wide">
												<option data-display="성인">성인</option>
												<option value="0">0</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
											</select>
										</div>
										<div class="col-12 pt-4">
											<select name="children" id="child" class="wide">
												<option data-display="소아">소아</option>
												<option value="0">0</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
											</select>
										</div>
									</div>
								</div>
								<!-- <div class="col-12 pt-5">
									<h6 class="color-white mb-3">Max night price:</h6>
									<div class="selecteurPrix">
										<div class="range-slider">
											<input class="input-range" type="range" value="100" min="1"
												max="500">
											<div class="valeurPrix">
												<span class="range-value"></span>
											</div>
										</div>
									</div>
								</div> -->
								<div class="col-12 col-md-6 col-lg-12 pt-5">
									<h6 class="color-white mb-3">객실 타입</h6>
									<ul class="list">
										<li class="list__item"><label class="label--checkbox">
											<input type="checkbox" id="checkall" class="checkbox" name="checkall" checked>전체</label></li>
										<li class="list__item"><label class="label--checkbox">
											<input type="checkbox" id="single" class="checkbox" name="check" value="싱글룸">싱글룸</label></li>
										<li class="list__item"><label class="label--checkbox">
											<input type="checkbox" id="double" class="checkbox" name="check" value="더블룸">더블룸</label></li>
										<li class="list__item"><label class="label--checkbox">
											<input type="checkbox" id="twin" class="checkbox" name="check" value="트리플룸">트리플룸</label></li>
										<li class="list__item"><label class="label--checkbox">
											<input type="checkbox" id="family" class="checkbox" name="check" value="패밀리룸">패밀리룸</label></li>
									</ul>
								</div> 
							</div>
							<br>
							<button type="submit" class="btn float-center submit_next booking-button" id="searchBtn">조회</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="scroll-to-top"></div>
            
        
        

     
<jsp:include page="../main/footer.jsp"/> 


<!-- JAVASCRIPT    ================================================== -->
<script>
<!-- 체크박스 옵션 -->

if($('#checkall').prop('checked')){
	$('.checkbox').prop('checked', true);
}else{
	$('.checkbox').prop('checked', false);
}


$('#checkall').click(function(){
	if($('#checkall').prop('checked')){
		$('.checkbox').prop('checked', true);
	}else{
		$('.checkbox').prop('checked', false);
	}
});

$('.checkbox').click(function(){
	if($('input[name="check"]:checked').length==4){
		$('#checkall').prop('checked',true);
	}else{
		$('#checkall').prop('checked',false);
	}
});

	
<!-- 캘린더 옵션  -->
//예약 가능한 방이 0개일 때 배열로 가져와 날짜 비활성화
//var disabledDays = ["2022-10-20", "2022-10-21" , "2022-10-22"];
//console.log(disabledDays.length);

//datepicker 기본 설정
     
	$.datepicker.setDefaults({
      closeText: "닫기",
      prevText: "이전달",
      nextText: "다음달",
      currentText: "오늘",
      monthNames: ["1월", "2월", "3월", "4월", "5월", "6월",
        "7월", "8월", "9월", "10월", "11월", "12월"
      ],
      monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월",
        "7월", "8월", "9월", "10월", "11월", "12월"
      ],
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
        
        /* for(i=0; i<disabledDays.length;i++){
        	if($.inArray(year + '-' +(month+1) + '-' +
        	dates,disabledDays) != -1) {
        		return [false];
        	}
        } */
        return [true];
 
     };  
     
     
     //흩어져있는 데이터 하나의 form으로 묶어서 데이터 넘기기위한 함수
     //mt-1 btn btn-warning
     $("body").on('click' , '.mt-1.btn.btn-warning' ,  function(){
    	 
    	 let form = document.createElement('form');
    	 form.action = '../reservation/reservationCheck';
    	 form.method = 'POST';

    	 form.innerHTML = '<input name="room_id" value=' + $(this).parent().find("input[type='hidden']").val() + '>'
    	 form.innerHTML += '<input name="checkin" value=' + $('#sdate').val() + '>'
    	 form.innerHTML += '<input name="checkout" value=' + $('#edate').val() + '>'
    	 form.innerHTML += '<input name="adult" value=' + $('#adult').val() + '>'
    	 form.innerHTML += '<input name="child" value=' + $('#child').val() + '>'
    	 form.innerHTML += '<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">'
    	 

    	 // 폼을 제출하려면 반드시 폼이 문서 안에 있어야 합니다.
    	 document.body.append(form);
    	 form.submit();
     })
     
     
    
    	 $('.basicbutton').click(function(){
    		 alert('예약 가능한 날짜와 객실을 먼저 조회해주세요.');
    		 return false;
    	 });
     
     
    
    
	</script>
	<!-- JAVASCRIPT    ================================================== -->
	
	<!-- End Document================================================== -->

</body>
</html>