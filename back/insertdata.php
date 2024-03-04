<?php 
	include "config.php";
	// REGISTER USER
	

	  
	    $name = mysqli_real_escape_string($connect, $_POST['login_name']);
	    $password = mysqli_real_escape_string($connect, $_POST['login_password']);
	  
	 
	        $query = "INSERT INTO login (login_name,login_password)
	  			  VALUES('$name', '$password')";
	    $results = mysqli_query($connect, $query);
	    if($results>0)
	    {
	        echo "user added successfully";
	    }
	    