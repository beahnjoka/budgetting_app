<?php
	$username="root";//change username 
	$password=""; //change password
	$host="localhost";
	$db_name="project"; //change databasename
	

	$connect=mysqli_connect($host,$username,$password,$db_name);
	

	if(!$connect)
	{
		echo json_encode("Connection Failed");
	}

