<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
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
<link rel="stylesheet" href="/hotel/static/project_css/mypage/mypage_member_check.css">

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


				<div class="col content-background">
					<div class="title-font-l mt-3 mb-3 bottom-border p-2">회원 정보 수정</div>
					<form>
						<div class="mb-3">
							<label for="email" class="form-label">이름</label>
							<input type="email" class="form-control" id="email" aria-describedby="emailHelp" value="${member.MEM_NAME }">
						</div>
						<div class="mb-3">
							<label for="password" class="form-label">비밀번호</label>
							<input type="password" class="form-control" id="password">
						</div>
						<div class="mb-3">
							<label for="password_check" class="form-label">비밀번호확인</label>
							<input type="password" class="form-control" id="password_check">
						</div>
						<div class="mb-3">
							<label for="name" class="form-label">생일</label>
							<input type="text" class="form-control" id="name" value="${member.MEM_BIRTH }">
						</div>
						<div class="mb-3">
							<label for="email" class="form-label">이메일</label>
							<input type="text" class="form-control" id="email" value="${member.MEM_EMAIL }">
						</div>
						<div class="mb-3">
							<label for="phone" class="form-label">전화번호</label>
							<input type="text" class="form-control" id="phone" value="${member.MEM_PHONE }">
						</div>
						<button type="submit" id="modify" class="btn btn-primary">Submit</button>
					</form>
				</div>
			</div>

		</div>

	</div>
	<jsp:include page="../main/footer.jsp" />
</body>
<script src="/hotel/static/js/jquery-3.2.1.min.js"></script>
<script>
	$("#modify").click(function(){

	});

</script>
</html>