<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<!-- Favicons	================================================== -->
<link rel="icon" type="image/png" href="favicon.png">
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72"
	href="apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="114x114"
	href="apple-touch-icon-114x114.png">

<style>
/* datepicker css 적용 */

.ui-widget-header {
border: 0px solid #dddddd;
background: #fff;
}

.ui-datepicker-calendar>thead>tr>th {
font-size: 14px !important;
}

.ui-datepicker .ui-datepicker-header {
position: relative;
padding: 10px 0;
}

.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover, html .ui-button.ui-state-disabled:active {
border: 0px solid #c5c5c5;
background-color: transparent;
font-weight: normal;
color: #454545;
text-align: center;
}

.ui-datepicker .ui-datepicker-title {
margin: 0 0em;
line-height: 16px;
text-align: center;
font-size: 14px;
padding: 0px;
font-weight: bold;
}

.ui-datepicker {
display: none;
background-color: #fff;
border-radius: 4px;
margin-top: 10px;
margin-left: 0px;
margin-right: 0px;
padding: 20px;
padding-bottom: 10px;
width: 300px;
box-shadow: 10px 10px 40px rgba(0,0,0,0.1);
}
    
.ui-widget.ui-widget-content {
    border: 1px solid #eee;
}

#datepicker:focus>.ui-datepicker {
display: block;
}

.ui-datepicker-prev,
.ui-datepicker-next {
cursor: pointer;
}

.ui-datepicker-next {
float: right;
}

.ui-state-disabled {
cursor: auto;
color: hsla(0, 0%, 80%, 1);
}

.ui-datepicker-title {
text-align: center;
padding: 10px;
font-weight: 100;
font-size: 20px;
}

.ui-datepicker-calendar {
width: 100%;
}

.ui-datepicker-calendar>thead>tr>th {
padding: 5px;
font-size: 20px;
font-weight: 400;
}


.ui-datepicker-calendar>tbody>tr>td>a {
color: #000;
font-size: 12px !important;
font-weight: bold !important;
text-decoration: none;
    
}


.ui-datepicker-calendar>tbody>tr>.ui-state-disabled:hover {
cursor: auto;
background-color: #fff;
}
    
.ui-datepicker-calendar>tbody>tr>td {
    border-radius: 100%;
    width: 44px;
    height: 30px;
    cursor: pointer;
    padding: 5px;
    font-weight: 100;
    text-align: center;
    font-size: 12px;
}
    
.ui-datepicker-calendar>tbody>tr>td:hover {
    background-color: transparent;
    opacity: 0.6;
}

.ui-state-hover,
.ui-widget-content .ui-state-hover,
.ui-widget-header .ui-state-hover,
.ui-state-focus,
.ui-widget-content .ui-state-focus,
.ui-widget-header .ui-state-focus,
.ui-button:hover,
.ui-button:focus {
border: 0px solid #cccccc;
background-color: transparent;
font-weight: normal;
color: #2b2b2b;
}

.ui-widget-header .ui-icon {
background-image: url('../../../../resources/static/project_image/datepicker/btns.png');
}
.ui-icon-circle-triangle-e {
background-position: -20px 0px;
background-size: 36px;
}

.ui-icon-circle-triangle-w {
background-position: -0px -0px;
background-size: 36px;
}
    
.ui-datepicker-calendar>tbody>tr>td:first-child a{
color: red !important;
}
    
.ui-datepicker-calendar>tbody>tr>td:last-child a{
color: #0099ff !important;
}
    
.ui-datepicker-calendar>thead>tr>th:first-child {
    color: red !important;
}
    
.ui-datepicker-calendar>thead>tr>th:last-child {
    color: #0099ff !important;
}

.ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight {
    border: 0px;
    background: #f1f1f1;
    border-radius: 50%;
    padding-top: 10px;
    padding-bottom: 10px;
}


