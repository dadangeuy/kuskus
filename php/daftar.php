<?php
	require_once('dbconnect.php');
	if(isset($_POST['name']) && isset($_POST['email']) && isset($_POST['pass'])){
		$db->next_result();
		$result = $db->query("CALL add_user('$_POST[name]', '$_POST[email]', '$_POST[pass]');");
		$row = $result->fetch_assoc();
		$msg=$row['msg'];
	}
	print_r($msg);
	$db->close();
	header('Refresh:2; URL=/');
?>