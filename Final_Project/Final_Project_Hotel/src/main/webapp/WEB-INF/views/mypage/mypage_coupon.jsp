<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
	<!DOCTYPE html>
	<html lang="en">

	<head>
		<title>회원정보</title>
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
				font-size: 1.5rem;
				padding: 24px 48px !important;
			}

			.point>div {
				padding: 0 0;
			}
		</style>
	</head>

	<head>
		<title>객실예약확인페이지</title>

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
	</head>

	<body>
		<jsp:include page="../main/header.jsp" />

		<div class="mypage">
			<div class="container mypage_background">
				<div class="row">
					<!--My Page Select Nav-->
					<div class="col-3 nav-background">
						<div class="nav-title">마이페이지</div>
						<div class="list-group">
							<!--reserve-->
							<a href="/hotel/mypage/reserve" class="list-group-item list-group-item-action active">
								<img src="/hotel/static/project_image/mypage_icon/ReservationCheckIcon.png" width="25px"
									alt="" /> 객실예약확인
							</a>
							<!--question-->
							<a href="/hotel/mypage/question" class="list-group-item list-group-item-action"> <img
									src="/hotel/static/project_image/mypage_icon/QuestionCheck.png" width="25px"
									alt="" />
								문의내역확인
							</a>
							<!--Coupon-->
							<a href="/hotel/mypage/coupon" class="list-group-item list-group-item-action"> <img
									src="/hotel/static/project_image/mypage_icon/Coupon.png" width="25px" alt="" /> 마일리지
								|
								쿠폰
							</a>
							<!--member-->
							<a href="/hotel/mypage/member" class="list-group-item list-group-item-action"> <img
									src="/hotel/static/project_image/mypage_icon/MemberCheck2.png" width="25px"
									alt="" />
								회원정보
							</a>
							<a href="/hotel/mypage/wishBoard" class="list-group-item list-group-item-action"> <img
									src="/hotel/static/project_image/mypage_icon/CheckList.png" width="25px" alt="" />
								즐겨찾기
								게시물 확인
							</a>
						</div>
					</div>
					<!--My Page Select Nav End-->

					<div class="col-9 mt-5">
						<div class="card mb-3">
							<div class="card-body row point">
								<div class="col ml-auto">마일리지</div>
								<div>0 Point</div>
							</div>
						</div>
						<div class="card mb-3">
							<div class="card-body row point">
								<div class="col ml-auto">보유한 쿠폰 개수</div>
								<div>0개</div>
							</div>
						</div>
						<div class="card mb-3">
							<div class="card-body row point">
								<div class="col ml-auto">사용한 쿠폰 개수</div>
								<div>0개</div>
							</div>
						</div>
						<div class="card mb-3">
							<div class="card-body row point">
								<div class="col ml-auto">발급 받았던 쿠폰</div>
								<div>0개</div>
							</div>
						</div>
						<div>
							<div class="content-title mb-3">쿠폰 내역 확인</div>
							<table class="table table-bordered">
								<thead>
									<tr>
										<th class="mw-100 text-center">쿠폰번호</th>
										<th class="mw-100 text-center">쿠폰이름</th>
										<th class="mw-100 text-center">쿠폰효과</th>
										<th class="mw-100 text-center">쿠폰발급기간</th>
										<th class="mw-100 text-center">쿠폰유효기간</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>쿠폰이름</td>
										<td>20% 할인</td>
										<td>2022-10-10</td>
										<td>2022-10-15</td>
									</tr>
								</tbody>
								<tfoot></tfoot>
							</table>

						</div>
					</div>

				</div>
			</div>
			<jsp:include page="../main/footer.jsp" />
	</body>

	</html>