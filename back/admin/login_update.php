<?php
include "config.php";

// Retrieve updated information from form
$login_id = $_POST['login_id'];
$name = mysqli_real_escape_string($connect, $_POST['login_username']);

// Verify current username
$query = "SELECT * FROM login WHERE login_id=$login_id";
$results = mysqli_query($connect, $query);

if (mysqli_num_rows($results) == 1) {
    $row = mysqli_fetch_assoc($results);
    // Update database
    $sql = "UPDATE login SET login_username='$name' WHERE login_id=$login_id";
    $result = mysqli_query($connect, $sql);

    if (!$result) {
      die('Error updating database: ' . mysqli_error($connect));
    }

    echo json_encode("success");
} else {
    echo json_encode("Invalid login ID");
}

// Close database connection
mysqli_close($connect);
?>
