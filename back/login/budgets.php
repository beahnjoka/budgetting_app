<?php

include "config.php";

// User data to insert into database
$date = mysqli_real_escape_string($connect, $_POST['budget_date']);
$desc = mysqli_real_escape_string($connect, $_POST['budget_desc']);
$occurrence = mysqli_real_escape_string($connect, $_POST['budget_occurrence']);
$wef = mysqli_real_escape_string($connect, $_POST['budget_wef']);
$wet = mysqli_real_escape_string($connect, $_POST['budget_wet']);
$amount = mysqli_real_escape_string($connect, $_POST['budget_estimated_amount']);
$name = mysqli_real_escape_string($connect, $_POST['account_name']);

// Get user ID for the given mobile number
$query = "SELECT account_id FROM accounts WHERE account_name = '$name'";
$result = mysqli_query($connect, $query);

if (mysqli_num_rows($result) > 0) {
    // Fetch the user ID from the result
    $row = mysqli_fetch_assoc($result);
    $account_id = $row['account_id'];
    
    // Generate a unique identifier for budget_ref
    $ref = uniqid();

    // Insert the account details into the database
    $query = "INSERT INTO budget (budget_date, budget_ref, budget_desc, budget_occurrence, budget_wef,budget_wet,budget_estimated_amount,budget_accounts_id) 
    VALUES ( '$date', '$ref','$desc','$occurrence','$wef','$wet','$amount','$account_id')";
    $result = mysqli_query($connect, $query);

    if ($result) {
        echo json_encode("yey");
    } else {
        echo json_encode("nay");
    }
} else {
    echo json_encode("nay");
}

mysqli_close($connect);

?>
