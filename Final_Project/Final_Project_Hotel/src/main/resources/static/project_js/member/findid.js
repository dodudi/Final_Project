var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");


$(function(){

//--------- change color value of the form text/password inputs -----

  const textInputs =  $("input[type='textbox']");
  const passwordsInputs =  $("input[type='password']");
  //--------- Login screen swicth -----

    $("button").click(function(event){  //  prevent buttons in form to reload
        event.preventDefault();
    });
    
    $("a").click(function(event){  //  prevent 'a' links in form to reload
        event.preventDefault();
    });
	
	//tab
	$(".tabpw").on('click', function() {
	  location.href="findpw";
	  $(this).fadeIn(600);
	});
	
	$(".tabid").click(function(){
		location.reload();
	});
	
	//emailCk
	$('input[name=MEM_EMAIL]').on('keyup', function(){
		$("#emailConfirm").empty();
		
		var pattern = /^\w+@\w+[.]\w{3}$/;
		var email = $("input[name=MEM_EMAIL]").val();
		if (!pattern.test(email)) {
			$("#emailCk").css('color', 'red').html("이메일 형식이 맞지 않습니다.");
		} else {
			$("#emailCk").css('color','green').html("이메일 형식에 맞습니다.");
		}
	});//input[name=MEM_EMAIL] end
	
	$("#findform-submit-id").click(function(){
		var name = $("input[name=MEM_NAME]").val();
		var email = $("input[name=MEM_EMAIL]").val();
		
		$.ajax({
			type:"POST",
			url: "findidProcess",
			data:{"MEM_NAME": name, "MEM_EMAIL": email},
			dataType:"json",
			beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
			},
			success:function(data){
				console.log("data 성공(findid) : " + data.message);
				
				if(data.mem_id != null){
					$(".findIdArea").remove();
					var output = '';
					output += '<h3>고객님의 아이디를 찾았습니다.</h3>'
					output += '<h3>아이디 : '+ data.mem_id +'</h3>'
					output += '<input type="submit" id="findform-submit-login" '
					output += 'class="find_form button" value="로그인" >'
					
					$("#findid").append(output);
				}else {
					alert("아이디가 존재하지않습니다.\n 다시 확인해주세요.");
				}
			},
			error:function(data){
				console.log("data error(findid) : " + data.error);
				alert("가입하신 이름과 이메일을 확인해주세요.");
			}
		})
	});//findform-submit-id end;
	
	$("#findid").on('click','#findform-submit-login',(function(){
		location.href="../member/login";
	}));//로그인화면이동 완료
	
	
	
});
