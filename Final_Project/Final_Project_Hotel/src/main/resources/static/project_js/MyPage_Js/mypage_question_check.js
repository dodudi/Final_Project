function drawItem(itemLimit){
	let data =  "<tr><td>글번호</td><td>글제목</td><td>작성자</td><td>작성일</td><td>답변상태</td></tr>";

	for(let d = 1; d<=itemLimit; d++){
			data +=	"<tr><td>" + d + "</td><td>글제목</td><td>작성자</td><td>작성일</td><td>답변상태</td></tr>";			
	}
 
	 document.getElementById("itemBox").innerHTML = data;

}

function drawPage(pageCalc){
	let data = "";
	
	if(pageCalc.prev == true){
		let number = parseInt((pageCalc.startPage-1)/pageCalc.pageLimit) ;
		data+="<li class='page-item'><a class='page-link' href='/hotel/mypage/question?pageNum=" +number+ "' tabindex='-1'>&laquo;</a></li>";
	}
	
	for(let i = pageCalc.startPage; i<=pageCalc.endPage; i++){
		if(i == pageCalc.pageData.pageNum){
			data+= "<li class='page-item active'><a class='page-link' href='/hotel/mypage/question?pageNum="+ i + "'>"+ i +"</a></li>";
		}else{
			data+= "<li class='page-item'><a class='page-link' href='/hotel/mypage/question?pageNum="+ i + "'>"+ i +"</a></li>";
		}
	}
	
	if(pageCalc.next == true){
		let number = (pageCalc.startPage*10)+1;
		data+="<li class='page-item'><a class='page-link' href='/hotel/mypage/question?pageNum=" +number+ "'>&raquo; </a></li>";
	}
	history.replaceState({}, null, location.pathname);
	document.getElementById("pagination").innerHTML = data;
}
$(document).ready(function(){
    var token = document.getElementById("_csrf").getAttribute("th:content");
    var header = $("meta[name='_csrf_header']").attr("th:content");
    
    $("#itemLimitSelect").on("change", function(){
		let pageNum = document.getElementById("pageNum").value;
		let itemLimit = this.value;
		console.log(itemLimit);
	    $.ajax({
    		type: "POST",
    		url: "/hotel/mypage/listCountSet",
    		data: JSON.stringify({
    			'pageNum' : 1,
    			'itemLimit': $("#itemLimitSelect").val()
    		}),
    		contentType: "application/json;charset=UTF-8",
            beforeSend: function (xhr) {   
                xhr.setRequestHeader(header, token);
            },
            success: function (data) {
           		console.log(data);
           		let itemLimit = data["pageData"]["itemLimit"];
           		 drawItem(itemLimit);
           		 drawPage(data);
            }
	    }).done(function (data) {
            alert(data);
        });
    });
});





