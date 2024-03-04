<?php
include "config.php";

//log in an existing user
$username = $_POST['login_username'];
$password = $_POST['login_password'];
$result = $mysqli->query("SELECT * FROM login WHERE login_username='$username' AND login_password='$password'");
$user = $result->fetch_assoc();
if ($user) {
  $access_token = uniqid();
  $mysqli->query("INSERT INTO access_tokens (access_id, access_token) VALUES ('{$user['login_id']}', '$access_token')");
  echo $access_token;
}
