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
    
    
   
});
	
	
