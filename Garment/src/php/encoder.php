<?php

$encodedJPEGData = $_POST["encodedData"];
//Decode and save as a jpeg file
if ($encodedJPEGData != “”) {
   $binaryData = base64_decode($encodedJPEGData);
   file_put_contents(”test.jpeg”, $binaryData);
   $result = “SUCCESS”;
} else {
   //Some Error Occured
   $result = “ERROR”;
  }

//Send Result to Flex
echo $result;

?> 