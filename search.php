<?php
	session_start();
	require_once('api.php');
?>

<!doctype html>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="Flatfy Free Flat and Responsive HTML5 Template ">
    <meta name="author" content="">

    <title>Kuskus – Search</title>

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
</head>

<body id="home">

	<!-- Preloader -->
	<div id="preloader">
		<div id="status"></div>
	</div>
	
	<!-- NavBar-->
	<nav class="navbar-default" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/">Kuskus</a>
			</div>
			<div class="col-sm-3 col-md-3" style="margin-top:4px;">
				<form class="navbar-form" role="search" method="get" action="search.php">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Find People" name="search">
						<div class="input-group-btn">
							<button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
						</div>
					</div>
				</form>
			</div>  

			<div class="collapse navbar-collapse navbar-right navbar-ex1-collapse">
				<ul class="nav navbar-nav">
					<li class="menuItem"><a href="home.php">Home</a></li>
					<li class="menuItem"><a href="profile.php?id=<?php echo $_SESSION['id_user'] ?>">Profile</a></li>
					<li class="menuItem"><a href="notification.php">Notification</a></li>
					<li class="menuItem"><a href="/?logout=1">Log Out</a></li>
				</ul>
			</div>
		</div>
	</nav> 
	
	<div id="post" class="content-section-b" style="border-top: 0">
		<div class="container">
			<?php
				$sres = search($_GET['search']);
				for($i=0; $i<count($sres); ){
					echo "<div class=\"row\" style=\"margin-top:10px;\">";
					for($j=0; $j<3 && $i<count($sres); $j++, $i++){
						$user = $sres[$i];
						$echo =
							"<a href=\"profile.php?id=$user[id]\">
							<div class=\"col-sm-1 wow bounceIn text-right\">
								<img src=\"$user[avatar]\" style=\"width: 64px; length:64px;\">
							</div>
							<div class=\"col-sm-3 wow bounceIn text-left\">
								<h4 style=\"margin-top:10px;margin-bottom:5px;\">$user[name]</h4>
								<h6 style=\"margin-top:0px;\">$user[email]<h6>
							</div>
							</a>";
						echo $echo;
					}
					echo "</div>";
				}
			?>
		</div>
	</div>
	
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