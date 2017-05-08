<?php
	session_start();
	if(!isset($_SESSION['id_user'])){
		header("Location: /");
	}
	else{
		require_once('dbconnect.php');
		$result = $db->query("CALL get_notification($_SESSION[id_user]);");
		while($row = $result->fetch_assoc()){
			#print_r($row);
			#echo '</br>';
			$db->next_result();
			$result2 = $db->query("CALL get_post($row[id_post]);");
			$row2 = $result2->fetch_assoc();
			print_r($row2);
			echo '</br>';
		}
		$db->close();
	}
?>