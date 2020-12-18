<?php
error_reporting(0);
include_once("dbconnect.php");
$foodid = $_POST['foodid'];
$foodname = $_POST['foodname'];
$foodprice = $_POST['foodprice'];
$foodqty = $_POST['foodqty'];
$foodtype = $_POST['foodtype'];
$sqlupdate = "UPDATE FOODS SET FOODNAME = '$foodname', FOODPRICE = '$foodprice', QUANTITY = '$foodqty', TYPE = '$foodtype' WHERE FOODID = '$foodid'";
  if ($conn->query($sqlupdate) === TRUE){
      echo 'success';
  }else{
      echo 'failed';
  } 
?>