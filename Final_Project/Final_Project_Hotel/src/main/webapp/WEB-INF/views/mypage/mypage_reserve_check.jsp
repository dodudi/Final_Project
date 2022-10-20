<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- core 라이브러리 -->
<!DOCTYPE html>
<html lang="en">

<head>
<meta name="_csrf_header" th:content="${_csrf.headerName}">
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}">
<title>객실예약확인페이지</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="/hotel/static/css/bootstrap.css">
<link rel="stylesheet" href="/hotel/static/vendors/linericon/style.css">
<link rel="stylesheet" href="/hotel/static/css/font-awesome.min.css">
<link rel="stylesheet" href="/hotel/static/vendors/owl-carousel/owl.carousel.min.css">
<link rel="stylesheet" href="/hotel/static/vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="/hotel/static/vendors/nice-select/css/nice-select.css">
<link rel="stylesheet" href="/hotel/static/vendors/owl-carousel/owl.carousel.min.css">
<!-- main css -->
<link rel="stylesheet" href="/hotel/static/css/style.css">
<link rel="stylesheet" href="/hotel/static/css/responsive.css">
<link rel="stylesheet" href="/hotel/static/project_css/mypage/mypage_module.css">
<link rel="stylesheet" href="/hotel/static/project_css/mypage/mypage_reserve_check.css">
</head>

