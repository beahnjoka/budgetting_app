<?php

include "config.php";

// User data to insert into database
$mobile = mysqli_real_escape_string($connect, $_POST['user_mobile']);
$name = mysqli_real_escape_string($connect, $_POST['account_name']);
$desc = mysqli_real_escape_string($connect, $_POST['account_desc']);

// Get user ID for the given mobile number
$query = "SELECT user_id FROM user WHERE user_mobile = '$mobile'";
$result = mysqli_query($connect, $query);

if (mysqli_num_rows($result) > 0) {
    // Fetch the user ID from the result
    $row = mysqli_fetch_assoc($result);
    $user_id = $row['user_id'];
    
    // Insert the account details into the database
    $query = "INSERT INTO accounts (account_name, account_desc, account_user_id) 
    VALUES ( '$name', '$desc','$user_id')";
    $result = mysqli_query($connect, $query);

    if ($result) {
        echo json_encode("yey");
    } else {
        echo json_encode("nay");
    }
} else {
    echo json_encode("account not found");
}

mysqli_close($connect);

?>