<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

//$sql = "SELECT * FROM CART WHERE EMAIL = '$email'";

$sql = "SELECT CART.FOODID, CART.FOODQTY, CART.REMARKS, 
CART.RESTID, FOODS.FOODNAME, FOODS.IMAGENAME, FOODS.FOODPRICE, FOODS.QUANTITY, 
RESTAURANT.NAME, RESTAURANT.RADIUS, RESTAURANT.LATITUDE, RESTAURANT.LONGITUDE,
RESTAURANT.DELIVERY FROM CART 
INNER JOIN FOODS ON CART.FOODID = FOODS.FOODID 
INNER JOIN RESTAURANT ON CART.RESTID = RESTAURANT.ID
WHERE CART.EMAIL = '$email'";


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
        $cartlist[availqty] = $row["QUANTITY"];
        $cartlist[restradius] = $row["RADIUS"];
        $cartlist[restlat] = $row["LATITUDE"];
        $cartlist[restlon] = $row["LONGITUDE"];
        $cartlist[restdel] = $row["DELIVERY"];
        array_push($response["cart"], $cartlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>