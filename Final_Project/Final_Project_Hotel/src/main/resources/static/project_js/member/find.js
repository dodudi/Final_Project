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
	$('.tab a').on('click', function (e) {
  
	  e.preventDefault();
	  
	  $(this).parent().addClass('active');
	  $(this).parent().siblings().removeClass('active');
	  
	  target = $(this).attr('href');
	
	  $('.tab-content > div').not(target).hide();
	  
	  $(target).fadeIn(600);
	  
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
	
	//이메일 인증 
	var code = "";
	$("#emailCkNum").click(function(){
		var email = $("input[name=MEM_EMAIL]").val();
		
		$.ajax({
			type : "POST",
			url : "mailCheck",
			data:{"MEM_EMAIL" : email},
			dataType : "json",
			beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
			},
			success:function(data){
				console.log("data 성공(email) : " + data.serial);
				
			  if(data.message == "success"){
			 	alert("인증번호가 발송되었습니다. \n 인증번호를 확인해주세요.");
			  	$('#emailConfirm').attr("disabled", false);
		  		$('.successEmailck').text("인증번호 확인 후 인증확인을 눌러주세요.")
		  					.css("color", "orange");
		  		code = data.serial;
			  } else {
		  		alert("이메일 주소가 올바르지 않습니다. 유효한 이메일 주소를 입력해주세요.");
			  	$('input[name=MEM_EMAIL]').attr("autofocus", true);
			  	$('.successEmailck').text("유효한 이메일 주소를 입력해주세요")
			  					.css("color", "red");
			  }
			},
			error:function(data){
				alert("회원가입 에러 발생!");
				console.log("data error(email) : " + data);
			}
		})
		
	});//emailCkNum end;
	
	//이메일 인증번호 이중체크 
	$("#emailCkNum2").click(function(){
		if($("#emailConfirm").val() == code){
			$(".successEmailck").text("인증번호가 일치합니다.")	
								.css("color", "green");
			$("#emailDoubleCk").val("true");
			$("#emailConfirm").attr("disabled", true);
		}else{
			$(".successEmailck").text("인증번호가 일치하지않습니다.확인해주세요.")	
								.css("color", "red");
			$("#emailDoubleCk").val("false");
			$("#emailConfirm").attr("autofocus", true);
		}
	});//emailCkNum2 end;
	
	$("#findform-submit-submitId").click(function(){
		var name = $("input[name=MEM_NAME]").val();
		var email = $("input[name=MEM_EMAIL]").val();
		
		$.ajax({
			type:"POST",
			url: "findId",
			data:{"MEM_NAME": name, "MEM_EMAIL": email},
			dataType:"json",
			beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
			},
			success:function(data){
				console.log("data 성공(findid) : " + data.mem_id);
				
				if(data.mem_id != null){
					$(".findIdArea").remove();
					var output = '';
					output += '<h3>고객님의 아이디를 찾았습니다.</h3>'
					output += '<h3>아이디 : '+data.mem_id +'</h3>'
					output += '<input type="submit" id="findform-submit-login" '
					output += 'class="find_form button" value="로그인" >'
					
					$("#findid").append(output);
				}else {
					alert("아이디가 존재하지않습니다.\n 다시 확인해주세요.");
				}
			},
			error:function(data){
				console.log("data error(findid) : " + data);
			}
		})
	});//findform-submitId end;
	
	$("#findid").on('click','#findform-submit-login',(function(){
		location.href="../member/login";
	}))
});
