<?php
include "config.php";

// REGISTER USER
$name = mysqli_real_escape_string($connect, $_POST['login_username']);
$password = mysqli_real_escape_string($connect, $_POST['login_password']);

// Check if the username already exists
$query = "SELECT * FROM login WHERE login_username='$name'";
$results = mysqli_query($connect, $query);

if (mysqli_num_rows($results) > 0) {
    echo json_encode("Username found");
} else {
    // Hash the password
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // Set the rank of the new user
    $rank = ($name === 'admin') ? 'admin' : 'user';

    // Insert the new user into the database with the hashed password and rank
    $query = "INSERT INTO login (login_username, login_password, login_rank) VALUES ('$name', '$hashed_password', '$rank')";
    $results = mysqli_query($connect, $query);

    if ($results) {
        echo json_encode("success");
    } else {
        echo json_encode("Error adding user");
    }
}
?> 
