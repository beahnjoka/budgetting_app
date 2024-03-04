<?php
include "config.php";

// Query database for accounts
$sql = 'SELECT * FROM user';
$result = mysqli_query($connect, $sql);

if (!$result) {
  die('Error querying database: ' . mysqli_error($connect));
}

// Build array of accounts
$users = array();
while ($row = mysqli_fetch_assoc($result)) {
  $users[] = array(
    'user_id' => $row['user_id'],
    'user_full_name' => $row['user_full_name'],
    'user_mobile' => $row['user_mobile'],
    'user_email' => $row['user_email'],
    'user_login_id' => $row['user_login_id'],
    
  );
}

// Return accounts as JSON
header('Content-Type: application/json');
echo json_encode(array('user' => $users));

// Close database connection
mysqli_close($conn);
?>