.inp {padding:10px 10px; background-color:#f1f1f1; border-radius:4px; border:0px;}
.inp:focus {outline:none; background-color:#eee;}
</style>

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
					<div class="col-lg-8 mt-4 mt-lg-0">
						<div class="row">
							<div class="col-lg-6">
								<div class="room-box background-grey">
									<div class="room-name">single room</div>
									<img src="${pageContext.request.contextPath}/resources/room/img/room3.jpg" alt="">
									<div class="room-box-in">
										<h5 class="">pool suite</h5>
										<p class="mt-3">Sed ut perspiciatis unde omnis, totam rem
											aperiam, eaque ipsa quae ab illo inventore veritatis et.</p>
										<a href="rooms-gallery.html"><button type="submit" class="mt-1 btn btn-warning">book
											from 130$</button></a>
										<div class="room-icons mt-4 pt-4">
											<img src="${pageContext.request.contextPath}/resources/room/img/5.svg" alt=""><img src="${pageContext.request.contextPath}/resources/room/img/2.svg" alt=""><img
												src="${pageContext.request.contextPath}/resources/room/img/3.svg" alt=""><a href="rooms-gallery.html">full
												info</a>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-6 mt-4 mt-lg-0">
								<div class="room-box background-grey">
									<div class="room-name">single room</div>
									<img src="${pageContext.request.contextPath}/resources/room/img/room4.jpg" alt="">
									<div class="room-box-in">
										<h5 class="">small room</h5>
										<p class="mt-3">Sed ut perspiciatis unde omnis, totam rem
											aperiam, eaque ipsa quae ab illo inventore veritatis et.</p>
										<a class="mt-1 btn btn-warning" href="rooms-gallery.html">book
											from 80$</a>
										<div class="room-icons mt-4 pt-4">
											<img src="${pageContext.request.contextPath}/resources/room/img/4.svg" alt=""><img src="${pageContext.request.contextPath}/resources/room/img/2.svg" alt=""><img
												src="${pageContext.request.contextPath}/resources/room/img/6.svg" alt=""><a href="rooms-gallery.html">full
												info</a>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-6 mt-4"
								data-scroll-reveal="enter bottom move 50px over 0.7s after 0.2s">
								<div class="room-box background-grey">
									<div class="room-name">doubleroom</div>
									<img src="${pageContext.request.contextPath}/resources/room/img/room5.jpg" alt="">
									<div class="room-box-in">
										<h5 class="">Apartment</h5>
										<p class="mt-3">Sed ut perspiciatis unde omnis, totam rem
											aperiam, eaque ipsa quae ab illo inventore veritatis et.</p>
										<a class="mt-1 btn btn-warning" href="rooms-gallery.html">book
											from 110$</a>
										<div class="room-icons mt-4 pt-4">
											<img src="${pageContext.request.contextPath}/resources/room/img/5.svg" alt=""><img src="${pageContext.request.contextPath}/resources/room/img/2.svg" alt=""><img
												src="${pageContext.request.contextPath}/resources/room/img/3.svg" alt=""><a href="rooms-gallery.html">full
												info</a>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-6 mt-4"
								data-scroll-reveal="enter bottom move 50px over 0.7s after 0.4s">
								<div class="room-box background-grey">
									<div class="room-name">double room</div>
									<img src="${pageContext.request.contextPath}/resources/room/img/room6.jpg" alt="">
									<div class="room-box-in">
										<h5 class="">big Apartment</h5>
										<p class="mt-3">Sed ut perspiciatis unde omnis, totam rem
											aperiam, eaque ipsa quae ab illo inventore veritatis et.</p>
										<a class="mt-1 btn btn-warning" href="rooms-gallery.html">book
											from 160$</a>
										<div class="room-icons mt-4 pt-4">
											<img src="${pageContext.request.contextPath}/resources/room/img/5.svg" alt=""><img src="${pageContext.request.contextPath}/resources/room/img/2.svg" alt=""><img
												src="${pageContext.request.contextPath}/resources/room/img/3.svg" alt=""><a href="rooms-gallery.html">full
												info</a>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-6 mt-4"
								data-scroll-reveal="enter bottom move 50px over 0.7s after 0.2s">
								<div class="room-box background-grey">
									<div class="room-name">suite andrea</div>
									<img src="${pageContext.request.contextPath}/resources/room/img/room5.jpg" alt="">
									<div class="room-box-in">
										<h5 class="">Apartment</h5>
										<p class="mt-3">Sed ut perspiciatis unde omnis, totam rem
											aperiam, eaque ipsa quae ab illo inventore veritatis et.</p>
										<a class="mt-1 btn btn-warning" href="rooms-gallery.html">book
											from 110$</a>
										<div class="room-icons mt-4 pt-4">
											<img src="${pageContext.request.contextPath}/resources/room/img/5.svg" alt=""><img src="${pageContext.request.contextPath}/resources/room/img/2.svg" alt=""><img
												src="${pageContext.request.contextPath}/resources/room/img/3.svg" alt=""><a href="rooms-gallery.html">full
												info</a>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-6 mt-4"
								data-scroll-reveal="enter bottom move 50px over 0.7s after 0.4s">
								<div class="room-box background-grey">
									<div class="room-name">suite diana</div>
									<img src="${pageContext.request.contextPath}/resources/room/img/room6.jpg" alt="">
									<div class="room-box-in">
										<h5 class="">big Apartment</h5>
										<p class="mt-3">Sed ut perspiciatis unde omnis, totam rem
											aperiam, eaque ipsa quae ab illo inventore veritatis et.</p>
										<a class="mt-1 btn btn-warning" href="rooms-gallery.html">book
											from 160$</a>
										<div class="room-icons mt-4 pt-4">
											<img src="${pageContext.request.contextPath}/resources/room/img/5.svg" alt=""><img src="${pageContext.request.contextPath}/resources/room/img/2.svg" alt=""><img
												src="${pageContext.request.contextPath}/resources/room/img/3.svg" alt=""><a href="rooms-gallery.html">full
												info</a>
										</div>
									</div>
								</div>
							</div>
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
											        	<input type="text" name="d1" value="" id="sdate" class="datepicker inp" placeholder="체크인" readonly > 
											        
														<input type="text" name="d2" value="" id="edate" class="datepicker inp" placeholder="체크아웃" readonly >
														<input type="hidden" name="hnum" value="">
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
											<h6 class="color-white mg-6">인원</h6><br>
											<select name="adults" class="wide"><option
													data-display="성인">성인</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
											</select>
										</div>
										<div class="col-12 pt-4">
											<select name="children" class="wide"><option
													data-display="소아">소아</option>
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
										<li class="list__item"><label class="label--checkbox"><input
												type="checkbox" id="checkall" class="checkbox" name="checkall" checked>전체</label></li>
										<li class="list__item"><label class="label--checkbox"><input
												type="checkbox" id="single" class="checkbox" name="check">싱글룸</label></li>
										<li class="list__item"><label class="label--checkbox"><input
												type="checkbox" id="double" class="checkbox" name="check">더블룸</label></li>
										<li class="list__item"><label class="label--checkbox"><input
												type="checkbox" id="twin" class="checkbox" name="check">트윈룸</label></li>
										<li class="list__item"><label class="label--checkbox"><input
												type="checkbox" id="family" class="checkbox" name="check">패밀리룸</label></li>
									</ul>
								</div> 
								<!-- <div class="col-12 col-md-6 col-lg-12 pt-5">
									<h6 class="color-white mb-3">Extra services:</h6>
									<ul class="list">
										<li class="list__item"><label class="label--checkbox"><input
												type="checkbox" class="checkbox"> breakfast</label></li>
										<li class="list__item"><label class="label--checkbox"><input
												type="checkbox" class="checkbox"> swimming pool</label></li>
										<li class="list__item"><label class="label--checkbox"><input
												type="checkbox" class="checkbox"> car rental</label></li>
										<li class="list__item"><label class="label--checkbox"><input
												type="checkbox" class="checkbox"> sea view</label></li>
										<li class="list__item"><label class="label--checkbox"><input
												type="checkbox" class="checkbox"> laundry</label></li>
									</ul>
								</div> -->
							</div>
							<br>
							<button type="submit" class="btn btn-warning float-center submit_next">조회</button>
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
//예약된 날짜를 배열로 가져와 비활성화 시키기
var disabledDays = ["2022-10-20", "2022-10-21" , "2022-10-22"];
console.log(disabledDays.length);
     
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
      dateFormat: "yy.mm.dd", // 날짜형태 예)yy년 m월 d일
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
        
        for(i=0; i<disabledDays.length;i++){
        	if($.inArray(year + '-' +(month+1) + '-' +
        	dates,disabledDays) != -1) {
        		return [false];
        	}
        }
        return [true];
 
     };  
     
 
    /*  
     bookedDays = ["2022-10-10", "2022-10-20" , "2022-10-30"]

     function disableDates(){
     		 var m = date.getMonth() + 1;
              var d = date.getDate();
              var y = date.getFullYear();
                  for (i = 0; i < bookedDays.length; i++) {
                  if ($.inArray(y + '-' + m + '-' + d, bookedDays) != -1) {
                  return [false];
                  }
                  }
                  return [true];
     } */

    /* $('#edate').datepicker();
    $('#edate').datepicker("option", "minDate", $("#sdate").val());
    $('#edate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#sdate").datepicker( "option", "maxDate", selectedDate );
    });  */
    
    
   /*  $('#edate').datepicker("option", "onClose", function (selectedDate) {
    	if(selectedDate.length==10)
       		$("#sdate").datepicker("option", "maxDate", selectedDate);
    	else
    		$("#sdate").datepicker("option", "maxDate", max);
    }); */
    
    
   /*  $('#sdate').datepicker("option", "onClose", function (selectedDate) {
    	if(selectedDate.length==10)
            $("#edate").datepicker("option", "minDate", selectedDate);
        else
            $("#edate").datepicker("option", "minDate", min);
    });  */
    
    
    /* $(".datepicker").change(function(){
	   console.log('datepicker선택');
	   console.log($(this).val());
	   console.log($(this).index());
	   index = $(this).index()
	   $("#d" +  index   ).val($(this).val());
   }) */
   
   
   
   
    
    
   
    	
   
    
    
    
    
   
  
    
    
	</script>
	<!-- JAVASCRIPT    ================================================== -->
	
	<!-- End Document================================================== -->

</body>
</html>