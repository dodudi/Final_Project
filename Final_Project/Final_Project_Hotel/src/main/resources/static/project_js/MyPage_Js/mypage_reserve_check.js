function breakFastOpt(data, date, optStr) {
    console.log(date);
    let adult = 0;
    let child = 0;
    if (typeof data != "undefined") {
        adult = data["ADULT"];
        child = data["CHILD"];
    } 

    document.getElementById(optStr).innerHTML =
        "<tbody><tr><td colspan='5' class='content-sub-title'>Dinner</td>" +
        "<c:forEach var='dinner' items='${optDinner}'>" +
        "<tr><td rowspan='2'>" + date + "</td><td>성인</td><td>" + adult + "</td></tr>" +
        "<tr><td>아동</td><td>" + child + "</td></tr>" +
        "</c:forEach>" +
        "</tbody>";
}

$(document).ready(function () {



    var token = document.getElementById("_csrf").getAttribute("th:content");
    var header = $("meta[name='_csrf_header']").attr("th:content");
    console.log(token);

    $(document).ajaxSend(function (e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });

    $("#checkFilter").on("change", function () {
        var selectForm = document.getElementById("checkFilter");
        console.log(selectForm.value);
        $.ajax({
            type: "POST",
            url: "/hotel/mypage/dateCheck",
            data: JSON.stringify({ date: selectForm.value }),
            contentType: "application/json;charset=UTF-8",
            beforeSend: function (xhr) {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader(header, token);
            },
            success: function (data) {
                console.log(data);
                console.log(selectForm.value);
                let optBreakFast = "optBreakFast";
                let optDinner = "optDinner";
                breakFastOpt(data[optBreakFast], selectForm.value, optBreakFast);
                breakFastOpt(data[optDinner], selectForm.value, optDinner);
            }
        }).done(function (data) {
            alert(data);
        });
    })
})


