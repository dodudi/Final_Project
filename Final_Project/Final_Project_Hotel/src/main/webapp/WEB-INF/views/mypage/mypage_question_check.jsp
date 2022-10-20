<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- fmt 라이브러리 -->
<!DOCTYPE html>
<html lang="en">

<head>
<meta name="_csrf_header" th:content="${_csrf.headerName}">
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}">
<title>문의내역확인</title>

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

<!--mypage_question_check.css-->
<link rel="stylesheet" href="/hotel/static/project_css/mypage/mypage_module.css">
<style type="text/css">
.tst {
	margin-left: 90%;
}
</style>
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
					</div>
				</div>
				<!--My Page Select Nav End-->

				<div class="col-9 content-background ">
					<div class="content-title row">문의내역확인</div>
					<div class="tst">
						filter :
						<select id="itemLimitSelect">
							<c:forEach var="i" begin="1" end="3" step="1">
								<c:if test="${itemLimit == (2*i-1)*10 }">
									<option selected="selected" value="${ (2*i-1)*10 }">${ (2*i-1)*10 }</option>
								</c:if>
								<c:if test="${itemLimit != (2*i-1)*10 }">
									<option value="${ (2*i-1)*10 }">${ (2*i-1)*10 }</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div class="content-table mb-5">
						<table class="table">
							<tbody id="itemBox">
								<tr>
									<td>글번호</td>
									<td>글제목</td>
									<td>작성자</td>
									<td>작성일</td>
									<td>답변상태</td>
								</tr>
								<c:forEach var="i" begin="1" end="${pageCalc.pageData.itemLimit }" step="1">
									<tr>
										<td>${i }</td>
										<td>글제목</td>
										<td>작성자</td>
										<td>작성일</td>
										<td>답변상태</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>

						<nav aria-label="Page navigation example">
							<ul id= "pagination" class="pagination justify-content-center">
								<!--disable-->
								<c:if test="${pageCalc.prev == true}">
									<fmt:parseNumber var="test" value="${((pageCalc.startPage-1)/pageCalc.pageLimit)  }"></fmt:parseNumber>
									<li class="page-item"><a class="page-link" href="/hotel/mypage/question?pageNum=${test}" tabindex="-1">&laquo;</a></li>
								</c:if>
								<!--active-->
								<c:forEach var="i" begin="${pageCalc.startPage }" end="${pageCalc.endPage }" step="1">
									<c:if test="${i == pageCalc.pageData.pageNum}">
										<li class="page-item active"><a class="page-link" href="/hotel/mypage/question?pageNum=${i}">${i}</a></li>
									</c:if>
									<c:if test="${i!=pageCalc.pageData.pageNum }">
										<li class="page-item"><a class="page-link" href="/hotel/mypage/question?pageNum=${i}">${i}</a></li>
									</c:if>
								</c:forEach>

								<c:if test="${pageCalc.next == true}">
									<li class="page-item"><a class="page-link" href="/hotel/mypage/question?pageNum=${(pageCalc.startPage*10)+1}">&raquo; </a></li>
								</c:if>
							</ul>
						</nav>
						<input type="hidden" id="pageNum" value="${pageCalc.pageData.pageNum}" />

					</div>
				</div>
			</div>

		</div>
	</div>
	<jsp:include page="../main/footer.jsp" />
</body>

<script src="/hotel/static/project_js/MyPage_Js/mypage_question_check.js"></script>
</html>