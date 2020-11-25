<?php
include_once("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$location = $_POST['location'];
$password = sha1($_POST['password']);
$imagename = $_POST['imagename'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);
$path = '../images/restaurantimages/'.$imagename.'.jpg';
$is_written = file_put_contents($path, $decoded_string);
$otp = rand(1000,9999);

if ($is_written > 0) {
    $sqlregister = "INSERT INTO RESTAURANT(NAME,EMAIL,PHONE,PASSWORD,LOCATION,IMAGE,OTP) VALUES('$name','$email','$phone','$password','$location','$imagename','$otp')";
    if ($conn->query($sqlregister) === TRUE){
        sendEmail($otp,$email);
        echo "succes";
    }else{
        echo "failed";
    }
}else{
    echo "failed";
}

function sendEmail($otp,$email){
    $from = "noreply@foodninjav2.com";
    $to = $email;
    $subject = "From Food Ninja V2. Verify your account";
    $message = "Use the following link to verify your account :"."\n http://slumberjer.com/foodninjav2/php/verify_account_rest.php?email=".$email."&key=".$otp;
    $headers = "From:" . $from;
    mail($email,$subject,$message, $headers);
}
?>