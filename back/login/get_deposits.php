<?php
include "config.php";

// Query database for accounts
$sql = 'SELECT * FROM deposits';
$result = mysqli_query($connect, $sql);

if (!$result) {
  die('Error querying database: ' . mysqli_error($connect));
}

// Build array of accounts
$deposits = array();
while ($row = mysqli_fetch_assoc($result)) {
  $deposits[] = array(
    
    'deposit_amount' => $row['deposit_amount'],
    'deposit_date' => $row['deposit_date'],
    
  );
}

// Return accounts as JSON
header('Content-Type: application/json');
echo json_encode(array('deposits' => $deposits));

// Close database connection
mysqli_close($conn);
?>
