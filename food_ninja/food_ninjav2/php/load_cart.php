<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

//$sql = "SELECT * FROM FOODORDER WHERE EMAIL = '$email'";

$sql = "SELECT FOODORDER.FOODID, FOODORDER.FOODQTY, FOODORDER.REMARKS, 
FOODORDER.RESTID, FOODS.FOODNAME, FOODS.IMAGENAME, FOODS.FOODPRICE, RESTAURANT.NAME FROM FOODORDER 
INNER JOIN FOODS ON FOODORDER.FOODID = FOODS.FOODID 
INNER JOIN RESTAURANT ON FOODORDER.RESTID = RESTAURANT.ID
WHERE FOODORDER.EMAIL = '$email'";


$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["cart"] = array();
    while ($row = $result ->fetch_assoc()){
        $cartlist = array();
        $cartlist[foodid] = $row["FOODID"];
        $cartlist[foodqty] = $row["FOODQTY"];
        $cartlist[remarks] = $row["REMARKS"];
        $cartlist[restid] = $row["RESTID"];
        $cartlist[foodname] = $row["FOODNAME"];
        $cartlist[foodprice] = $row["FOODPRICE"];
        $cartlist[imagename] = $row["IMAGENAME"];
        $cartlist[restname] = $row["NAME"];
        array_push($response["cart"], $cartlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>