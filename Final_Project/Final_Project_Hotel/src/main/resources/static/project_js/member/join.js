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

    $("button").hover(function(){
    	$(".button2").css('cursor', ' default');
    });
    
    //id ck/pw/email
	var checkid = false;
	var checkpw = false;
	var checkemail = false;
 	   
	//idck
	$('input[name=MEM_ID]').on('keyup',function() {		
		$("#idck").empty();		
	
		var pattern = /^\w{5,12}$/;
		var id = $("input[name=MEM_ID]").val();
		if(!pattern.test(id)) {
			$("#idck").css('color', 'red')
						.html("영문(소문자),숫자 포함 5~12자리 입력해주세요 ");
			checkid=false;
			return;
		}
		$.ajax({
			url : "idcheck",
			data : {"MEM_ID" : id},
			success : function(resp) {
				if (resp == -1) {
					$("#idck").css('color', 'green').html("사용 가능한 아이디 입니다.");
					checkid=true;
				} else {
					$("#idck").css('color', 'royalblue').html("사용중인 아이디 입니다.");
					checkid=false;
				}
			}
		});//ajax end
	});//input[name=mem_id] end 
	
	//passCk
	$('input[name=MEM_PASS]').on('keyup',function() {
		$("#passCk").empty();
		
		var pattern = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[!@#$%^&*?~]).{8,16}$/;
		var password = $("input[name=MEM_PASS]").val();
		if(!pattern.test(password)) {
			$("#passCk").css('color', 'red')
						.html("영문(소문자),숫자,특수기호(!,@,#,$,%,^,&,*,?,~)포함 8~12자리 입력해주세요");
			checkpw=false;
		} 
	});
	
	//passCk2
	$('input[name=password2]').on('keyup',function(){
		var pass =  $("input[name=MEM_PASS]").val();
		var passck = $("input[name=password2]").val();
		
		if(passck == pass) {
			$("#passCk2").css('color', 'green').text("비밀번호가 일치합니다.");
			$("#pwDoubleCk").val("true");
		}else {
			$("#passCk2").css('color', 'red').text("비밀번호가 일치하지 않습니다.");
			$("#pwDoubleCk").val("false");
		}	
	});
	
	//emailCk
	$('input[name=MEM_EMAIL]').on('keyup', function(){
		$("#emailConfirm").empty();
		
		var pattern = /^\w+@\w+[.]\w{3}$/;
		var email = $("input[name=MEM_EMAIL]").val();
		if (!pattern.test(email)) {
			$("#emailCk").css('color', 'red').html("이메일 형식이 맞지 않습니다.");
			checkemail=false;
		} else {
			$("#emailCk").css('color','green').html("이메일 형식에 맞습니다.");
			checkemail=true;
		}
	});
	
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
				console.log("data 성공 : " + data);
				
			  if(data.message == "success"){
			 	alert("인증번호가 발송되었습니다. \n 인증번호를 확인해주세요.");
			  	$('#emailConfirm').attr("disabled", false);
		  		$('.successEmailck').text("인증번호를 입력한 뒤 인증확인버튼을 눌러주세요.")
		  					.css("color", "green");
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
				console.log("data error : " + data);
			}
		})
		
	})
	
	$("#emailCkNum2").click(function(){
		if($("#emailConfirm").val() == code){
			$(".successEmailck").text("인증번호가 일치합니다.")	
								.css("color", "green");
			$("#emailDoubleCk").val("true");
			$("#emailConfirm").attr("disabled", true);
		}else{
			$(".successEmailck").text("인증번호가 일치하지않습니다. 확인해주세요.")	
								.css("color", "red");
			$("#emailDoubleCk").val("false");
			$("#emailConfirm").attr("autofocus", true);
		}
	})
	
	//checkbox
	$('input[name=ckbox1]').click(function() {
		$("#errbox1").empty();
		if(!($(this).prop("checked"))){
			$("#errbox1").css('color','orange').html("*멤버십 가입을 위해서는 동의하셔야 합니다");
		}
	})
	$('input[name=ckbox2]').click(function() {
		$("#errbox2").empty();
		if(!($(this).prop("checked"))){
			$("#errbox2").css('color','orange').html("*멤버십 가입을 위해서는 동의하셔야 합니다");
		}
	})
	$('input[name=ckbox3]').click(function() {
		$("#errbox3").empty();
		if(!($(this).prop("checked"))){
			$("#errbox3").css('color','orange').html("*멤버십 가입을 위해서는 동의하셔야 합니다");
		}
	})
	

	
	//submit
	$('form').submit(function() {
		if(!checkid) {
			alert("사용가능한 id로 입력하세요.");
			$("input[name=MEM_ID]").val('').focus();
			return false;
		}
		
		if(!checkemail){
			alert("email 형식을 확인하세요");
			$("input[name=MEM_EMAIL]").val('').focus();
			return false;
		}
	
	});//submit end 
	
});
