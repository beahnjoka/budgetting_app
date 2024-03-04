<?php

include "config.php";

// User data to insert into database
$name = mysqli_real_escape_string($connect, $_POST['account_name']);
$amount = mysqli_real_escape_string($connect, $_POST['deposit_amount']);
//$code = mysqli_real_escape_string($connect, $_POST['deposit_code']);

// Generate deposit code
$code = uniqid(); // Generates a unique ID based on the current time in microseconds

// Set deposit date to current date
$date = date("Y-m-d"); // Sets date to current date in yyyy-mm-dd format

// Get user ID for the given account name
$query = "SELECT account_id FROM accounts WHERE account_name = '$name'";
$result = mysqli_query($connect, $query);

if (mysqli_num_rows($result) > 0) {
    // Fetch the user ID from the result
    $row = mysqli_fetch_assoc($result);
    $user_id = $row['account_id'];
    
    // Insert the account details into the database
    $query = "INSERT INTO deposits (deposit_amount, deposit_date, deposit_code, deposit_account_id) 
    VALUES ('$amount', '$date', '$code', $user_id)";
    $result = mysqli_query($connect, $query);

    if ($result) {
        echo json_encode("Success");
    } else {
        echo json_encode("Error inserting data");
    }
} else {
    echo json_encode("Account not found");
}

mysqli_close($connect);

?>
