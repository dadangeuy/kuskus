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

    <title>Kuskus – Home</title>

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
	
	<?php $user = user_info($_SESSION['id_user']);	?>
	<div id="caption" class="content-section-a">
		<div class="container">
			<div class="row">
				<div class="col-md-3 address text-center">
					<address>
					<img class="rotate img-circle" src="<?php echo $user['avatar']; ?>" alt="Profile Picture" style="width:128px;height:128px;">
					<h3 style="margin-top:10px"><?php echo $user['name']; ?></h3>
					</address>
				</div>
				
				<hr class="featurette-divider hidden-lg">
				<form role="form" action="" method="post" >
					<div class="col-md-7">
						<div class="form-group">
							<div class="input-group">
								<textarea name="caption" id="caption" class="form-control" rows="4" placeholder="What's on your mind, <?php echo $user['name']; ?>?" required></textarea>
								<span class="input-group-addon"><i class="glyphicon glyphicon-ok form-control-feedback"></i></span>
							</div>
						</div>

						<input type="submit" name="post" id="post" value="post" class="btn wow tada btn-embossed btn-primary pull-right">
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<div id="post" class="content-section-b" style="border-top: 0">
		<div class="container">
			<?php
				$post = post_inhome($_SESSION['id_user']);
				for($i=0; $i<count($post); $i++){
					$user = user_info($post[$i]['id_user']);
					$cpost = $post[$i];
					$echo =
						"<div class=\"row\" style=\"margin-top:20px;\">			
							<div class=\"col-sm-2 wow bounceIn text-right\">
								<a href=\"profile.php?id=$user[id]\">
									<img class=\"img-circle\" src=\"$user[avatar]\" style=\"width: 128px; length:128px;\">
								</a>
							</div>
							
							<div class=\"col-sm-8 wow bounceIn text-left\">
								<a href=\"profile.php?id=$user[id]\">
									<h3 style=\"margin-top:0;\">$user[name]</h3>
								</a>
								<a href=\"post.php?id=$cpost[id]\">
									<h6 style=\"margin-top:0;\">Posted on $cpost[upload]<h6>
									<p class=\"lead\" style=\"word-wrap:break-word;\">$cpost[caption]</p>
								</a>
							</div>
						</div>";
					echo $echo;
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