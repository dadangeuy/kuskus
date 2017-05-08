<?php
	session_start();
	if(!isset($_GET['id_user']) && isset($_SESSION['id_user']))
		header("Location: /php/profile.php?id_user=$_SESSION[id_user]");
	else if(!isset($_GET['id_user']) && !isset($_SESSION['id_user']))
		header("Location: /");
	else{
		require_once('dbconnect.php');
		$result = $db->query("CALL get_user($_GET[id_user]);");
		$row = $result->fetch_assoc();
		print_r($row);
		$db->close();
	}
?>