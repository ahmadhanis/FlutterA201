<?php
error_reporting(0);
include_once("dbconnect.php");
$restid = $_POST['restid'];
$type = $_POST['type'];

$sql = "SELECT * FROM FOODS WHERE RESTID = '$restid' AND TYPE = '$type'"; 
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["foods"] = array();
    while ($row = $result ->fetch_assoc()){
        $foodlist = array();
        $foodlist[foodid] = $row["FOODID"];
        $foodlist[foodname] = $row["FOODNAME"];
        $foodlist[foodprice] = $row["FOODPRICE"];
        $foodlist[foodqty] = $row["QUANTITY"];
        $foodlist[imgname] = $row["IMAGENAME"];
        $foodlist[status] = $row["STATUS"];
        array_push($response["foods"], $foodlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>