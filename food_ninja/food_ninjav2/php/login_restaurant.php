<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);

$sqllogin = "SELECT * FROM RESTAURANT WHERE EMAIL = '$email' AND PASSWORD = '$password' AND OTP = '1'";
$result = $conn->query($sqllogin);

if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo $data = "success,".$row["ID"].",".$row["NAME"].",".$row["EMAIL"].",".$row["PHONE"].",".$row["LOCATION"].",".$row["IMAGE"].",".$row["DATEREG"];
    }
}else{
    echo "failed";
}

?>