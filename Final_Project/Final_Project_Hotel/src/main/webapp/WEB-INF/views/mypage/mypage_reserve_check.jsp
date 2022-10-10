<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!-- core 라이브러리 -->
		<!DOCTYPE html>
		<html lang="en">

		<head>
			<meta  name="_csrf_header" th:content="${_csrf.headerName}">
			<meta  id="_csrf" name="_csrf" th:content="${_csrf.token}">
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
									<img src="/hotel/static/project_image/mypage_icon/ReservationCheckIcon.png"
										width="25px" alt="" /> 객실예약확인
								</a>
								<!--question-->
								<a href="/hotel/mypage/question" class="list-group-item list-group-item-action"> <img
										src="/hotel/static/project_image/mypage_icon/QuestionCheck.png" width="25px"
										alt="" /> 문의내역확인
								</a>
								<!--Coupon-->
								<a href="/hotel/mypage/coupon" class="list-group-item list-group-item-action"> <img
										src="/hotel/static/project_image/mypage_icon/Coupon.png" width="25px" alt="" />
									마일리지 | 쿠폰
								</a>
								<!--member-->
								<a href="/hotel/mypage/member" class="list-group-item list-group-item-action"> <img
										src="/hotel/static/project_image/mypage_icon/MemberCheck2.png" width="25px"
										alt="" /> 회원정보
								</a> <a href="/hotel/mypage/wishBoard" class="list-group-item list-group-item-action">
									<img src="/hotel/static/project_image/mypage_icon/CheckList.png" width="25px"
										alt="" /> 즐겨찾기 게시물 확인
								</a>
							</div>
						</div>
						<!--My Page Select Nav End-->

						<!--Main Content-->
						<div class="col-9 content-background ">

							<!--Filter-->
							<div>
								filter
								<select name="checkFilter" id="checkFilter">
									<option name="optCheck" value="all">All</option>
									<c:forEach var="breakFast" items="${optBreakFast}">
										<option name="optCheck" value="${breakFast.OPTION_RESERVATION_DATE}">
											${breakFast.OPTION_RESERVATION_DATE}
									</c:forEach>
								</select>
							</div>
							<!--Filter End-->


							<div class="content-title">Reservation information</div>

							<!-- Table content Reservation-->
							<div class="content-table mb-5">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<td>객실등급</td>
											<td>r</td>
										</tr>
										<tr>
											<td>예약자명</td>
											<td>${rezData.MEM_ID }</td>
										</tr>
										<tr>
											<td>체크인 날짜</td>
											<td>${rezData.REZ_CHECKIN }</td>
										</tr>
										<tr>
											<td>체크아웃 날짜</td>
											<td>${rezData.REZ_CHECKOUT }</td>
										</tr>
										<tr>
											<td>총 숙박일</td>
											<td>${subDate}</td>
										</tr>
										<tr>
											<td>성인</td>
											<td>${rezData.REZ_ADULT }명</td>
										</tr>
										<tr>
											<td>아동</td>
											<td>${rezData.REZ_CHILD }명</td>
										</tr>
										<tr>
											<td>총 금액</td>
											<td>${payMentData.PAYMENT_PRICE }원</td>
										</tr>
									</tbody>
								</table>
								<div class="clearfix btn-box">
									<form action="/hotel/mypage/optionModifyForm" id="optModify" method="post">

										<button type="submit" class="btn btn-primary">객실예약변경하기</button>
									</form>
									
									<button type="button" class="btn btn-danger">객실예약취소하기</button>
								</div>
							</div>
							<!-- Table content Reservation End-->

							<div class="content-title">Breakfast | Dinner Information</div>
							<div class="content-table mb-4">
								<table id="optBreakFast" class="table table-bordered table-hover">
									<tbody>
										<tr>
											<td colspan="5" class="content-sub-title">Breakfast</td>
										</tr>
										<c:forEach var="breakFast" items="${optBreakFast}">
											<tr>
												<td rowspan="2">${breakFast.OPTION_RESERVATION_DATE}</td>
												<td>성인</td>
												<td>${breakFast.ADULT}</td>
											</tr>
											<tr>
												<td>아동</td>
												<td>${breakFast.CHILD}</td>
											</tr>
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
										<c:forEach var="dinner" items="${optDinner}">
											<tr>
												<td rowspan="2">${dinner.OPTION_RESERVATION_DATE}</td>
												<td>성인</td>
												<td>${dinner.ADULT}</td>
											</tr>
											<tr>
												<td>아동</td>
												<td>${dinner.CHILD}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
						
							</div>
						</div>
					</div>

				</div>
			</div>
			         <!-- 403에러 방지 토큰 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<jsp:include page="../main/footer.jsp" />
		</body>
		<script src="/hotel/static/project_js/MyPage_Js/mypage_reserve_check.js"></script>

		</html>