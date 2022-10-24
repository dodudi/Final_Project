<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta name="_csrf_header" th:content="${_csrf.headerName}">
		<meta id="_csrf" name="_csrf" th:content="${_csrf.token}">
		<title>회원 정보 수정</title>

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

		<!--mypage_member_check.css-->
		<link rel="stylesheet" href="/hotel/static/project_css/mypage/mypage_module.css">
		<!--<link rel="stylesheet" href="/hotel/static/project_css/mypage/mypage_member_check.css">-->

	</head>

	<body>
		<jsp:include page="../main/header.jsp" />
		<section class="breadcrumb_area">
			<div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
			<div class="container">
				<div class="page-cover text-center">
					<h2 class="page-cover-tittle">회원정보</h2>
					<ol class="breadcrumb">
						<li class="active">마이페이지</li>
						<li><a href="/hotel/mypage/member">회원정보</a></li>
					</ol>
				</div>
			</div>
		</section>
		<div class="mypage">

			<div class="container mypage_background">
				<div class="row">
					<!--My Page Select Nav-->
					<div class="col-3 nav-background">
						<div class="nav-title">마이페이지</div>
						<div class="list-group">
							<!--reserve-->
							<a href="/hotel/mypage/reserve" class="list-group-item list-group-item-action">
								<img src="/hotel/static/project_image/mypage_icon/ReservationCheckIcon.png" width="25px"
									alt="" />
								객실예약확인
							</a>
							<!--question-->
							<a href="/hotel/mypage/question" class="list-group-item list-group-item-action">
								<img src="/hotel/static/project_image/mypage_icon/QuestionCheck.png" width="25px"
									alt="" />
								문의내역확인
							</a>
							<!--Coupon-->
							<a href="/hotel/mypage/coupon" class="list-group-item list-group-item-action">
								<img src="/hotel/static/project_image/mypage_icon/Coupon.png" width="25px" alt="" />
								마일리지 | 쿠폰
							</a>
							<!--member-->
							<a href="/hotel/mypage/member" class="list-group-item list-group-item-action active">
								<img src="/hotel/static/project_image/mypage_icon/MemberCheck2.png" width="25px"
									alt="" />
								회원정보
							</a>
				
						</div>
					</div>
					<!--My Page Select Nav End-->


					<div class="col content-background">
						<div class="nav-title">회원 정보 수정</div>
						<form action="/hotel/mypage/member" method="post">
							<div class="mb-3">
								<label for="MEM_NAME" class="form-label">이름</label>
								<input type="text" class="form-control" id="MEM_NAME" name="MEM_NAME"
									value="${member.MEM_NAME }" readonly>
							</div>
							<div class="mb-3">
								<label for="MEM_ID" class="form-label">아이디</label>
								<input type="text" class="form-control" id="MEM_ID" name="MEM_ID"
									value="${member.MEM_ID }" readonly>

							</div>
							<div class="mb-3">
								<label for="MEM_PASS" class="form-label">비밀번호</label>
								<input type="password" class="form-control" id="MEM_PASS" name="MEM_PASS" required>
								<small id="MEM_PASS_HELP" class="form-text text-muted"></small>
							</div>
							<div class="mb-3">
								<label for="password_check" class="form-label">비밀번호확인</label>
								<input type="password" class="form-control" id="MEM_PASS_CHECK" required>
								<small id="MEM_PASS_CHECK_HELP" class="form-text text-muted"></small>
							</div>
							<div class="mb-3">
								<label for="MEM_BIRTH" class="form-label">생일</label>
								<input type="text" class="form-control" id="MEM_BIRTH" name="MEM_BIRTH"
									value="${member.MEM_BIRTH }" readonly>
							</div>
							<div class="mb-3">
								<label for="MEM_EMAIL" class="form-label">이메일</label>
								<input type="email" class="form-control" id="MEM_EMAIL" name="MEM_EMAIL"
									value="${member.MEM_EMAIL }" required>
								<small id="MEM_EMIAL_HELP" class="form-text text-muted"></small>
							</div>
							<div class="mb-3">
								<label for="MEM_PHONE" class="form-label">전화번호</label>
								<input type="text" class="form-control" id="MEM_PHONE" name="MEM_PHONE"
									value="${member.MEM_PHONE }" readonly>
							</div>
							<button type="submit" id="modify" class="btn btn-primary">수정하기</button>
							<!-- 403에러 방지 토큰 -->
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						</form>
					</div>
				</div>

			</div>

		</div>
		<jsp:include page="../main/footer.jsp" />
	</body>
	<script src="/hotel/static/js/jquery-3.2.1.min.js"></script>
	<script>
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		let passCheck = false;
		$(function () {

			$("#modify").click(function () {
				console.log(checkBlank());
				console.log(passCheck);


			});

			$("#MEM_PASS").on("keyup", function () {
				var pwPattern = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[!@#$%^&*?~]).{8,26}$/;
				if (!pwPattern.test($("#MEM_PASS").val())) {
					console.log("비밀번호를 확인해주세요");
					$("#MEM_PASS_HELP").text("비밀번호를 확인해주세요");
					return;
				} else {
					$("#MEM_PASS_HELP").text("");
				}

				if ($("#MEM_PASS_CHECK").val() != "") {
					if ($("#MEM_PASS").val() != $("#MEM_PASS_CHECK").val()) {
						passCheck = false;
						console.log("비밀번호가 일치하지 않습니다.");
						$("#MEM_PASS_CHECK_HELP").text("비밀번호가 일치하지 않습니다.");
					} else {
						passCheck = true;
						$("#MEM_PASS_CHECK_HELP").text("");
					}
				}
			});

			$("#MEM_PASS_CHECK").on("keyup", function () {
				if ($("#MEM_PASS").val() != $("#MEM_PASS_CHECK").val()) {
					passCheck = false;
					console.log("비밀번호가 일치하지 않습니다.");
					$("#MEM_PASS_CHECK_HELP").text("비밀번호가 일치하지 않습니다.");
				} else {
					passCheck = true;
					$("#MEM_PASS_CHECK_HELP").text("");
				}
			});

			$("#MEM_EMAIL").on("keyup", function () {
				var emailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
				if (!emailPattern.test($("#MEM_EMAIL").val())) {
					console.log("이메일를 확인해주세요");
					$("#MEM_EMIAL_HELP").text("이메일를 확인해주세요");
				} else {
					$("#MEM_EMIAL_HELP").text("");
				}
			})

			function checkBlank() {
				let check = true;
				if ($("#MEM_PASS").val() == "") {
					$("#MEM_PASS_HELP").text("비밀번호를 입력해주세요");
					check = false;
				}

				if ($("#MEM_PASS_CHECK").val() == "") {
					$("#MEM_PASS_CHECK_HELP").text("비밀번호 확인을 입력해주세요");
					check = false;
				}

				if ($("#MEM_EMAIL").val() == "") {
					$("#MEM_EMIAL_HELP").text("이메일 확인을 입력해주세요");
					check = false;
				}
				return check;
			}
		});
	</script>

	</html>