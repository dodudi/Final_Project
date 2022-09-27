<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" href="static/image/favicon.png" type="image/png">
<title>Royal Hotel</title>
<link rel="stylesheet" href="static/project_css/member/login.css">
<script>
//Show/hide password onClick of button using Javascript only

//https://stackoverflow.com/questions/31224651/show-hide-password-onclick-of-button-using-javascript-only

function show() {
 var p = document.getElementById('pwd');
 p.setAttribute('type', 'text');
}

function hide() {
 var p = document.getElementById('pwd');
 p.setAttribute('type', 'password');
}

var pwShown = 0;

document.getElementById("eye").addEventListener("click", function () {
 if (pwShown == 0) {
     pwShown = 1;
     show();
 } else {
     pwShown = 0;
     hide();
 }
}, false);


</script>
</head>
<body>
	<div class="overlay">
  <!-- LOGN IN FORM by Omar Dsoky -->
  <form>
    <!--   con = Container  for items in the form-->
    <div class="con">
      <!--     Start  header Content  -->
      <header class="head-form">
        <h2>Log In</h2>
        <!--     A welcome message or an explanation of the login form -->
        <p>login here using your username and password</p>
      </header>
      <!--     End  header Content  -->
      <br />
      <div class="field-set">
        <!--   user name -->
        <span class="input-item">
          <i class="fa fa-user-circle"></i>
        </span>
        <!--   user name Input-->
        <input class="form-input" id="txt-input" type="text" placeholder="@UserName" required />

        <br />

        <!--   Password -->

        <span class="input-item">
          <i class="fa fa-key"></i>
        </span>
        <!--   Password Input-->
        <input class="form-input" type="password" placeholder="Password" id="pwd" name="password" required />

        <!--      Show/hide password  -->
        <span>
          <i class="fa fa-eye" aria-hidden="true" type="button" id="eye"></i>
        </span>

        <br />
        <!--        buttons -->
        <!--      button LogIn -->
        <button class="log-in">Log In</button>
      </div>

      <!--   other buttons -->
      <div class="other">
        <!--      Forgot Password button-->
        <button class="btn submits frgt-pass">Forgot Password</button>
        <!--     Sign Up button -->
        <button class="btn submits sign-up">
          Sign Up
          <!--         Sign Up font icon -->
          <i class="fa fa-user-plus" aria-hidden="true"></i>
        </button>
        <!--      End Other the Division -->
      </div>

      <!--   End Conrainer  -->
    </div>

    <!-- End Form -->
  </form>
</div>
	
</body>
</html>