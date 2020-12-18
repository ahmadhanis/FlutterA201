<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$foodid = $_POST['foodid'];
$foodqty = $_POST['foodqty'];
$remarks = $_POST['remarks'];
$restid = $_POST['restid'];

$sqlrestidcheck ="SELECT * FROM CART WHERE EMAIL = '$email'";
$resultidcheck = $conn->query($sqlrestidcheck);
if ($resultidcheck->num_rows > 0) {
     while ($row = $resultidcheck ->fetch_assoc()){
         if ($row["RESTID"] != $restid ){
             $rid = $row["RESTID"];
             $sqldelete = "DELETE FROM FOODORDER WHERE EMAIL = '$email' AND RESTID= '$rid'";
             $conn->query($sqldelete);
         }
     }
}

$sqlcheck = "SELECT * FROM FOODORDER WHERE FOODID = '$foodid' AND EMAIL = '$email'";
$result = $conn->query($sqlcheck);
if ($result->num_rows > 0) {
    $sqlupdate = "UPDATE FOODORDER SET FOODQTY = '$foodqty' , REMARKS = '$remarks' WHERE FOODID = '$foodid' AND EMAIL = '$email'";
    if ($conn->query($sqlupdate) === TRUE){
       echo "success";
    }  
}
else{
    $sqlinsert = "INSERT INTO CART(EMAIL,FOODID,FOODQTY,REMARKS,RESTID) VALUES ('$email','$foodid','$foodqty','$remarks','$restid')";
    if ($conn->query($sqlinsert) === TRUE){
       echo "success";
    }    
}

?>