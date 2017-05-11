<?php
	require_once('db_connect.php');
	#trigger
	if(isset($_POST['signup'])){
		unset($_POST['signup']);
		signup();
	}
	if(isset($_POST['login'])){
		unset($_POST['login']);
		login();
	}
	if(isset($_GET['logout'])){
		unset($_GET['logout']);
		logout();
	}
	if(isset($_POST['post'])){
		unset($_POST['post']);
		send_post($_SESSION['id_user'], $_POST['caption']);
	}
	if(isset($_POST['togFollow'])){
		unset($_POST['togFollow']);
		toggle_follow($_SESSION['id_user'], $_GET['id']);
	}
	
	#function
	function closeDB(){
		global $db;
		$db->close();
	}
	function signup(){
		global $db;
		$result = $db->query("CALL add_user('$_POST[name]', '$_POST[email]', '$_POST[pass]', '$_POST[gender]');");
		$db->close();
		$row = $result->fetch_assoc();
		if($row['errno'] == 0){
			unset($_SESSION['msg_signup']);
			header('Location: /#login');
		}
		else{
			$_SESSION['msg_signup'] = $row['msg'];
			header('Location: /#signup');
		}
	}
	function login(){
		global $db;
		$db->next_result();
		$result = $db->query("CALL verify_user('$_POST[email]', '$_POST[pass]');");
		if(!$result) echo $db;
		$row = $result->fetch_assoc();
		if($row['errno'] == 0){
			unset($_SESSION['attempt']);
			unset($_SESSION['msg_signup']);
			$_SESSION['id_user'] = $row['id_user'];
			header('Location: /home.php');
		}
		else{
			if(!isset($_SESSION['attempt'])) $_SESSION['attempt']=1;
			else $_SESSION['attempt']++;
			header('Location: /#login');
		}
	}
	function logout(){
		session_destroy();
		header('Location: /');
	}
	function user_info($id){
		global $db;
		$db->next_result();
		$result = $db->query("CALL get_user($id);");
		$row = $result->fetch_assoc();
		return $row;
	}
	function send_post($id, $caption){
		global $db;
		$db->next_result();
		$result = $db->query("CALL add_post($id, '$caption');");
		$crow = array();
		while($row = $result->fetch_assoc()) array_push($crow, $row);
		return $crow;
	}
	function post_inhome($id){
		global $db;
		$db->next_result();
		$result = $db->query("CALL get_home($id);");
		$crow = array();
		while($row = $result->fetch_assoc()) array_push($crow, $row);
		return $crow;
	}
	function post_inprofile($id){
		global $db;
		$db->next_result();
		$result = $db->query("CALL get_user_post($id);");
		$crow = array();
		while($row = $result->fetch_assoc()) array_push($crow, $row);
		return $crow;
	}
	function isFollowing($id, $id2){
		global $db;
		$db->next_result();
		$result = $db->query("CALL verify_follow($id, $id2);");
		$row = $result->fetch_assoc();
		if($row['errno'] == 0) return true;
		else return false;
	}
	function toggle_follow($id, $id2){
		global $db;
		if(isFollowing($id, $id2)){
			$db->next_result();
			$result = $db->query("CALL remove_follow($id, $id2);");
		}
		else{
			$db->next_result();
			$result = $db->query("CALL add_follow($id, $id2);");
		}
	}
	function search($keyword){
		global $db;
		$db->next_result();
		$result = $db->query("CALL search('$keyword');");
		$crow = array();
		while($row = $result->fetch_assoc()) array_push($crow, $row);
		return $crow;
	}
?>