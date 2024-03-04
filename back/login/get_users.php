<?php

include "config.php";

// Get the user ID of the logged-in user
$user_id = $_SESSION['username'];

// Query database for logged-in user
$sql = "SELECT * FROM user WHERE user_id = $user_id";
$result = mysqli_query($connect, $sql);

if (!$result) {
  die('Error querying database: ' . mysqli_error($connect));
}

// Build array of logged-in user data
$user_data = array();
if ($row = mysqli_fetch_assoc($result)) {
  $user_data = array(
  
    'user_full_name' => $row['user_full_name'],
    'user_mobile' => $row['user_mobile'],
    'user_email' => $row['user_email'],
    
  );
}

// Return logged-in user data as JSON
header('Content-Type: application/json');
echo json_encode(array('user' => $user_data));

// Close database connection
mysqli_close($connect);
