<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
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
        </head>

        <body>
            <jsp:include page="../main/header.jsp" />
            <div class = "mypage">
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

                    <div class="col-9 content-background ">
                        <div class="content-title">문의내역확인</div>
                        <div class="content-table mb-5">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td>글번호</td>
                                        <td>글제목</td>
                                        <td>작성자</td>
                                        <td>작성일</td>
                                        <td>답변상태</td>
                                    </tr>
                                    <c:forEach var="i" begin="1" end="4" step="1">
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
                                <ul class="pagination justify-content-center">
                                    <!--disable-->
                                    <li class="page-item">
                                        <a class="page-link" href="#" tabindex="-1">&laquo;</a>
                                    </li>
                                    <!--active-->
                                    <c:forEach var="i" begin="1" end="10" step="1">
                                        <c:if test="${i == 1}">
                                            <li class="page-item active"><a class="page-link" href="#">${i}</a></li>
                                        </c:if>
                                        <c:if test="${i!=1 }">
                                            <li class="page-item"><a class="page-link" href="#">${i}</a></li>
                                        </c:if>
                                    </c:forEach>
                                    <li class="page-item">
                                        <a class="page-link" href="#">&raquo;</a>
                                    </li>
                                </ul>
                            </nav>

                         
                        </div>
                    </div>
                </div>

            </div>
            </div>
            <jsp:include page="../main/footer.jsp" />
        </body>

        </html>