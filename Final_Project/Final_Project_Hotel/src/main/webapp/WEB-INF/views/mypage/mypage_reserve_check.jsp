<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta name="_csrf_header" th:content="${_csrf.headerName}">
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}">
<title>객실예약확인</title>

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
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/favicon.png" type="image/png">
<!--<link rel="stylesheet" href="/hotel/static/project_css/mypage/mypage_reserve_check.css">-->
<style type="text/css">
.price {
	width: 20%;
}

.date {
	border-bottom: 2px solid black;
}

.nothing {
	margin-top: 200px;
	text-align: center;
	height: 400px;
	line-height: 0px;
}
.dateTitle{
		text-align: center;
		margin-top: 30px;
		line-height: 0px;
}
table{
	text-align :center;
	color:black;
}
.btn-primary{
	background-color:#f3c300!important;
	border-color : #f3c300!important;
}
</style>
</head>

<body>
	<jsp:include page="../main/header.jsp" />
	<section class="breadcrumb_area">
		<div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
		<div class="container">
			<div class="page-cover text-center">
				<h2 class="page-cover-tittle">객실예약확인</h2>
				<ol class="breadcrumb">
					<li class="active">마이페이지</li>
					<li><a href="/hotel/mypage/reserve">객실예약확인</a></li>
				</ol>
			</div>
		</div>
	</section>
	<div class="mypage">
		<div class="container mypage_background">
			<div class="row">
				<!--My Page Select Nav-->
				<div class="col-3 nav-background">
					<div class="list-group">
						<div class="nav-title">마이페이지</div>
						<!--reserve-->
						<a href="/hotel/mypage/reserve" class="list-group-item list-group-item-action" style="background-color:#f8b600">
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

					</div>
				</div>
				<!--My Page Select Nav End-->

				<!--Main Content-->
				<div class="col-9 content-background ">

					<div class="content-title">객실예약확인</div>
					<c:if test="${empty rezData }">
						<form action="/hotel/room/roomList">
							<div class="nothing">
								<h4>객실 예약 정보가 없습니다.</h4>
								<h4>객실 예약을 먼저 해주세요</h4>
								<button type="submit" class="btn btn-primary">예약하기</button>
							</div>

						</form>
					</c:if>
					<c:if test="${not empty rezData }">

						<!-- Table content Reservation -->
						<div class="content-table mb-5">
							<table class="table table-bordered">
								<tbody>
									<tr class="table-active">
										<th>예약번호</th>
										<th>등급</th>
										<th>예약자명</th>
										<th>체크인 날짜</th>
										<th>체크아웃 날짜</th>
										<th>성인</th>
										<th>아동</th>
									</tr>
									<c:forEach var="rez" items="${rezData}" varStatus="status">
										<tr>
											<td>${rez.REZ_ID}</td>
											<td>${roomData[status.index].ROOM_TYPE}</td>
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

						<!-- Table content Reservation -->
						<c:forEach var="rez" items="${rezData}" varStatus="status">
							<div class="content-table mb-5">
								<div class="date row">
									<div class="content-title">[객실예약번호 : ${rez.REZ_ID}]</div>
									<div class="dateTitle"> <h4> &nbsp;&nbsp; ${dates[rez.REZ_ID][0]}~${dates[rez.REZ_ID][(dates[rez.REZ_ID].size()-1)]}</h4></div>
								</div>


								<c:forEach var="optionList" items="${optList}" varStatus="optStatus">
									<div class="content-title">${optionList.OPTION_NAME}</div>
									<table class="table table-bordered">
										<tbody>
											<tr class="table-active">
												<th class="price">날짜</th>
												<th class="price">성인</th>
												<th class="price">아동</th>
												<th class="price">인원 수</th>
												<th class="price">가격</th>
											</tr>
											<c:forEach var="date" items="${dates[rez.REZ_ID]}" varStatus="status">
												<tr>
													<td>${date}</td>
													<c:set var="flag" value="false"></c:set>
													<c:set var="optMapR" value="${optionMap[rez.REZ_ID][optionList.OPTION_ID]}"></c:set>

													<c:forEach var="optMap" items="${optionMap[rez.REZ_ID][optionList.OPTION_ID]}">
														<c:if test="${flag==false && optMap.OPTION_RESERVATION_DATE == date}">
															<c:set var="optMapR" value="${optMap}"></c:set>
															<c:set var="flag" value="true"></c:set>
														</c:if>
													</c:forEach>
													<c:if test="${flag==true }">
														<td>${optMapR.ADULT}명</td>
														<td>${optMapR.CHILD}명</td>
														<td>${optMapR.CHILD + optMapR.ADULT}명</td>
														<td>
															<fmt:formatNumber value="${(optMapR.CHILD * optionList.OPTION_CHILD_PRICE) + (optMapR.ADULT * optionList.OPTION_DEFAULT_PRICE)}" pattern="#,###" />
															원
														</td>
													</c:if>
													<c:if test="${flag==false }">
														<td>0명</td>
														<td>0명</td>
														<td>0명</td>
														<td>0원</td>
													</c:if>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</c:forEach>

							</div>
						</c:forEach>
						<!--Table content Reservation End-->
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