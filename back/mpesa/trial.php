<?php
//INCLUDE THE ACCESS TOKEN FILE
include 'accessToken.php';
date_default_timezone_set('Africa/Nairobi');
$processrequestUrl = 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest';
$callbackurl = 'https://kariukijames.com/pesa/callback.php';
$passkey = "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919";
$BusinessShortCode = '174379';
$Timestamp = date('YmdHis');
// ENCRIPT  DATA TO GET PASSWORD
$Password = base64_encode($BusinessShortCode . $passkey . $Timestamp);
$stkpushheader = ['Content-Type:application/json', 'Authorization:Bearer ' . $access_token];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  // Get form inputs and validate
  $phone = $_POST['phone'];
  $money = $_POST['amount'];

  if (!preg_match('/^254\d{9}$/', $phone)) {
    die("Invalid phone number");
  }

  if (!is_numeric($money) || $money <= 0) {
    die("Invalid amount");
  }

  $mobile = $phone;
  $PartyA = $mobile;
  $PartyB = '174379';
  $AccountReference = 'budgeting app';
  $TransactionDesc = 'stkpush test';
  $Amount = $money;

  // Make STK push request
  $curl = curl_init();
  curl_setopt($curl, CURLOPT_URL, $processrequestUrl);
  curl_setopt($curl, CURLOPT_HTTPHEADER, $stkpushheader); //setting custom header
  $curl_post_data = array(
    //Fill in the request parameters with valid values
    'BusinessShortCode' => $BusinessShortCode,
    'Password' => $Password,
    'Timestamp' => $Timestamp,
    'TransactionType' => 'CustomerPayBillOnline',
    'Amount' => $Amount,
    'PartyA' => $PartyA,
    'PartyB' => $PartyB,
    'PhoneNumber' => $PartyA,
    'CallBackURL' => $callbackurl,
    'AccountReference' => $AccountReference,
    'TransactionDesc' => $TransactionDesc
  );

  $data_string = json_encode($curl_post_data);
  curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($curl, CURLOPT_POST, true);
  curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
  $curl_response = curl_exec($curl);

  //ECHO  RESPONSE
  $data= json_decode($curl_response);
  $CheckoutRequestID = $data->CheckoutRequestID;
  $ResponseCode = $data->ResponseCode;
  
  if ($ResponseCode == "0") {
    // Successful STK push request, save transaction details to database
    // ...
    echo "The CheckoutRequestID for this transaction is : " . $CheckoutRequestID;
  } else {
    // STK push request failed, handle error
    // ...
    echo "STK push request failed with error code: " . $ResponseCode;
  }
} else {
  // STK push request failed, handle error
  // ...
  echo "STK push request failed with error code: " . $ResponseCode;
}

