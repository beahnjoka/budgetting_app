<?php

include "config.php";

// User data to insert into database
$name = mysqli_real_escape_string($connect, $_POST['login_username']);
$full_name = mysqli_real_escape_string($connect, $_POST['user_full_name']);
$email = mysqli_real_escape_string($connect, $_POST['user_email']);
$mobile = mysqli_real_escape_string($connect, $_POST['user_mobile']);

// $is_authenticated = false;

// Get login ID for the given username
$query = "SELECT login_id FROM login WHERE login_username = '$name'";
$result = mysqli_query($connect, $query);

if (mysqli_num_rows($result) > 0) {
    // Fetch the login ID from the result
    $row = mysqli_fetch_assoc($result);
    $login_id = $row['login_id'];


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
        // SQL query to insert user data into database
    $query = "INSERT INTO user (user_full_name, user_email, user_mobile, user_login_id) 
            VALUES ('$full_name', '$email', '$mobile', '$login_id')";

    // Execute SQL query
    if (mysqli_query($connect, $query)) {
        echo json_encode("success");
    } else {
        echo json_encode("Error: " . $query . "<br>" . mysqli_error($connect));
    }
} } 
else
{
    echo json_encode("Login ID not found for the given username");
}

// Close database connection
mysqli_close($connect);
?>
