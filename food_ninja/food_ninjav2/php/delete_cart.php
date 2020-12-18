<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$foodid = $_POST['foodid'];
    $sqldelete = "DELETE FROM CART WHERE EMAIL = '$email' AND FOODID='$foodid'";
    if ($conn->query($sqldelete) === TRUE){
       echo "success";
    }else {
        echo "failed";
    }
?>