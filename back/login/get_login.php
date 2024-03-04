<?php
include "config.php";

// Query database for accounts
$sql = 'SELECT * FROM login';
$result = mysqli_query($connect, $sql);

if (!$result) {
  die('Error querying database: ' . mysqli_error($connect));
}

// Build array of accounts
$login = array();
while ($row = mysqli_fetch_assoc($result)) {
  $login[] = array(
    
    'login_username' => $row['login_username'],
  
    
    
  );
}

// Return accounts as JSON
header('Content-Type: application/json');
echo json_encode(array('login' => $login));

// Close database connection
mysqli_close($conn);
?>
