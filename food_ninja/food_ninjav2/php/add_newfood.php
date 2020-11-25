<?php
include_once("dbconnect.php");
$foodname = $_POST['foodname'];
$foodprice = $_POST['foodprice'];
$foodqty = $_POST['foodqty'];
$restid = $_POST['restid'];
$imagename = $_POST['imagename'];
$encoded_string = $_POST["encoded_string"];

$decoded_string = base64_decode($encoded_string);
$path = '../images/foodimages/'.$imagename.'.jpg';
$is_written = file_put_contents($path, $decoded_string);

if ($is_written > 0) {
    $sqlregister = "INSERT INTO FOODS(FOODNAME,FOODPRICE,QUANTITY,IMAGENAME,RESTID) VALUES('$foodname','$foodprice','$foodqty','$imagename','$restid')";
    if ($conn->query($sqlregister) === TRUE){
        echo "succes";
    }else{
        echo "failed";
    }
}else{
    echo "failed";
}

?>