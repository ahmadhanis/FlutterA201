<?php
include_once("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);

$sqlregister = "INSERT INTO USER(NAME,EMAIL,PHONE,PASSWORD) VALUES('$name','$email','$phone','$password')";

if ($conn->query($sqlregister) === TRUE){
    echo "succes";
}else{
    echo "failed";
}
?>