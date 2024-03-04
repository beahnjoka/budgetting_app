<?php

include "config.php";

// User data to insert or update in the database
$id = mysqli_real_escape_string($connect, $_POST['deposit_id']);
$amount = mysqli_real_escape_string($connect, $_POST['deposit_amount']);


// Get login ID for the given username
$query = "SELECT deposit_id FROM deposits WHERE deposit_id = '$id'";
$result = mysqli_query($connect, $query);


        // Check if the user already exists in the database
        $query = "SELECT * FROM deposits WHERE deposit_id='$id'";
        $results = mysqli_query($connect, $query);

        if (mysqli_num_rows($results) == 1) {
            // Update user information in the database
            $query = "UPDATE deposits SET  deposit_amount='$amount' WHERE deposit_id='$id'";

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
