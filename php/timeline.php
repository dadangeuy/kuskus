<?php
	session_start();
	if(!isset($_SESSION['id_user'])) header("Location: /");
	else{
		require_once('dbconnect.php');
		$result = $db->query("CALL get_timeline($_SESSION[id_user]);");
		while($row = $result->fetch_assoc()){
			print_r($row);
			echo '</br>';
		}
		$db->close();
	}
?>