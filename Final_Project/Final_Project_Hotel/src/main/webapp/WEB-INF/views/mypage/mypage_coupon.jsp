<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">

<head>
<style>
.content-title {
	font-family: 'Courier New', Courier, monospace;
	color: black;
	font-size: 2rem;
	border-bottom: 2px solid #222222;
}

.point {
	font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
	color: black;
	font-size: 1.1rem;
	padding: 24px 48px !important;
}

.point>div {
	padding: 0 0;
}

.nothing {
	text-align: center;
}

table {
	text-align: center;
	color: black;
}
</style>
</head>

<head>
<title>마일리지/쿠폰</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="/hotel/static/css/bootstrap.css">
<link rel="stylesheet" href="/resources/static/css/bootstrap.css">
<link rel="stylesheet" href="/hotel/static/vendors/linericon/style.css">
<link rel="stylesheet" href="/hotel/static/css/font-awesome.min.css">
<link rel="stylesheet" href="/hotel/static/vendors/owl-carousel/owl.carousel.min.css">
<link rel="stylesheet" href="/hotel/static/vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="/hotel/static/vendors/nice-select/css/nice-select.css">
<link rel="stylesheet" href="/hotel/static/vendors/owl-carousel/owl.carousel.min.css">
<!-- main css -->
<link rel="stylesheet" href="/hotel/static/css/style.css">
<link rel="stylesheet" href="/hotel/static/css/responsive.css">

<!--mypage_member_check.css-->
<link rel="stylesheet" href="/hotel/static/project_css/mypage/mypage_module.css">
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/favicon.png" type="image/png">
</head>

<body>
	<jsp:include page="../main/header.jsp" />
	<section class="breadcrumb_area">
		<div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
		<div class="container">
			<div class="page-cover text-center">
				<h2 class="page-cover-tittle">마일리지/쿠폰</h2>
				<ol class="breadcrumb">
					<li class="active">마이페이지</li>
					<li><a href="/hotel/mypage/coupon">마일리지/쿠폰</a></li>
				</ol>
			</div>
		</div>
	</section>
	<div class="mypage"></div>
		<div class="container mypage_background">
			<div class="row">
				<!--My Page Select Nav-->
				<div class="col-3 nav-background">
					<div class="nav-title">마이페이지</div>
					<div class="list-group">
						<!--reserve-->
						<a href="/hotel/mypage/reserve" class="list-group-item list-group-item-action">
							<img src="/hotel/static/project_image/mypage_icon/ReservationCheckIcon.png" width="25px" alt="" />
							객실예약확인
						</a>
						<!--question-->
						<a href="/hotel/mypage/question" class="list-group-item list-group-item-action">
							<img src="/hotel/static/project_image/mypage_icon/QuestionCheck.png" width="25px" alt="" />
							문의내역확인
						</a>
						<!--Coupon-->
						<a href="/hotel/mypage/coupon" class="list-group-item list-group-item-action" style="background-color:#f8b600" >
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

				<div class="col-9 mt-3">
					<div class="card mb-3">
						<div class="card-body row point">
							<div class="col ml-auto">마일리지</div>
							<div>${point}Point</div>
						</div>
					</div>
					<div class="card mb-3">
						<div class="card-body row point">
							<div class="col ml-auto">보유한 쿠폰 개수</div>
							<div>${memberCouponCount}개</div>
						</div>
					</div>
					<div class="card mb-3">
						<div class="card-body row point">
							<div class="col ml-auto">사용한 쿠폰 개수</div>
							<div>${useCouponCount}개</div>
						</div>
					</div>
					<div class="card mb-3">
						<div class="card-body row point">
							<div class="col ml-auto">발급 받았던 쿠폰</div>
							<div>${allCouponCount}개</div>
						</div>
					</div>
					<div class="mb-5">
						<div class="content-title mb-3">쿠폰 내역 확인</div>
						<c:if test="${empty memberCoupons }">
							<div class="nothing">
								<h4>보유하신 쿠폰이 없습니다.</h4>
							</div>
						</c:if>
						<c:if test="${not empty memberCoupons }">
							<table class="table table-bordered text-center">
								<thead>
									<tr class="table-active">
										<th class="mw-100 ">쿠폰번호</th>
										<th class="mw-100">쿠폰이름</th>
										<th class="mw-100">쿠폰설명</th>
										<th class="mw-100">쿠폰발급기간</th>
										<th class="mw-100">쿠폰유효기간</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="coupons" items="${memberCoupons}" varStatus="status">
										<c:set var="couponOpt" value="${memberCouponOpt[status.index] }">
										</c:set>
										<fmt:parseDate value="${coupons.COUPON_GET_DATE}" var="dateValue1" pattern="yyyy-MM-dd HH:mm:ss" />
										<fmt:formatDate value="${dateValue1}" var="dateGet" pattern="yyyy-MM-dd" />
										<fmt:parseDate value="${coupons.COUPON_END_DATE}" var="dateValue2" pattern="yyyy-MM-dd HH:mm:ss" />
										<fmt:formatDate value="${dateValue2}" var="dateEnd" pattern="yyyy-MM-dd" />
										<tr>
											<td>${status.index+1 }</td>
											<td>${couponOpt.COUPON_NAME }</td>
											<td>${couponOpt.COUPON_COMMENT }</td>
											<td>${dateGet }</td>
											<td>${dateEnd }</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot></tfoot>
							</table>
						</c:if>

					</div>
					<!-- 쿠폰 내역 끝 -->

					<!-- 사용 내역 -->
					<div class="mb-5" style="margin-bottom:150px!important;">
						<div class="content-title mb-3">쿠폰 사용 내역 확인</div>
						<c:if test="${empty useCoupons }">
							<div class="nothing">
								<h4>사용하신 쿠폰이 없습니다.</h4>
							</div>
						</c:if>
						<c:if test="${not empty useCoupons }">
							<table class="table table-bordered  text-center">
								<thead>
									<tr class="table-active">
										<th class="mw-100">쿠폰번호</th>
										<th class="mw-100">쿠폰이름</th>
										<th class="mw-100">쿠폰설명</th>
										<th class="mw-100">쿠폰발급기간</th>
										<th class="mw-100">쿠폰유효기간</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="coupons" items="${useCoupons}" varStatus="status">
										<c:set var="couponOpt" value="${useCouponOpt[status.index] }">
										</c:set>
										<fmt:parseDate value="${coupons.COUPON_GET_DATE}" var="dateValue1" pattern="yyyy-MM-dd HH:mm:ss" />
										<fmt:formatDate value="${dateValue1}" var="dateGet" pattern="yyyy-MM-dd" />
										<fmt:parseDate value="${coupons.COUPON_END_DATE}" var="dateValue2" pattern="yyyy-MM-dd HH:mm:ss" />
										<fmt:formatDate value="${dateValue2}" var="dateEnd" pattern="yyyy-MM-dd" />
										<tr>
											<td>${status.index+1 }</td>
											<td>${couponOpt.COUPON_NAME }</td>
											<td>${couponOpt.COUPON_COMMENT }</td>
											<td>${dateGet }</td>
											<td>${dateEnd }</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot></tfoot>
							</table>
						</c:if>

					</div>
					<!-- 사용 내역 끝 -->


				</div>

			</div>
		</div>
		
		<jsp:include page="../main/footer.jsp" />
</body>

</html>