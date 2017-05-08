<?php
	session_start();
	if(isset($_SESSION['id_user'])){
		$msg = "$_SESSION[email] logged out";
		session_destroy();
	}
	else $msg = 'no logged in user';
	print_r($msg);
	header('Refresh:2; URL=/');
	exit();
?>