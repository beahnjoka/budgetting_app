<?php

include "config.php";

// User data to insert or update in the database
$date = mysqli_real_escape_string($connect, $_POST['budget_date']);
$desc = mysqli_real_escape_string($connect, $_POST['budget_desc']);
$occurrence = mysqli_real_escape_string($connect, $_POST['budget_occurrence']);
$wef = mysqli_real_escape_string($connect, $_POST['budget_wef']);
$wet = mysqli_real_escape_string($connect, $_POST['budget_wet']);
$amount = mysqli_real_escape_string($connect, $_POST['budget_estimated_amount']);
$id = mysqli_real_escape_string($connect, $_POST['budget_id']);


// Get login ID for the given username
$query = "SELECT budget_id FROM budget WHERE budget_id = '$id'";
$result = mysqli_query($connect, $query);


        // Check if the user already exists in the database
        $query = "SELECT * FROM budget WHERE budget_id='$id'";
        $results = mysqli_query($connect, $query);

        if (mysqli_num_rows($results) == 1) {
            // Update user information in the database
            $query = "UPDATE budget SET budget_date='$date', budget_desc='$desc', budget_occurrence='$occurrence', budget_wef='$wef', budget_wet='$wet', budget_estimated_amount='$amount'
             WHERE budget_id='$id'";

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
