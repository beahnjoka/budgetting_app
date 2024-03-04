<?php

include "config.php";

// User data to insert or update in the database
$id = mysqli_real_escape_string($connect, $_POST['account_id']);
$name = mysqli_real_escape_string($connect, $_POST['account_name']);
$desc = mysqli_real_escape_string($connect, $_POST['account_desc']);


// Get login ID for the given username
$query = "SELECT account_id FROM accounts WHERE account_id = '$id'";
$result = mysqli_query($connect, $query);


        // Check if the user already exists in the database
        $query = "SELECT * FROM accounts WHERE account_id='$id'";
        $results = mysqli_query($connect, $query);

        if (mysqli_num_rows($results) == 1) {
            // Update user information in the database
            $query = "UPDATE accounts SET account_name='$name', account_desc='$desc' WHERE account_id='$id'";

            // Execute SQL query
            if (mysqli_query($connect, $query)) {
                echo json_encode("yey");
            } else {
                echo json_encode("Error: " . $query . "<br>" . mysqli_error($connect));
            }
        } 
    
 else {
    echo json_encode("Login ID not found for the given username");
}

// Close database connection
mysqli_close($connect);
?>
