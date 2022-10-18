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

    $("#sign_up").click(function(){ 
       location.href="../member/join";
    });
    
    $("#login-form-submit").click(function() {
    	if("${loginfail}" == "loginFailMsg"){
    	alert("아이디 또는 비밀번호가 일치하지 않습니다.");
    	}
    });
    
    $("#lost-id-link").click(function(){
    	location.href="../member/findid";
    });
      
     $("#lost-password-link").click(function(){
    	location.href="../member/findpw";
    });
    
    // 로그인하지 않거나 만료된 경우
    if('${state}' == 'emptyId'){
      alert("본 서비스는 회원만 가능합니다.");
   }
    
});
	
	
