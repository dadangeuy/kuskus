<?php
	session_start();
	if(isset($_SESSION['id_user'])) $msg = 'already logged in';
	else if(isset($_POST['email']) && isset($_POST['pass'])){
		require_once('dbconnect.php');
		//verify email & password
		$query = "CALL verify_login('$_POST[email]', '$_POST[pass]');";
		$result = $db->query($query);
		$row = $result->fetch_assoc();
		$msg = $row['msg'];
		//if success
		if($row['errno'] == 0){
			$_SESSION['id_user'] = $row['id_user'];
			$_SESSION['email'] = $_POST['email'];
		}
		$db->close();
	}
	print_r($msg);
	header('Refresh:2; URL=/');
?>