<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <!DOCTYPE html>
    <html>
    <head>
    <!-- Required meta tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <!-- 로고 -->
    <link rel="icon" href="static/image/favicon.png" type="image/png">
    <title>Hotel Asia</title>
    
	</head>
    <body>
        <!-- Header/Nav -->
        <jsp:include page="header.jsp" />
        <!--================Banner Area =================-->
        <section class="banner_area" >
            <div class="booking_table d_flex align-items-center" style="min-height:600px">
                <div class="overlay bg-parallax" data-stellar-ratio="0.9" data-stellar-vertical-offset="0"
                    data-background=""></div>
                <div class="container">
                    <div class="banner_content text-center" style="margin-bottom:0px;">
                        <h6>Inspiring Senses & Touching place </h6>
                        <h2>Relax Your Mind</h2>
                    </div>
                </div>
            </div>
        </section>
        <!--================Banner Area =================-->
        <!--================ Accomodation Area  =================-->
        <section class="accomodation_area section_gap">
            <div class="container">
                <div class="section_title text-center">
                    <h2 class="title_color">객 실 소 개</h2>
                    <p>편리하고 안락한 공간설계의 객실로 긴 여행의 피로에 지친 고객의 편안한 휴식공간을 제공합니다.</p>
                </div>
                
                <%-- 상품이 있는 경우--%>
               	<c:if test="${roomListCount > 0 }">
              	 	<div class="row" style="margin-bottom:30px">
               		<c:forEach var="i" items="${roomList}">
               			
               				 <div class="col-lg-3 col-sm-6">
		                        <div class="accomodation_item text-center">
		                            <div class="hotel_img">
		                                <img src="${i.ROOM_IMG}" alt="객실이미지" style="width:-webkit-fill-available; height:270px">
		                                <a href="room/roomDetail?num=${i.ROOM_ID}" class="btn theme_btn button_hover">상세보기</a>
		                            </div>
		                            <a href="room/roomDetail?num=${i.ROOM_ID}">
		                                <h4 class="sec_h4">${i.ROOM_TYPE}</h4>
		                            </a>
		                              <h5><small>KRW</small> <fmt:formatNumber value="${i.ROOM_PRICE }" pattern="#,###"/> </h5>
		                              
		                        </div>
		                    </div>
               			
               		</c:forEach>
               		</div>
               		
               	</c:if>
               <%-- 상품이 없는 경우--%>
			   <c:if test="${roomListCount == 0 }">
			   		<font size=5>등록된 글이 없습니다.</font>
			   </c:if>
                
                <!-- ===========location ============ -->
               <div class="section_title text-center">
                   <h2 class="title_color">호 텔 위 치</h2>
                   <p>호텔 아시아에 오시는 방법을 안내해 드립니다.</p>
               </div>
               
               <div class="row" style="border:1.5px solid lightgray; padding:5px">
               		<div id="map" style="width:100%;height:500px;"></div>
               </div>
               
            </div>
        </section>
        <!--================ Accomodation Area  =================-->


        <!-- Footer -->
        <jsp:include page="footer.jsp"></jsp:include>
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/popper.js"></script>
        //<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/vendors/owl-carousel/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/jquery.ajaxchimp.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/mail-script.js"></script>
        <script
            src="${pageContext.request.contextPath}/resources/vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.js"></script>
        <script
            src="${pageContext.request.contextPath}/resources/vendors/nice-select/js/jquery.nice-select.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/mail-script.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/stellar.js"></script>
        <script src="${pageContext.request.contextPath}/resources/vendors/lightbox/simpleLightbox.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/custom.js"></script>
        
         <script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3f03395b98826ec7d28d1ea88ef247e1&libraries=services"></script>
   
		<script>
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = {
				center: new kakao.maps.LatLng(33.450701, 126.570667),
				level: 3
			};
		//지도 생성 및 객체 리턴
		var map = new kakao.maps.Map(container, options); 
		//주소-좌표 변환 객체 생성 
		var geocoder = new kakao.maps.services.Geocoder(); 
		geocoder.addressSearch('서울특별시 종로구 율곡로10길 105', function(result, status){
			//정상실행 
			if (status === kakao.maps.services.Status.OK){
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });
				 // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:5px 0;color:black">호텔 아시아</div>'
		        });
		        infowindow.open(map, marker);
		        
		        //결과값으로 받은 위치 이동 
		        map.setCenter(coords);
			}
		})
			
		</script>
    </body>

    </html>