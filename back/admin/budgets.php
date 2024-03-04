<?php
include "config.php";

// Query database for accounts
$sql = 'SELECT * FROM budget';
$result = mysqli_query($connect, $sql);

if (!$result) {
  die('Error querying database: ' . mysqli_error($connect));
}

// Build array of accounts
$budget = array();
while ($row = mysqli_fetch_assoc($result)) {
  $budget[] = array(
    'budget_id' => $row['budget_id'],
    'budget_date' => $row['budget_date'],
    'budget_ref' => $row['budget_ref'],
    'budget_desc' => $row['budget_desc'],
    'budget_occurrence' => $row['budget_occurrence'],
    'budget_wef' => $row['budget_wef'],
    'budget_wet' => $row['budget_wet'],
    'budget_estimated_amount' => $row['budget_estimated_amount'],
    'budget_accounts_id' => $row['budget_accounts_id'],
    
  );
}

// Return accounts as JSON
header('Content-Type: application/json');
echo json_encode(array('budget' => $budget));

// Close database connection
mysqli_close($conn);
?>
