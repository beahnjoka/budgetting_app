<?php
include "config.php";

// Query database for accounts
$sql = 'SELECT * FROM checkouts';
$result = mysqli_query($connect, $sql);

if (!$result) {
  die('Error querying database: ' . mysqli_error($connect));
}

// Build array of accounts
$checkouts = array();
while ($row = mysqli_fetch_assoc($result)) {
  $checkouts[] = array(
    'checkout_id' => $row['checkout_id'],
    'checkout_amount' => $row['checkout_amount'],
    'checkout_date' => $row['checkout_date'],
    'checkout_budget_id' => $row['checkout_budget_id'],
    
  );
}

// Return accounts as JSON
header('Content-Type: application/json');
echo json_encode(array('checkouts' => $checkouts));

// Close database connection
mysqli_close($conn);
?>
