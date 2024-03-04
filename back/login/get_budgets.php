<?php
include "config.php";

// Query database for budget
$sql = 'SELECT * FROM budget';
$result = mysqli_query($connect, $sql);

if (!$result) {
  die('Error querying database: ' . mysqli_error($connect));
}

// Build array of budget
$budget = array();
while ($row = mysqli_fetch_assoc($result)) {
  // Fetch account name for budget account id
  $account_id = $row['budget_accounts_id'];
  $account_sql = "SELECT account_name FROM accounts WHERE account_id = '$account_id'";
  $account_result = mysqli_query($connect, $account_sql);
  $account_row = mysqli_fetch_assoc($account_result);
  $account_name = $account_row['account_name'];

  // Add budget data to array
  $budget[] = array(
    'budget_id' => $row['budget_id'],
    'budget_ref' => $row['budget_ref'],
    'budget_desc' => $row['budget_desc'],
    'budget_estimated_amount' => $row['budget_estimated_amount'],
    'budget_wef' => $row['budget_wef'],
    'budget_wet' => $row['budget_wet'],
    'account_name' => $account_name,
  );
}

// Return budget as JSON
header('Content-Type: application/json');
echo json_encode(array('budget' => $budget));

// Close database connection
mysqli_close($connect);
?>
