<?php
session_start(); // starts the session

include "config.php";

$name = mysqli_real_escape_string($connect, $_POST['login_username']);
$password = mysqli_real_escape_string($connect, $_POST['login_password']);

$query = "SELECT * FROM login WHERE login_username='$name'";

$results = mysqli_query($connect, $query);

if (mysqli_num_rows($results) == 1) {
    $row = mysqli_fetch_assoc($results);
    if (password_verify($password, $row['login_password'])) {
        // set session variables
        $_SESSION['user_id'] = $row['login_id'];
        $_SESSION['username'] = $row['login_username'];
        echo json_encode("success");
    } else {
        echo json_encode("Invalid username or password");
    }
} else {
    echo json_encode("Invalid username or password");
}
?>