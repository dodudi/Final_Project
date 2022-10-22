<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
				<link rel="stylesheet"
					href="/hotel/static/vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.css">
				<link rel="stylesheet" href="/hotel/static/vendors/nice-select/css/nice-select.css">
				<link rel="stylesheet" href="/hotel/static/vendors/owl-carousel/owl.carousel.min.css">
				<!-- main css -->
				<link rel="stylesheet" href="/hotel/static/css/style.css">
				<link rel="stylesheet" href="/hotel/static/css/responsive.css">

				<!--mypage_question_check.css-->
				<link rel="stylesheet" href="/hotel/static/project_css/mypage/mypage_module.css">
				<style>
					.nothing {
						margin-top: 200px;
						text-align: center;
						height: 400px;
					}
				</style>
			</head>

			<body>
				<jsp:include page="../main/header.jsp" />

				<section class="breadcrumb_area">
					<div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0"
						data-background=""></div>
					<div class="container">
						<div class="page-cover text-center">
							<h2 class="page-cover-tittle">문의사항</h2>
							<ol class="breadcrumb">
								<li class="active">마이페이지</li>
								<li><a href="list">문의사항</a></li>
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
										<img src="/hotel/static/project_image/mypage_icon/ReservationCheckIcon.png"
											width="25px" alt="" />
										객실예약확인
									</a>
									<!--question-->
									<a href="/hotel/mypage/question"
										class="list-group-item list-group-item-action active">
										<img src="/hotel/static/project_image/mypage_icon/QuestionCheck.png"
											width="25px" alt="" />
										문의내역확인
									</a>
									<!--Coupon-->
									<a href="/hotel/mypage/coupon" class="list-group-item list-group-item-action">
										<img src="/hotel/static/project_image/mypage_icon/Coupon.png" width="25px"
											alt="" />
										마일리지 | 쿠폰
									</a>
									<!--member-->
									<a href="/hotel/mypage/member" class="list-group-item list-group-item-action">
										<img src="/hotel/static/project_image/mypage_icon/MemberCheck2.png" width="25px"
											alt="" />
										회원정보
									</a>
								</div>
							</div>
							<!--My Page Select Nav End-->

							<div class="col-9 content-background">
								<c:if test="${total == 0 }">

									<div class="content-title">문의내역확인</div>

									<form action="/hotel/question/list">
										<div class="nothing">
											<h4>문의사항을 작성하지 않으셧습니다.</h4>
											<h4>문의사항을 작성해주세요.</h4>
											<button type="submit" class="btn btn-primary">문의사항 작성하기</button>
										</div>
									</form>
								</c:if>
								<c:if test="${total!=0 }">
									<div class="content-title row">
										<div class="col ml-auto">문의내역확인</div>
										<div class="tst">
											filter :
											<select id="itemLimitSelect">
												<c:forEach var="i" begin="1" end="3" step="1">
													<c:if test="${itemLimit == (2*i-1)*10 }">
														<option selected="selected" value="${ (2*i-1)*10 }">${
															(2*i-1)*10 }</option>
													</c:if>
													<c:if test="${itemLimit != (2*i-1)*10 }">
														<option value="${ (2*i-1)*10 }">${ (2*i-1)*10 }</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
									</div>
									<div class="content-table mb-5">
										<table class="table">
											<tbody id="itemBox">
												<tr class="table-active">
													<td>글 번호</td>
													<td>카테고리</td>
													<td>제목</td>
													<td>작성자</td>
													<td>날짜</td>
													<td>조회수</td>
													<td>문의상태</td>
												</tr>
												<c:forEach var="i" begin="1" end="${questions.size()}" step="1">
													<tr>
														<td>${questions[i-1].QUESTIONS_NUM}</td>
														<td>${ questions[i-1].QUESTIONS_CATEGORY}</td>
														<td>
															<a
																href="/hotel/question/detail?num=${questions[i-1].QUESTIONS_NUM }">${questions[i-1].QUESTIONS_SUBJECT}</a>
														</td>
														<td>${questions[i-1].MEM_ID}</td>
														<td>${questions[i-1].QUESTIONS_DATE}</td>
														<td>${questions[i-1].QUESTIONS_READCOUNT}</td>
														<c:if test="${empty questions[i-1].QUESTIONS_ANSWER}">
															<td>처리중</td>
														</c:if>
														<c:if test="${not empty questions[i-1].QUESTIONS_ANSWER}">
															<td>처리완료</td>
														</c:if>
													</tr>
												</c:forEach>

											</tbody>
										</table>

										<nav aria-label="Page navigation example">
											<ul id="pagination" class="pagination justify-content-center">
												<!--disable-->
												<c:if test="${pageCalc.prev == true}">
													<fmt:parseNumber var="test"
														value="${((pageCalc.startPage-1)/pageCalc.pageLimit)  }">
													</fmt:parseNumber>
													<li class="page-item"><a class="page-link"
															href="/hotel/mypage/question?pageNum=${test}"
															tabindex="-1">&laquo;</a></li>
												</c:if>
												<!--active-->
												<c:forEach var="i" begin="${pageCalc.startPage }"
													end="${pageCalc.endPage}" step="1">
													<c:if test="${i == pageCalc.pageData.pageNum}">
														<li class="page-item active"><a class="page-link"
																href="/hotel/mypage/question?pageNum=${i}">${i}</a></li>
													</c:if>
													<c:if test="${i!=pageCalc.pageData.pageNum }">
														<li class="page-item"><a class="page-link"
																href="/hotel/mypage/question?pageNum=${i}">${i}</a></li>
													</c:if>
												</c:forEach>

												<c:if test="${pageCalc.next == true}">
													<li class="page-item"><a class="page-link"
															href="/hotel/mypage/question?pageNum=${(pageCalc.startPage*10)+1}">&raquo;
														</a></li>
												</c:if>
											</ul>
										</nav>
										<input type="hidden" id="pageNum" value="${pageCalc.pageData.pageNum}" />

									</div>
								</c:if>
							</div>
						</div>

					</div>
				</div>
				<jsp:include page="../main/footer.jsp" />
			</body>

			<script src="/hotel/static/project_js/MyPage_Js/mypage_question_check.js"></script>

			</html>