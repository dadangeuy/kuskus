<?php
	$db_host = 'localhost';
	$db_user = 'root';
	$db_pass = '';
	$db_name = 'yzjvincb_kuskus';
	$db = mysqli_connect($db_host, $db_user, $db_pass, $db_name);
	if(!$db) die('Can\'t connect to Database Server');
?>