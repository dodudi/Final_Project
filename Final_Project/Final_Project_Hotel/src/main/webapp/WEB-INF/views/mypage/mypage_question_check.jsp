<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
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

        <!--mypage_question_check.css-->
		<link rel="stylesheet" href="/hotel/static/project_css/mypage/mypage_module.css">
    </head>

    <body>
        <jsp:include page="../main/header.jsp" />

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
                                src="/hotel/static/project_image/mypage_icon/QuestionCheck.png" width="25px" alt="" />
                            문의내역확인
                        </a>
                        <!--Coupon-->
                        <a href="/hotel/mypage/coupon" class="list-group-item list-group-item-action"> <img
                                src="/hotel/static/project_image/mypage_icon/Coupon.png" width="25px" alt="" /> 마일리지 |
                            쿠폰
                        </a>
                        <!--member-->
                        <a href="/hotel/mypage/member" class="list-group-item list-group-item-action"> <img
                                src="/hotel/static/project_image/mypage_icon/MemberCheck2.png" width="25px" alt="" />
                            회원정보
                        </a>
                        <a href="/hotel/mypage/wishBoard" class="list-group-item list-group-item-action"> <img
                                src="/hotel/static/project_image/mypage_icon/CheckList.png" width="25px" alt="" /> 즐겨찾기
                            게시물 확인
                        </a>
                    </div>
                </div>
                <!--My Page Select Nav End-->

                <div class="col-9 content-background ">
                    <div class="content-title">객실예약정보</div>
                    <div class="content-table mb-5">
                        <table class="table">
                            <tbody>

                                <tr>
                                    <td>객실등급</td>
                                    <td>r</td>
                                </tr>
                                <tr>
                                    <td>예약자명</td>
                                    <td>r</td>
                                </tr>
                                <tr>
                                    <td>체크인 날짜</td>
                                    <td>r</td>
                                </tr>
                                <tr>
                                    <td>체크아웃 날짜</td>
                                    <td>r</td>
                                </tr>
                                <tr>
                                    <td>총 숙박일</td>
                                    <td>r</td>
                                </tr>
                                <tr>
                                    <td>성인</td>
                                    <td>r</td>
                                </tr>
                                <tr>
                                    <td>아동</td>
                                    <td>r</td>
                                </tr>
                                <tr>
                                    <td>총 금액</td>
                                    <td>r</td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="clearfix btn-box">
                            <button type="button" class="btn btn-primary">옵션변경하기</button>
                            <button type="button" class="btn btn-danger">옵션변경하기</button>
                        </div>
                    </div>

                    <div class="content-title">조식|디너 예약 정보</div>
                    <div class="content-table">
                        <table class="table">
                            <tbody>

                                <tr>
                                    <td rowspan="4">조식</td>
                                    <td>날짜</td>
                                    <td>1일</td>
                                    <td>2일</td>
                                    <td>3일</td>
                                </tr>
                                <tr>
                                    <td>성인</td>
                                    <td>0명</td>
                                    <td>0명</td>
                                    <td>0명</td>
                                </tr>
                                <tr>
                                    <td>아동</td>
                                    <td>0명</td>
                                    <td>0명</td>
                                    <td>0명</td>
                                </tr>
                                <tr>
                                    <td>총금액</td>
                                    <td>0원</td>
                                    <td>0원</td>
                                    <td>0원</td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="clearfix btn-box">
                            <button type="button" class="btn btn-primary">옵션변경하기</button>
                            <button type="button" class="btn btn-danger">옵션변경하기</button>
                        </div>
                    </div>
                    <div class="content-table">
                        <table class="table">
                            <tbody>

                                <tr>
                                    <td colspan="5">석식</td>
                                </tr>
                                <tr>
                                    <td rowspan="3">2022/02/22</td>
                                    <td>성인</td>
                                    <td>0명</td>
                                </tr>
                                <tr>
                                    <td>아동</td>
                                    <td>0명</td>
                                </tr>
                                <tr>
                                    <td>총금액</td>
                                    <td>0원</td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="clearfix btn-box">
                            <button type="button" class="btn btn-primary">옵션변경하기</button>
                            <button type="button" class="btn btn-danger">옵션변경하기</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <jsp:include page="../main/footer.jsp" />
    </body>

    </html>