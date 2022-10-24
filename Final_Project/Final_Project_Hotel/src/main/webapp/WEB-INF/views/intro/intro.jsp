<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
 <html>
    <head>
    <!-- Required meta tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendors/linericon/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendors/nice-select/css/nice-select.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendors/owl-carousel/owl.carousel.min.css">
    <!-- main css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/responsive.css">
    
    <!-- 로고 -->
    <link rel="icon" href="${pageContext.request.contextPath}/resources/image/favicon.png" type="image/png">
    <title>호텔 소개</title>
    
	</head>
	<body>
	 	<!-- Header/Nav -->
        <jsp:include page="../main/header.jsp" />
        
        <!--================Breadcrumb Area =================-->
		<section class="breadcrumb_area">
		    <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
		    <div class="container">
		        <div class="page-cover text-center">
		            <h2 class="page-cover-tittle">About Us</h2>
		        </div>
		    </div>
		</section>
		<!--================Breadcrumb Area =================-->
		
		<!--================ About History Area  =================-->
        <section class="about_history_area section_gap">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 d_flex align-items-center">
                        <div class="about_content ">
                            <h2 class="title title_color">Asia <br>Hotel<br>Mission & Vision</h2>
                            <p>도심 속 자연과 감동의 서비스를 통해 고객에게 행복한 경험을 제공해 드릴 것을 약속합니다. 
                            	진심 어린 마음으로 다가가 고객 한 분 한 분에게 사려 깊은 배려로 따뜻한 미소와 행복을 전달해 드리겠습니다.
                            	고객 개개인의 라이프 스타일에 맞춰 편안하고 품격있는 서비스를 제안합니다.</p>
                            <a href="${pageContext.request.contextPath}/room/roomList" 
                            	class="button_hover theme_btn_two">Request Custom Price</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <img class="img-fluid" src="${pageContext.request.contextPath}/resources/image/intro_lobby.jpg" alt="img">
                    </div>
                </div>
            </div>
        </section>
        <!--================ About History Area  =================-->
        
        <!--================ Facilities Area  =================-->
        <section class="facilities_area section_gap">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background="">  
            </div>
            <div class="container">
                <div class="section_title text-center">
                    <h2 class="title_w">편 의 시 설</h2>
                    <p>자연 친화적인 다양한 부대시설이 준비되어 있습니다. </p>
                </div>
                <div class="row mb_30">
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                            <h4 class="sec_h4"><i class="lnr lnr-dinner"></i>Restaurant</h4>
                            <p>호텔 아시아의 베이커리 파티시에가 준비한 다과와 간단한 샐러드, 음료 등이 제공됩니다.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                            <h4 class="sec_h4"><i class="lnr lnr-bicycle"></i>Sports CLub</h4>
                            <p>호텔 아시아의 피트니스에서는 고객님의 건강한 라이프스타일을 위해 필요한 서비스를 제공합니다.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                       		<h4 class="sec_h4"><i class="lnr lnr-car"></i>Rent a Car</h4>
                            <p>로비 1층(인포메이션)에서 실속있는 가격으로 렌트카를 이용할 수 있습니다.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                             <h4 class="sec_h4"><i class="lnr lnr-shirt"></i>Swimming Pool</h4>
                            <p>사계절 인피니티 스파 풀로 365일 날씨에 맞게 적절한 온도의 온수풀을 즐길 수 있습니다.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                            <h4 class="sec_h4"><i class="lnr lnr-construction"></i>Sauna</h4>
                            <p>따뜻하게 체온을 유지할 수 있는 공간으로 물놀이 중 편안하고 안락한 휴식을 누릴 수 있습니다.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                            <h4 class="sec_h4"><i class="lnr lnr-coffee-cup"></i>Bar</h4>
                            <p>푸르른 풀 숲을 조망하며 자연의 낭만과 함께 다양한 주류와 간편한 스낵을 즐길 수 있습니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================ Facilities Area  =================-->
        
        <!-- Footer -->
        <jsp:include page="../main/footer.jsp"/>
	</body>
</html>