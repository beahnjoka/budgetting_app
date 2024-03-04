<?php
include "config.php";

// Query database for accounts
$sql = 'SELECT * FROM accounts';
$result = mysqli_query($connect, $sql);

if (!$result) {
  die('Error querying database: ' . mysqli_error($connect));
}

// Build array of accounts
$accounts = array();
while ($row = mysqli_fetch_assoc($result)) {
  $accounts[] = array(
    'account_id' => $row['account_id'],
    'account_name' => $row['account_name'],
    'account_desc' => $row['account_desc'],
    'account_user_id' => $row['account_user_id'],
    
  );
}

// Return accounts as JSON
header('Content-Type: application/json');
echo json_encode(array('accounts' => $accounts));

// Close database connection
mysqli_close($conn);
?>
