<?php

include "config.php";

// User data to insert or update in the database
$id = mysqli_real_escape_string($connect, $_POST['user_id']);
$full_name = mysqli_real_escape_string($connect, $_POST['user_full_name']);
$email = mysqli_real_escape_string($connect, $_POST['user_email']);
$mobile = mysqli_real_escape_string($connect, $_POST['user_mobile']);

// Get login ID for the given username
$query = "SELECT user_id FROM user WHERE user_id = '$id'";
$result = mysqli_query($connect, $query);

if (mysqli_num_rows($result) > 0) {
    // Fetch the login ID from the result
    $row = mysqli_fetch_assoc($result);
    

    // Check if the user with the given email or mobile already exists
    $query = "SELECT * FROM user WHERE user_email='$email'";
    $results = mysqli_query($connect, $query);

    if (mysqli_num_rows($results) > 0) {
        echo json_encode("email found");
    }
    $query = "SELECT * FROM user WHERE user_mobile='$mobile'";
    $results = mysqli_query($connect, $query);

    if (mysqli_num_rows($results) > 0) {
        echo json_encode("mobile found");
    }
    else {
        // Check if the user already exists in the database
        $query = "SELECT * FROM user WHERE user_id='$id'";
        $results = mysqli_query($connect, $query);

        if (mysqli_num_rows($results) == 1) {
            // Update user information in the database
            $query = "UPDATE user SET user_full_name='$full_name', user_email='$email', user_mobile='$mobile' WHERE user_id='$id'";

            // Execute SQL query
            if (mysqli_query($connect, $query)) {
                echo json_encode("success");
            } else {
                echo json_encode("Error: " . $query . "<br>" . mysqli_error($connect));
            }
        } else {
            // Insert new user information into the database
            $query = "INSERT INTO user (user_full_name, user_email, user_mobile) 
                VALUES ('$full_name', '$email', '$mobile')";

            // Execute SQL query
            if (mysqli_query($connect, $query)) {
                echo json_encode("success");
            } else {
                echo json_encode("Error: " . $query . "<br>" . mysqli_error($connect));
            }
        }
    }
} else {
    echo json_encode("Login ID not found for the given username");
}

// Close database connection
mysqli_close($connect);
?>
