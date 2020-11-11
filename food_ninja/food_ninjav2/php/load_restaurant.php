<?php
error_reporting(0);
include_once("dbconnect.php");
$location = $_POST['location'];
$sql = "SELECT * FROM RESTAURANT WHERE LOCATION = '$location'"; 
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["rest"] = array();
    while ($row = $result ->fetch_assoc()){
        $restlist = array();
        $restlist[restid] = $row["ID"];
        $restlist[restname] = $row["NAME"];
        $restlist[restphone] = $row["PHONE"];
        $restlist[restlocation] = $row["LOCATION"];
        $restlist[restimage] = $row["IMAGE"];
        array_push($response["rest"], $restlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>