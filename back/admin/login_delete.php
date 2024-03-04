<?php
// Establish database connection
$servername = "localhost";
$username = "your_username";
$password = "your_password";
$dbname = "your_database";
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Check if the delete button is clicked
if (isset($_POST['delete'])) {
    $id = $_POST['login_id'];
    $sql = "DELETE FROM login WHERE login_id=$id";

    if (mysqli_query($conn, $sql)) {
        $response = array(
            'error' => false,
            'message' => 'Entry deleted successfully',
        );
    } else {
        $response = array(
            'error' => true,
            'message' => 'Error deleting entry',
        );
    }

    // Return JSON response
    header('Content-Type: application/json');
    echo json_encode($response);
    exit;
}

// Close database connection
mysqli_close($conn);
?>
