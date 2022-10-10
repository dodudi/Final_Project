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
	$('input[name=id]').on('keyup',function() {		
		$("#idck").empty();		
	
		var pattern = /^\w{5,12}$/;
		var id = $("input[name=id]").val();
		if(!pattern.test(id)) {
			$("#idck").css('color', 'red')
						.html("영문(소문자),숫자 포함 5~12자리 입력해주세요 ");
			checkid=false;
			return;
		}
		$.ajax({
			url : "idcheck",
			data : {"id" : id},
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
	});//input[name=id] end 
	
	//passCk
	$('input[name=password]').on('keyup',function() {
		$("#passCk").empty();
		
		var pattern = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[!@#$%^&*?~]).{8,16}$/;
		var password = $("input[name=password]").val();
		if(!pattern.test(password)) {
			$("#passCk").css('color', 'red')
						.html("영문(소문자),숫자,특수기호(!,@,#,$,%,^,&,*,?,~)포함 8~12자리 입력해주세요");
			checkpw=false;
		} 
	});
	
	//passCk2
	$('input[name=password2]').on('keyup',function(){
		var pass =  $("input[name=password]").val();
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
	$('input[name=email]').on('keyup', function(){
		$("#emailCk").empty();
		
		var pattern = /^\w+@\w+[.]\w{3}$/;
		var email = $("input[name=email]").val();
		if (!pattern.test(email)) {
			$("#emailCk").css('color', 'red').html("이메일 형식이 맞지 않습니다.");
			checkemail=false;
		} else {
			$("#emailCk").css('color','green').html("이메일 형식에 맞습니다.");
			checkemail=true;
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
			$("input[name=id]").val('').focus();
			return false;
		}
		
		if(!checkemail){
			alert("email 형식을 확인하세요");
			$("input[name=email]").val('').focus();
			return false;
		}
	
	});//submit end 
	
});
