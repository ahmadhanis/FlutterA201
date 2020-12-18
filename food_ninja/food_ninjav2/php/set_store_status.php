<?php
error_reporting(0);
include_once("dbconnect.php");
$restid = $_POST['restid'];
$status = $_POST['status'];

$sqlupdate = "UPDATE RESTAURANT SET STATUS = '$status' WHERE ID = '$restid'";
  if ($conn->query($sqlupdate) === TRUE){
      echo 'success';
  }else{
      echo 'failed';
  } 
?>