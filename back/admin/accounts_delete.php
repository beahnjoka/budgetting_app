<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");

// Parse request parameters
$params = json_decode(file_get_contents('php://input'), true);
$account_id = $params['account_id'];

// Connect to database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "project";
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Prepare and execute SQL statement to delete login
$sql = "DELETE FROM accounts WHERE account_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $account_id);
if ($stmt->execute()) {
  echo json_encode(array('message' => 'Login deleted successfully'));
} else {
  echo json_encode(array('message' => 'Failed to delete login'));
}

// Close database connection
$conn->close();
?>
