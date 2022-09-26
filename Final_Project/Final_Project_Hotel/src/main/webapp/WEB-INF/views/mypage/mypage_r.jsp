<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <title>Document</title>
        <link rel="stylesheet" href="static/css/bootstrap.min.css">
        <link rel="stylesheet" href="static/project_css/mypage/mypage_r.css">
    </head>

    <body>


        <div class="container mypage_background">
            <div class="row">
                <div class="col-3 nav-background">
                    <div class="nav-title">마이페이지</div>
                    <div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action active">
                            <img src="static/project_image/mypage_icon/ReservationCheckIcon.png" width="25px" alt="" />
                            객실예약확인
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <img src="static/project_image/mypage_icon/QuestionCheck.png" width="25px" alt="" />
                            문의내역확인
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <img src="static/project_image/mypage_icon/Coupon.png" width="25px" alt="" />
                            마일리지 | 쿠폰
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <img src="static/project_image/mypage_icon/MemberCheck2.png" width="25px" alt="" />
                            회원정보
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <img src="static/project_image/mypage_icon/CheckList.png" width="25px" alt="" />
                            즐겨찾기 게시물 확인
                        </a>
                    </div>

                </div>

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
    </body>

    <script src="static/js/bootstrap.bundle.min.js"></script>


    </html>