<?php

header('Content-Type: application/json');

// Read POST request body
$name = $_POST['login_username'];
$user_full_name = $_POST['user_full_name'];
$user_mobile = $_POST['user_mobile'];
$user_email = $_POST['user_email'];

// Connect to MySQL database
$conn = new mysqli('localhost', 'username', 'password', 'database_name');

// Check for errors
if ($conn->connect_error) {
  die('Connection failed: ' . $conn->connect_error);
}
// Get login ID for the given username
$query = "SELECT login_id FROM login WHERE login_username = '$name'";
$result = mysqli_query($connect, $query);

if (mysqli_num_rows($result) > 0) {
    // Fetch the login ID from the result
    $row = mysqli_fetch_assoc($result);
    $login_id = $row['login_id'];

// Prepare SQL statement
$stmt = $conn->prepare('UPDATE user SET user_full_name=?, user_mobile=?, user_email=? WHERE user_login_id=?');
$stmt->bind_param('sssi', $user_full_name, $user_mobile, $user_email, $login_id);

// Execute SQL statement
$result = $stmt->execute();
}
// Check for errors
if (!$result) {
$response = array('status' => 'error', 'message' => 'Failed to update user');
} else {
$response = array('status' => 'success', 'message' => 'User updated successfully');
}

// Close database connection
$stmt->close();
$conn->close();

// Send JSON response
echo json_encode($response);
?>
