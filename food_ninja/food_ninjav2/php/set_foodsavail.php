<?php
error_reporting(0);
include_once("dbconnect.php");
$foodid = $_POST['foodid'];
$status = $_POST['status'];

$sqlupdate = "UPDATE FOODS SET STATUS = '$status' WHERE FOODID = '$foodid'";
  if ($conn->query($sqlupdate) === TRUE){
      echo 'success';
  }else{
      echo 'failed';
  } 
?>