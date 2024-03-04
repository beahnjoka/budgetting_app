<?php
// Database configuration
$servername = "localhost";
$username = "username";
$password = "password";
$dbname = "database_name";

// Create a database connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Select data from database
$sql = "SELECT login_username, login_rank FROM login";
$result = $conn->query($sql);

// Create CSV file
$filename = "data_export.csv";
$file = fopen($filename, "w");

// Add headers to CSV file
$headers = array("Column 1", "Column 2", "Column 3");
fputcsv($file, $headers);

// Add data to CSV file
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $data = array($row["column1"], $row["column2"], $row["column3"]);
        fputcsv($file, $data);
    }
}

// Close file and database connections
fclose($file);
$conn->close();

// Download CSV file
header("Content-type: text/csv");
header("Content-Disposition: attachment; filename=$filename");
readfile($filename);
unlink($filename); // delete the CSV file after download
?>
