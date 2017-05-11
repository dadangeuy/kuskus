<?php
	session_start();
	if(isset($_SESSION['id_user'])) header("Location: /home.php");
	require_once('api.php');
?>

<!doctype html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

    <title>Kuskus - Social Media</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
 
    <!-- Custom Google Web Font -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Lato:100,300,400,700,900,100italic,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Arvo:400,700' rel='stylesheet' type='text/css'>
	
    <!-- Custom CSS-->
    <link href="css/general.css" rel="stylesheet">
	
	 <!-- Owl-Carousel -->
    <link href="css/custom.css" rel="stylesheet">
	<link href="css/owl.carousel.css" rel="stylesheet">
    <link href="css/owl.theme.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/animate.css" rel="stylesheet">
	
	<!-- Magnific Popup core CSS file -->
	<link rel="stylesheet" href="css/magnific-popup.css"> 
	
	<!-- Modernizr /-->
	<script src="js/modernizr-2.8.3.min.js"></script>

	<!-- switch -->
	<link href="css/switch.css" rel="stylesheet">
	
</head>

<body id="home">

	<!-- Preloader -->
	<div id="preloader">
		<div id="status"></div>
	</div>
	
	<!-- FullScreen -->
    <div class="intro-header">
		<div class="col-xs-12 text-center abcen1">
			<h1 class="h1_home wow fadeIn" data-wow-delay="0.4s">KusKus</h1>
			<h3 class="h3_home wow fadeIn" data-wow-delay="0.6s">A Free Social Media Network</h3>
			<ul class="list-inline intro-social-buttons">
				<li><a href="#signup" class="btn  btn-lg mybutton_cyano wow fadeIn" data-wow-delay="0.8s"><span class="network-name">Sign Up</span></a>
				</li>
				<li id="download" ><a href="#login" class="btn  btn-lg mybutton_standard wow swing wow fadeIn" data-wow-delay="1.2s"><span class="network-name">Log In</span></a>
				</li>
			</ul>
		</div>    
		<div class="col-xs-12 text-center abcen wow fadeIn">
			<div class="button_down "> 
				<a class="imgcircle wow bounceInUp" data-wow-duration="1.5s"  href="#login"> <img class="img_scroll" src="img/icon/circle.png" alt=""> </a>
			</div>
		</div>
    </div>
	
	<div id="login" class="content-section-c ">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-offset-3 text-center white">
					<h2>Welcome!</h2>
					<p class="lead" style="margin-top:0">Ready to capture & share a moment with people around the world</p>
				</div>
				<div class="col-md-6 col-md-offset-3 text-center">
					<div class="mockup-content">
							<div class="morph-button wow pulse morph-button-inflow morph-button-inflow-1">
								<button type="button"><span>Log In with Email Address</span></button>
								<div class="morph-content">
									<div>
										<div class="content-style-form content-style-form-4 ">
											<h2 class="morph-clone">Log In with Email Address</h2>
											<form role="form" action="" method="post" >
												<p><label>Your Email Address</label>
												<input type="email" id="email" name="email" required /></p>
												<p><label>Your Password</label>
												<input type="password" id="pass" name="pass" required /></p>
												<p><input type="submit" name="login" id="login" value="Log In"></p>
											</form>
										</div>
									</div>
								</div>
							</div>
					</div>
				</div>
				<?php
					if(isset($_SESSION['attempt'])){
						$attempt = "<div class=\"col-md-6 col-md-offset-3 text-center white\"><p style=\"margin-top:0\">Failed Login Attempt: $_SESSION[attempt]</p> </div>";
						echo $attempt;
					}
				?>
			</div>
		</div>
	</div>	
	
	<!-- Contact -->
	<div id="signup" class="content-section-a">
		<div class="container">
			<div class="row">
			
			<div class="col-md-6 col-md-offset-3 text-center wrap_title">
				<h2>Join with us!</h2>
				<p class="lead" style="margin-top:0">It's Fast & Free</p>
			</div>
			
			<div class="col-md-6 col-md-offset-3 text-center wrap_title">
				<form role="form" action="" method="post" >
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control" id="name" name="name" placeholder="Enter Name" maxlength="64" required >
							<span class="input-group-addon"><i class="glyphicon glyphicon-ok form-control-feedback"></i></span>
						</div>
					</div>
					
					<div class="form-group">
						<div class="input-group">
							<input type="email" class="form-control" id="email" name="email" placeholder="Enter Email" maxlength="64" required >
							<span class="input-group-addon"><i class="glyphicon glyphicon-ok form-control-feedback"></i></span>
						</div>
					</div>
					
					<div class="form-group">
						<div class="input-group">
							<input type="password" class="form-control" id="pass" name="pass" placeholder="Enter Password" maxlength="32" required >
							<span class="input-group-addon"><i class="glyphicon glyphicon-ok form-control-feedback"></i></span>
						</div>
					</div>
					
					<div class="cc-selector">
						<input id="male" type="radio" name="gender" value="M" required />
						<label class="drinkcard-cc male" for="male"></label>
						<input id="female" type="radio" name="gender" value="F" />
						<label class="drinkcard-cc female" for="female"></label>
					</div>
					
					<input type="submit" name="signup" id="signup" value="Sign Up" class="btn wow tada btn-embossed btn-primary">
				</form>
					<?php
						if(isset($_SESSION['msg_signup'])){
							$echo =
							"<br/><div class=\"col-md-6 col-md-offset-3 text-center wrap_title\">
							<p class=\"lead\" style=\"margin-top:0\">$_SESSION[msg_signup]</p></div>";
							echo $echo;
						}
					?>
			</div>
			</div>
		</div>
	</div>
	
    <footer>
      <div class="container">
        <div class="row">
          <div class="col-md-7">
            <h3 class="footer-title">About Kuskus</h3>
            <p>Kuskus (abbreviation of KusukKusuk)<br/>
              Is a social media platform to connect people around the world<br/>
			  Developed by Irsyad Rizaldi, Nuzul Ristyantika Yuliana and Azizah<br/>
			  It's primary purpose is for Database Management Class Final Project<br/>
            </p>
			<br/>
        </div>
      </div>
    </footer>

    <!-- JavaScript -->
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.js"></script>
	<script src="js/owl.carousel.js"></script>
	<script src="js/script.js"></script>
	
	<!-- StikyMenu -->
	<script src="js/stickUp.min.js"></script>
	<script type="text/javascript">
		jQuery(function($) {
			$(document).ready( function() {
				$('.navbar-default').stickUp();
			});
		});
	</script>
	
	<!-- Smoothscroll -->
	<script type="text/javascript" src="js/jquery.corner.js"></script> 
	<script src="js/wow.min.js"></script>
	<script>
	 new WOW().init();
	</script>
	<script src="js/classie.js"></script>
	<script src="js/uiMorphingButton_inflow.js"></script>
	
	<!-- Magnific Popup core JS file -->
	<script src="js/jquery.magnific-popup.js"></script> 
</body>
</html>
<?php closeDB(); ?>
