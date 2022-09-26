<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Hotel Asia</title>
 <!-- Required meta tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" href="image/favicon.png" type="image/png">
    <title>Royal Hotel</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="vendors/linericon/style.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
    <link rel="stylesheet" href="vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="vendors/nice-select/css/nice-select.css">
    <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
    <!-- main css -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    
</head>
<body>
<!-- Header/Nav -->
<jsp:include page="header.jsp" />
 <!--================Banner Area =================-->
     <section class="banner_area">
         <div class="booking_table d_flex align-items-center">
         	<div class="overlay bg-parallax" data-stellar-ratio="0.9" data-stellar-vertical-offset="0" data-background=""></div>
			<div class="container">
				<div class="banner_content text-center">
					<h6>Away from monotonous life</h6>
					<h2>Relax Your Mind</h2>
					<p>If you are looking at blank cassettes on the web, you may be very confused at the<br> difference in price. You may see some for as low as $.17 each.</p>
				</div>
			</div>
         </div>
         <div class="hotel_booking_area position">
             <div class="container">
                 <div class="hotel_booking_table">
                     <div class="col-md-3">
                         <h2>Book<br> Your Room</h2>
                     </div>
                     <div class="col-md-9">
                         <div class="boking_table">
                             <div class="row">
                                 <div class="col-md-4">
                                     <div class="book_tabel_item">
                                         <div class="form-group">
                                             <div class='input-group date' id='datetimepicker11'>
                                                 <input type='text' class="form-control" placeholder="체크인"/>
                                                 <span class="input-group-addon">
                                                     <i class="fa fa-calendar" aria-hidden="true"></i>
                                                 </span>
                                             </div>
                                         </div>
                                         <div class="form-group">
                                             <div class='input-group date' id='datetimepicker1'>
                                                 <input type='text' class="form-control" placeholder="체크아웃"/>
                                                 <span class="input-group-addon">
                                                     <i class="fa fa-calendar" aria-hidden="true"></i>
                                                 </span>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                                 <div class="col-md-4">
                                     <div class="book_tabel_item">
                                         <div class="input-group">
                                             <select class="wide">
                                                 <option data-display="성인">성인</option>
                                                 <option value="1">1</option>
                                                 <option value="2">2</option>
                                                 <option value="3">3</option>
                                                 <option value="4">4</option>
                                             </select>
                                         </div>
                                         <div class="input-group">
                                             <select class="wide">
                                                 <option data-display="소아">소아</option>
                                                 <option value="1">1</option>
                                                 <option value="2">2</option>
                                                 <option value="3">3</option>
                                                 <option value="4">4</option>
                                             </select>
                                         </div>
                                     </div>
                                 </div>
                                 <div class="col-md-4">
                                     <div class="book_tabel_item">
                                         <a class="book_now_btn button_hover" href="#">Book Now</a>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </section>
    <!--================Banner Area =================-->
     <!--================ Accomodation Area  =================-->
        <section class="accomodation_area section_gap">
            <div class="container">
                <div class="section_title text-center">
                    <h2 class="title_color">Hotel Accomodation</h2>
                    <p>We all live in an age that belongs to the young at heart. Life that is becoming extremely fast, </p>
                </div>
                <div class="row mb_30">
                    <div class="col-lg-3 col-sm-6">
                        <div class="accomodation_item text-center">
                            <div class="hotel_img">
                                <img src="image/room1.jpg" alt="">
                                <a href="#" class="btn theme_btn button_hover">Book Now</a>
                            </div>
                            <a href="#"><h4 class="sec_h4">Double Deluxe Room</h4></a>
                            <h5>$250<small>/night</small></h5>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="accomodation_item text-center">
                            <div class="hotel_img">
                                <img src="image/room2.jpg" alt="">
                                <a href="#" class="btn theme_btn button_hover">Book Now</a>
                            </div>
                            <a href="#"><h4 class="sec_h4">Single Deluxe Room</h4></a>
                            <h5>$200<small>/night</small></h5>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="accomodation_item text-center">
                            <div class="hotel_img">
                                <img src="image/room3.jpg" alt="">
                                <a href="#" class="btn theme_btn button_hover">Book Now</a>
                            </div>
                            <a href="#"><h4 class="sec_h4">Honeymoon Suit</h4></a>
                            <h5>$750<small>/night</small></h5>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="accomodation_item text-center">
                            <div class="hotel_img">
                                <img src="image/room4.jpg" alt="">
                                <a href="#" class="btn theme_btn button_hover">Book Now</a>
                            </div>
                            <a href="#"><h4 class="sec_h4">Economy Double</h4></a>
                            <h5>$200<small>/night</small></h5>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================ Accomodation Area  =================-->
      

	<!-- Footer -->
	<jsp:include page="footer.jsp"></jsp:include>

  <!-- Optional JavaScript -->
     <!-- jQuery first, then Popper.js, then Bootstrap JS -->
     <script src="js/jquery-3.2.1.min.js"></script>
     <script src="js/popper.js"></script>
     <script src="js/bootstrap.min.js"></script>
     <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
     <script src="js/jquery.ajaxchimp.min.js"></script>
     <script src="js/mail-script.js"></script>
     <script src="vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.js"></script>
     <script src="vendors/nice-select/js/jquery.nice-select.js"></script>
     <script src="js/mail-script.js"></script>
     <script src="js/stellar.js"></script>
     <script src="vendors/lightbox/simpleLightbox.min.js"></script>
     <script src="js/custom.js"></script>
</body>
</html>