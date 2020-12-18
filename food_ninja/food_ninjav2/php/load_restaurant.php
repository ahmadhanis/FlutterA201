<?php
error_reporting(0);
include_once("dbconnect.php");
$location = $_POST['location'];
$status = "OPEN";
$rating = $_POST['rating'];

if (isset($_POST['foodname'])){
$foodname = $_POST['foodname'];
 $sql ="SELECT DISTINCT RESTAURANT.ID,RESTAURANT.NAME,RESTAURANT.PHONE,RESTAURANT.LOCATION,RESTAURANT.IMAGE,
    RESTAURANT.RADIUS,RESTAURANT.LATITUDE,RESTAURANT.LONGITUDE,RESTAURANT.DELIVERY,RESTAURANT.RATING 
    FROM RESTAURANT INNER JOIN FOODS ON RESTAURANT.ID = FOODS.RESTID WHERE FOODS.FOODNAME LIKE '%$foodname%' 
    AND RESTAURANT.LOCATION = '$location' AND RESTAURANT.STATUS='$status'";
    
}else{
if ($_POST['rating'] == "Highest"){
    $sql = "SELECT * FROM RESTAURANT WHERE LOCATION = '$location' AND STATUS = '$status' ORDER BY RATING DESC";
}else{
    $sql = "SELECT * FROM RESTAURANT WHERE LOCATION = '$location' AND STATUS = '$status' ORDER BY RATING ASC";
}    
}


 
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["rest"] = array();
    $restidarray = array();
    $i = 0;
    while ($row = $result ->fetch_assoc()){
        $restlist = array();
        $restlist[restid] = $row["ID"];
        $restlist[restname] = $row["NAME"];
        $restlist[restphone] = $row["PHONE"];
        $restlist[restlocation] = $row["LOCATION"];
        $restlist[restimage] = $row["IMAGE"];
        $restlist[restradius] = $row["RADIUS"];
        $restlist[restlatitude] = $row["LATITUDE"];
        $restlist[restlongitude] = $row["LONGITUDE"];
        $restlist[restdelivery] = $row["DELIVERY"];
        $restlist[restrating] = $row["RATING"];
        $restidarray[$i] = $row["ID"];
        $i++;
        array_push($response["rest"], $restlist);
    }
    echo json_encode(array_unique($response));
}else{
    echo "nodata";
}
?>