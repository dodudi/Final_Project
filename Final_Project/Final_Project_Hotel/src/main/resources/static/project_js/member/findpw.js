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
		location.reload();
	});
	
	$(".tabid").click(function(){
		 location.href="findid";
	 	 $(this).fadeIn(600);
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
	
});