<body>
	<jsp:include page="../main/header.jsp" />
	<div class="mypage">
		<div class="container mypage_background">
			<div class="row">
				<!--My Page Select Nav-->
				<div class="col-3 nav-background">
					<div class="list-group">
						<div class="nav-title">My Page</div>
						<!--reserve-->
						<a href="/hotel/mypage/reserve" class="list-group-item list-group-item-action active">
							<img src="/hotel/static/project_image/mypage_icon/ReservationCheckIcon.png" width="25px" alt="" />
							객실예약확인
						</a>
						<!--question-->
						<a href="/hotel/mypage/question" class="list-group-item list-group-item-action">
							<img src="/hotel/static/project_image/mypage_icon/QuestionCheck.png" width="25px" alt="" />
							문의내역확인
						</a>
						<!--Coupon-->
						<a href="/hotel/mypage/coupon" class="list-group-item list-group-item-action">
							<img src="/hotel/static/project_image/mypage_icon/Coupon.png" width="25px" alt="" />
							마일리지 | 쿠폰
						</a>
						<!--member-->
						<a href="/hotel/mypage/member" class="list-group-item list-group-item-action">
							<img src="/hotel/static/project_image/mypage_icon/MemberCheck2.png" width="25px" alt="" />
							회원정보
						</a>
						<a href="/hotel/mypage/wishBoard" class="list-group-item list-group-item-action">
							<img src="/hotel/static/project_image/mypage_icon/CheckList.png" width="25px" alt="" />
							즐겨찾기 게시물 확인
						</a>
					</div>
				</div>
				<!--My Page Select Nav End-->

				<!--Main Content-->
				<div class="col-9 content-background ">

					<c:if test="${empty rezData }">
						<div class="content-title">Reservation information</div>
						<div>객실 예약 정보가 없습니다.</div>

					</c:if>
					<c:if test="${not empty rezData }">
						<div class="content-title">Reservation information</div>



						<!-- Table content Reservation -->
						<div class="content-table mb-5">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<td>예약자명</td>
										<td>체크인 날짜</td>
										<td>체크아웃 날짜</td>
										<td>성인</td>
										<td>아동</td>
									</tr>
									<c:forEach var="rez" items="${rezData}">
										<tr>
											<td>${rez.MEM_ID }</td>
											<td>${rez.REZ_CHECKIN }</td>
											<td>${rez.REZ_CHECKOUT }</td>
											<td>${rez.REZ_ADULT }</td>
											<td>${rez.REZ_CHILD }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>

						</div>
						<!--Table content Reservation End-->

						<!-- 
					<div class="content-title">Breakfast | Dinner Information</div>
					<div class="content-table mb-4">
						<table id="optBreakFast" class="table table-bordered table-hover">
							<tbody>
								<tr>
									<td colspan="5" class="content-sub-title">Breakfast</td>
								</tr>
								<c:forEach var="allDate" items="${allDates}">
									<c:set var="flag" value="false"></c:set>
									<c:forEach var="breakFast" items="${optBreakFast}">
										<c:if test="${breakFast.OPTION_RESERVATION_DATE == allDate && flag==false}">
											<tr>
												<td rowspan="2">${allDate}</td>
												<td>성인 : ${breakFast.ADULT}</td>
												<td>가격 : ${break_price[allDate]["adultPrice"]}</td>
											</tr>
											<tr>
												<td>아동 : ${breakFast.CHILD}</td>
												<td>가격 : ${break_price[allDate]["childPrice"]}</td>
											</tr>
											<c:set var="flag" value="true"></c:set>
										</c:if>
									</c:forEach>
									<c:if test="${flag == false}">
										<tr>
											<td rowspan="2">${allDate}</td>
											<td>성인 : 0</td>
											<td>가격 : 0</td>
										</tr>
										<tr>

											<td>아동 : 0</td>
											<td>가격 : 0</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="content-table mb-4">
						<table id="optDinner" class=" table table-bordered">
							<tbody>
								<tr>
									<td colspan="5" class="content-sub-title">Dinner</td>
								</tr>
								<c:forEach var="allDate" items="${allDates}">
									<c:set var="flag" value="false"></c:set>
									<c:forEach var="dinner" items="${optDinner}">
										<c:if test="${dinner.OPTION_RESERVATION_DATE == allDate && flag==false}">
											<tr>
												<td rowspan="2">${allDate}</td>
												<td>성인 : ${dinner.ADULT}</td>
												<td>가격 : ${dinner_price[allDate]["adultPrice"]}</td>
											</tr>
											<tr>
												<td>아동 : ${dinner.CHILD}</td>
												<td>가격 : ${dinner_price[allDate]["childPrice"]}</td>
											</tr>
											<c:set var="flag" value="true"></c:set>
										</c:if>
									</c:forEach>
									<c:if test="${flag == false}">
										<tr>
											<td rowspan="2">${allDate}</td>
											<td>성인 : 0</td>
											<td>가격 : 0</td>
										</tr>
										<tr>

											<td>아동 : 0</td>
											<td>가격 : 0</td>
										</tr>
									</c:if>
								</c:forEach>


							</tbody>
						</table>

					</div>
					<div class="content-table mb-4">
						<table id="optDinner" class=" table table-bordered">
							<tbody>
								<tr>
									<td colspan="5" class="content-sub-title">Swim</td>
								</tr>
								<c:forEach var="allDate" items="${allDates}">
									<c:set var="flag" value="false"></c:set>
									<c:forEach var="swim" items="${optSwimming}">
										<c:if test="${swim.OPTION_RESERVATION_DATE == allDate && flag==false}">
											<tr>
												<td rowspan="2">${allDate}</td>
												<td>성인 : ${swim.ADULT}</td>
												<td>가격 : ${swim_price[allDate]["adultPrice"]}</td>
											</tr>
											<tr>
												<td>아동 : ${swim.CHILD}</td>
												<td>가격 : ${swim_price[allDate]["childPrice"]}</td>
											</tr>
											<c:set var="flag" value="true"></c:set>
										</c:if>
									</c:forEach>
									<c:if test="${flag == false}">
										<tr>
											<td rowspan="2">${allDate}</td>
											<td>성인 : 0</td>
											<td>가격 : 0</td>
										</tr>
										<tr>

											<td>아동 : 0</td>
											<td>가격 : 0</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>

					</div>
					 -->
					</c:if>
				</div>

			</div>
			<!-- 403에러 방지 토큰 -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</div>
	</div>

	<jsp:include page="../main/footer.jsp" />
</body>

</html>